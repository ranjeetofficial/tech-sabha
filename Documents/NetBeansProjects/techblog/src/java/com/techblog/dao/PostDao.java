
package com.techblog.dao;
import com.techblog.entities.Category;
import com.techblog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
   
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list=new ArrayList<>();
        
        try{
            
            String q="select * from categories";
            Statement st=this.con.createStatement();
            ResultSet set=st.executeQuery(q);
            while(set.next()){
                int cid=set.getInt("c_id");
                String name=set.getString("c_name");
                String description =set.getString("description");
                Category c=new Category(cid, name, description);
                list.add(c);
            }
            
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
     
            
        
        
        return list;
    }
    
    
       public boolean savePost(Post p){
            boolean f=false;
        
            try{
                    String q="insert into post(p_title,p_content,p_code,p_pic,c_id,user_id) values(?,?,?,?,?,?)";
                    PreparedStatement pstm=con.prepareStatement(q);
                    pstm.setString(1, p.getpTitle());
                    pstm.setString(2, p.getpContent());
                    pstm.setString(3, p.getpCode());
                    pstm.setString(4, p.getpPic());
                    pstm.setInt(5, p.getCatId());
                    pstm.setInt(6, p.getUserId());
                    
                    pstm.executeUpdate();
                    f=true;
            
            
            }catch(Exception  e){
                e.printStackTrace();
            }
            
            
            return f;
       }
       
       
       //get all the posts
       public List<Post> getAllPosts(){
           
          List <Post> list=new ArrayList<>(); 
           
          try{
              
              PreparedStatement p=con.prepareStatement("select * from post");
              
              ResultSet set=p.executeQuery();
              
              while(set.next()){
                  int pId=set.getInt("p_id");
                  String pTitle=set.getString("p_title");
                  String pContent=set.getString("p_content");
                  String pCode=set.getString("p_code");
                  String pPic=set.getString("p_pic");
                  Timestamp date =set.getTimestamp("p_date");
                  int cId=set.getInt("c_id");
                  int userId=set.getInt("user_id");
                  
                  //post variable to store that information coming from database...
                  Post post=new Post(pId, pTitle, pContent, pCode, pPic, date, cId, userId);
                  
                  list.add(post);
                  
              }
              
          }catch(Exception e){
              e.printStackTrace();
          }
          
          
          
          
          
          
           return list;
       }
       
       
      
       public List<Post> getPostByCatId(int catId){
           
            //get all the selected posts sort by the Category ID
             List <Post> list=new ArrayList<>(); 
           
             
             try{
              
              PreparedStatement p=con.prepareStatement("select * from post where c_id = ?");
              
              p.setInt(1, catId);
              ResultSet set=p.executeQuery();
              
              while(set.next()){
                  int pId=set.getInt("p_id");
                  String pTitle=set.getString("p_title");
                  String pContent=set.getString("p_content");
                  String pCode=set.getString("p_code");
                  String pPic=set.getString("p_pic");
                  Timestamp date =set.getTimestamp("p_date");
                  int userId=set.getInt("user_id");
                  
                  //post variable to store that information coming from database...
                  Post post=new Post(pId, pTitle, pContent, pCode, pPic, date, catId, userId);
                  
                  list.add(post);
                  
              }
              
          }catch(Exception e){
              e.printStackTrace();
          }
             
             
             
           return list;
           
       }
    
    
    
}
