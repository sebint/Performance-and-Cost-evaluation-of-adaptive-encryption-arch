/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import iCloud_Pack.Icloud_main;
import iCloud_Pack_modelClasses.Model_class;
import iCloud_Main.Main_Class;
/**
 *
 * @author ZionZ
 */
@WebServlet(name = "Delete_Folder", urlPatterns = {"/user/user-home/Delete_Folder"})
public class Delete_Folder extends HttpServlet {
     String folderid=null;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
         //HttpSession session = request.getSession(false);
         Icloud_main im=new Icloud_main();
         String encript_fid=request.getParameter("pfolder_id");
         folderid=im.singleKeydecrypt(encript_fid,getServletContext().getInitParameter("staticValueKey")); 
        }catch(Exception ex){
            ex.printStackTrace();
        }
        Model_class mc=new Model_class();
        mc.setFolderid(Integer.parseInt(folderid));
        Main_Class m_in=new Main_Class();
        boolean status=m_in.deleteFolder(mc);
        if(status){
             response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp");
        }else{
            response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp?folder_delete=false");
        }
    }

    
}
