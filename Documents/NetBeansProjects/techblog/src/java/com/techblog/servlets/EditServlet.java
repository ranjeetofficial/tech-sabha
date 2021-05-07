package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;  
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            
//            fetch all data
            String userEmail=request.getParameter("user_email");
            String userName=request.getParameter("user_name");
            String userPassword=request.getParameter("user_password");
            String userAbout=request.getParameter("user_about");
            Part part =request.getPart("user_image");
            String imageName=part.getSubmittedFileName();
            
            
            //get the user from the session
            
            HttpSession session=request.getSession();
            User user= (User)session.getAttribute("currentUser");
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFile=user.getProfile();
            user.setProfile(imageName);
                     
            UserDao userDuo=new UserDao(ConnectionProvider.getConnection());
                
            String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();

                String pathOldFile = request.getRealPath("/") + "pics" + File.separator + oldFile;
                
                if(path.equals(request.getRealPath("/") + "pics" + File.separator + "")){
                        user.setProfile(oldFile);
                }
                else
                {
                    if (!oldFile.equals("default.png")) {
                        Helper.deleteFile(pathOldFile);
                        Message msg = new Message("File Deleted...", "success", "alert-success");
                        session.setAttribute("msg", msg);
                    }
                }
                
                
            boolean ans = userDuo.updateUser(user);
            if (ans) {
                

                if (Helper.saveFile(part.getInputStream(), path)) {
                    Message msg = new Message("Profile details updated...", "success", "alert-success");
                    session.setAttribute("msg", msg);

                } else {
                    Message msg = new Message("Profile details updated...", "success", "alert-success");
                    session.setAttribute("msg", msg);
                }

            } 
            else {
                out.println("not updated..");
                Message msg = new Message("Something went wrong..", "error", "alert-danger");
                session.setAttribute("msg", msg);
            }

            response.sendRedirect("profile.jsp");

            out.println("</body>");
            out.println("</html>");
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
