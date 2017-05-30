/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import iCloud_Pack_modelClasses.Model_class;
import iCloud_Main.Main_Class;
/**
 *
 * @author ZionZ
 */
@WebServlet(name = "Create_Folder", urlPatterns = {"/user/user-home/Create_Folder"})
public class Create_Folder extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String referer=null;
       HttpSession session = request.getSession(false);
       String foldername=request.getParameter("folder_name").trim();
       int parentFolderId=Integer.parseInt(request.getParameter("pfolder_id"));
       int user_id=Integer.parseInt(session.getAttribute("iCloud_user_id").toString());
       Model_class mc=new Model_class();
       mc.setFname(foldername);
       mc.setId(user_id);
       mc.setFolderid(parentFolderId);
       Main_Class m_in=new Main_Class();
       boolean isAffected=m_in.createFolder(mc);
       if(isAffected){
           referer = request.getHeader("Referer");
//            response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp");
            response.sendRedirect(referer);
       }else{
           referer = request.getHeader("Referer");
            //response.sendRedirect(referer);
         response.sendRedirect(referer+"?create_folder=false");
       }
    }

}
