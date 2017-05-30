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
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "Action", urlPatterns = {"/user/user-home/Action"})
public class Action extends HttpServlet {

    String folderid=null;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           try{
        Icloud_main im=new Icloud_main();
        String encript_fid=request.getParameter("pfolder_id");
        folderid=im.singleKeydecrypt(encript_fid,getServletContext().getInitParameter("staticValueKey")); 
           }catch(Exception e){
               e.printStackTrace();
           }
           Model_class mc=new Model_class();
        mc.setFolderid(Integer.parseInt(folderid));
        mc.setFname(request.getParameter("r_folder_name"));
        Main_Class m_in=new Main_Class();
         boolean status=m_in.renameFolder(mc);
         if(status){
             response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp");
         }else{
             response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp?folder_delete=false");
         }
    }
}
