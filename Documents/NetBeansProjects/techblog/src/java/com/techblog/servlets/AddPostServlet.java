

package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.entities.Message;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
               
                int cId=Integer.parseInt(request.getParameter("c_id"));
                String pTitle=request.getParameter("post_title");
                String pContent=request.getParameter("post_content");
                String pCode=request.getParameter("post_code");
                Part part=request.getPart("post_image");
                
                //Gettting the User from session ..........
                HttpSession session =request.getSession();
                User user=(User)session.getAttribute("currentUser");
                
                Post p=new Post(pTitle, pContent, pCode,part.getSubmittedFileName() , null, cId, user.getId());
                
                PostDao postDao=new PostDao(ConnectionProvider.getConnection());
                
                if(postDao.savePost(p)){
                    
                    String path=request.getRealPath("/")+"blog_pic"+File.separator+part.getSubmittedFileName();
                    Helper.saveFile(part.getInputStream(), path);
                    
                    Message msg=new Message("Post Added..", "success", "alert-success");
                    session.setAttribute("msg", msg);
                    
                    out.println("done");
                }  
                else{
                    out.println("error");
                }
             
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
