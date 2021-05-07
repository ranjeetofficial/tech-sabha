<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<div class="row ">
<%
PostDao pd=new PostDao(ConnectionProvider.getConnection());
List<Post> posts= pd.getAllPosts();

for(Post post:posts){
    %>
    
    <div class="col-md-4 mt-2">
            <div class="card">
                <img class="card-img-top" src="blog_pic/<%=post.getpPic()%>" alt="Card Image.." height="250px" >
                    <div class="card-body">
                        <h5 class="card-title">  <%= post.getpTitle() %></h5>
                    <a href="" class="btn btn-primary">Read more</a>
                </div>
            </div>
    </div>
<%
}
%>
</div>