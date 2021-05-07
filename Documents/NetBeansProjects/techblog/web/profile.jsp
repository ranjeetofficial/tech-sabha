

<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@page  errorPage="error_page.jsp" %>
<% User user = (User)session.getAttribute("currentUser"); 
if(user==null)
{
response.sendRedirect("login_page.jsp");
}
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>profile</title>
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
             clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 22% 91%, 0 99%, 0 0);
            }
        </style>
    </head>
    <body>
       <!--Start Navbar-->
   <nav class="navbar navbar-expand-lg navbar-dark primary-background" >
    <a class="navbar-brand " href="index.jsp"> <span class="fa fa-newspaper-o "></span>   Tech Blog</a>
    
    
    
    <button class="navbar-toggler " type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse   d-flex-sm flex-row-sm justify-content-between " id="navbarSupportedContent">
        <ul class="navbar-nav  ">
            <li class="nav-item active mt-1 " >
                    <form class="form-inline md-start d-flex flex-row justify-content-center text-center">
                        <input class="form-control mr-sm-2 form-control-sm " type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline btn-secondary my-1 my-sm-0 btn-sm " type="submit">Search</button>
                    </form>
            </li>
        </ul>
        <ul class="navbar-nav d-flex-sm flex-column-sm align-items-center" >
            <li class="nav-item dropdown " >
                <a class="nav-link dropdown-toggle " href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="  fa fa-check-square-o"></span> Categories
                </a>
                <div class="dropdown-menu " aria-labelledby="navbarDropdown">
                    <a class="dropdown-item " href="#">Programming Language</a>
                    <a class="dropdown-item " href="#">Project Implementation</a>
                    <div class="dropdown-divider "></div>
                    <a class="dropdown-item " href="#">Data Structure</a>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link " href="#"> <span class=" fa fa-address-card-o"></span> Contact</a>
            </li>
            
            
            
            <li class="nav-item ">
                <a class="nav-link " data-toggle="modal" data-target="#add-post-modal" href="#"> <span class="fa fa-newspaper-o"></span> Post</a>
            </li>
            

   
      
       
        
        
        
        
        
       
            <li class="nav-item">
                        <a class="nav-link " href="#!" data-toggle="modal" data-target="#profile-modal"> <span class="fa fa-user-circle "></span> <%= user.getName()%> </a>
            </li>
           
     
            <li class="nav-item">
                <a class="nav-link " href="LogoutServlet"> <span class="fa fa-sign-out "></span> logout</a>
            </li>
        </ul>
        
        
        
    </div>
</nav>
       <!--End Navbar-->        
     <%
                                Message m = (Message) session.getAttribute("msg");
                                if (m != null) {
                            %>
                            <div class="alert <%= m.getCssClass() %>" role="alert">
                                <%= m.getContent() %>
                            </div> 


                            <%        
                                    session.removeAttribute("msg");
                                }

                            %>
       
       <!--Main Starts from Here... -->
       
    <main>
        <div class="container">
            <div class="row mt-4">
                <div class="col-md-3" >
                <ul class="position-fixed list-group text-center">
                    <a href="#" class=" list-group-item list-group-item-action active ">
                        All Categories
                    </a>
                    <%
                    PostDao postDao1=new PostDao(ConnectionProvider.getConnection());
                    ArrayList<Category> List1 = postDao1.getAllCategories();
                    
                    for( Category c:List1 ){
                        
                     %> 
                     <a href="#" class="list-group-item list-group-item-action ">
                        <%=c.getcName() %>
                    </a>
                     <% 
                    }
                    %>
                   
                    </ul>

                </div>
                    <div class="col-md-9 " id="post-container">
                    <div class="container text-center" id="loader">
                        <i class="fa fa-refresh fa fa-3x fa-spin "></i>
                        <h3 class="mt-3">Loading...</h3>
                    </div>
                </div>
            </div>
            
        </div>
    </main>
       
       <!--Main Ends Here... -->
       
       <!--Start Modal -->

<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background text-white">
        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="container  text-center">
              <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:50% ;max-width:100px" >
              <br>
              <h5 class="modal-title m-3" id="nameHeaderLabel"><%= user.getName() %></h5>
              
              <!--details showing-->
              <div id="profile-details">
                  
              <table class="table">
                  
                  <tbody>
                      <tr>
                          <th scope="row">ID</th>
                          <td><%= user.getId() %></td>
                         
                      </tr>
                      <tr>
                          <th scope="row">Name</th>
                          <td> <%=user.getName() %> </td>
                         
                      </tr>
                      <tr>
                          <th scope="row">Email</th>
                          <td><%= user.getEmail() %></td>
                          
                      </tr>
                      <tr>
                          <th scope="row">About</th>
                          <td> <%= user.getAbout()%>   </td>
                      </tr>
                      <tr>
                          <th scope="row">Registration on:</th>
                          <td> <%= user.getDateTime().toString() %>   </td>
                      </tr>
                  
                  
                  
                  </tbody>
              </table>
                  
              </div>
             
                          <!--profile edit-->

                          <div id="profile-edit" style="display:none ;">
                              <h3 class="mt-2">Please Edit Carefully</h3>
                              <form action="EditServlet" method=post enctype="multipart/form-data">
                                  <table class="table">
                                      <tr>
                                          <td>ID :</td>
                                          <td><%= user.getId()%></td>
                                      </tr>
                                      <tr>
                                          <td>Email :</td>
                                          <td> <input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>" > </td>
                                      </tr>
                                      <tr>
                                          <td>Name :</td>
                                          <td> <input type="text" class="form-control" name="user_name" value="<%= user.getName()%>" > </td>
                                      </tr>
                                      <tr>
                                          <td>Password :</td>
                                          <td> <input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>" > </td>
                                      </tr>
                                      <tr>
                                          <td>Gender :</td>
                                          <td> <%= user.getGender().toUpperCase()%> </td>
                                      </tr>
                                      <tr>
                                          <td>About  :</td>
                                          <td>
                                              <textarea rows="3" class="form-control" name="user_about" ><%= user.getAbout()%>
                                              </textarea>

                                          </td>
                                      </tr>
                                      <tr>
                                          <td>New Profile:</td>
                                          <td>
                                              <input type="file" name="user_image" class="form-control" >
                                          </td>
                                      </tr>

                                  </table>

                                  <div class="container">
                                      <button type="submit" class="btn btn-outline-primary">Save</button>
                                  </div>

                              </form>    

                          </div>
          </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="edit-profile-button">Edit</button>
      </div>
    </div>
  </div>
</div>
       <!--End Modal-->
       
           <!--Start add-post-modal-->  

<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header modal-header primary-background text-white">
        <h5 class="modal-title" id="exampleModalLabel">Provide the Post Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
          <form id="add-post-form" action="AddPostServlet" method="post"> 
        
               <div class="form-group">
                   <select class="form-control" name="c_id">
                       <option selected disabled>---Select Category---</option>    
                  <% 
                  PostDao postdao=new PostDao(ConnectionProvider.getConnection());
                  ArrayList<Category> list= postdao.getAllCategories();
                  
                  for(Category c:list){
                  %>
                  <option value="<%= c.getcId() %>"><%=c.getcName() %></option>
             
                  <% }%> 
                   
                   </select>
              </div>
              
              <div class="form-group">
                  <input type="text" name="post_title" placeholder="Enter Post Title" class="form-control">
              </div>
                  
              <div class="form-group">
                  <textarea rows="4" name="post_content" class="form-control" placeholder="Enter Content Here.."></textarea>
              </div>
              
              <div class="form-group">
                  <textarea rows="4" name="post_code" class="form-control" placeholder="Enter Code Here(if Any).."></textarea>
              </div>
              <label>Choose Image Here</label>
              <div class="form-group">
                  <input type="file" name="post_image">
              </div>
              <div class="container">
                  <button class="btn btn-outline-primary" type="submit" >post</button>
              </div>
              
          </form>
          
          
          
          
          
      </div>
      
    </div>
  </div>
</div>
          
           <!--End add-post-modal-->
       
       
       
       
       
       
       
       
       
       
       
       <!--JavaScript-->
        <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
            crossorigin="anonymous">
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        
        
        <script>
            $(document).ready(function(){
                let editStatus=false;
        $("#edit-profile-button").click(function(){
                    if(editStatus==false){
                            $("#profile-details").hide();
                            $("#profile-edit").show();
                            editStatus=true;
                        }
                    else{
                            $("#profile-details").show();
                            $("#profile-edit").hide();
                            editStatus=false;
                    }
    
    });
            });
            
            
        </script>
        <!-- Start JavaScript-->
        
        <script>
            $(document).ready(function(e){
                $("#add-post-form").on("submit",function(event){
                    
                    event.preventDefault();
                    let form =new FormData(this);
                    
                    $.ajax({
                        url:"AddPostServlet",
                        type:'POST',
                        data:form,
                        success: function (data, textStatus, jqXHR) {
                            if(data.trim()=="done"){
                                swal("Success" , "Post Added Successfully", "success");
                                $("#add-post-modal").modal('hide');
                            }else{
                                swal("Error!!", "Something Went Wrong", "error");
                            }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                         console.log(jqXHR);
                    },
                    processData: false,
                    contentType: false
                    })
                    
                    
                    
                })
            })
        </script>
        
        <script>
            $(document).ready(function(e){
                $.ajax({
                    url: "load_posts.jsp",
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").html(data);
                        
        
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("error");
                    }
                })
                
                
                
            })
        </script>
        
        
        
        
        <!-- End JavaScript-->          
        
        
        
    </body>
</html>
