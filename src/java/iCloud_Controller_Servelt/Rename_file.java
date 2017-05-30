/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import iCloud_Main.Main_Class;
import iCloud_Pack.Icloud_main;
import iCloud_Pack_modelClasses.Model_class;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "Rename_file", urlPatterns = {"/user/user-home/Rename_file"})
public class Rename_file extends HttpServlet {

   String fileid=null;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         try{
        Icloud_main im=new Icloud_main();
        //String encript_fid=request.getParameter("pfile_id");
        String encript_fid=request.getParameter("encFileId_rename");
        fileid=im.singleKeydecrypt(encript_fid,getServletContext().getInitParameter("staticValueKey")); 
           }catch(Exception e){
               e.printStackTrace();
           }
        Model_class mc=new Model_class();
        mc.setFolderid(Integer.parseInt(fileid));
        mc.setFname(request.getParameter("r_file_name"));
        Main_Class m_in=new Main_Class();
        boolean status=m_in.renameFile(mc);
        if(status){
             response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp");
         }else{
             response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp?folder_delete=false");
         }
        
    }

    

}
