/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;
import iCloud_Pack.Icloud_main;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import iCloud_Pack.DBConnect;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "PopupInfo", urlPatterns = {"/user/user-home/PopupInfo"})
public class PopupInfo extends HttpServlet {
String fileid=null;
String action=null;
Icloud_main im = new Icloud_main();
DBConnect dbcon=new DBConnect();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
       PrintWriter out=response.getWriter();
       fileid=request.getParameter("fileid");
       action=request.getParameter("action");
       if(action.equals("delete") || action.equals("rename"))
       {
          out.println(dbcon.getFileName(Integer.parseInt(im.singleKeydecrypt(fileid, getServletContext().getInitParameter("staticValueKey")))));
          
       }
       if(action.equals("properties")){
           session.setAttribute("jsdbviub893hdsnj", fileid);
           out.println(dbcon.getFileName(Integer.parseInt(im.singleKeydecrypt(fileid, getServletContext().getInitParameter("staticValueKey")))));
       }
    }

}
