package com.techblog.helper;
import java.sql.*;
public class ConnectionProvider {
    private static Connection con; 
    
    public static Connection getConnection(){
       
try{
            
    if(con==null)
        {
            //Loading the class Driver class here
            Class.forName("com.mysql.jdbc.Driver");
            //creating the connection
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","");        
        }        
   }
catch(Exception e)
   {
          e.printStackTrace();
   }
        
        
        
        return con;
        }
    }

