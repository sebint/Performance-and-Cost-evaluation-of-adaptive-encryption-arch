/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import iCloud_Main.Main_Class;
import iCloud_Pack_modelClasses.Model_class;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "Password_Update", urlPatterns = {"/user/user-home/Password_Update"})
public class Password_Update extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int user_id=Integer.parseInt(session.getAttribute("iCloud_user_id").toString());
        String pass=request.getParameter("pass");
        String rpass=request.getParameter("repeat_pass");
        Model_class mc=new Model_class();
        if(pass.equals(rpass)){
            mc.setPassword(pass);
            mc.setId(user_id);
            Main_Class m_in=new Main_Class();
            if(m_in.passwordUpdate(mc)){
                response.sendRedirect(request.getContextPath() + "/user/user-home/manage_account.jsp");
            }else{
                response.sendRedirect(request.getContextPath() + "/user/user-home/manage_account.jsp?change_pass=0");
                
            }
            
        }
       
    }

}
