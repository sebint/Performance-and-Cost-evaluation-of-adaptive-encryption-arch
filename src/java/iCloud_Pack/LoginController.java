/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack;

import iCloud_Main.Main_Class;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import iCloud_Pack_modelClasses.LoginModel;
import iCloud_Pack_modelClasses.LoginAuthenticate;
import iCloud_Pack_modelClasses.Model_class;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "LoginController", urlPatterns = {"/user/LoginController"})
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Model_class m_class=new Model_class();
        Main_Class mc=new Main_Class();
        HttpSession session = request.getSession(true);
        String uname = request.getParameter("txt_login_uname");
        String passwd = request.getParameter("txt_login_pass");
        LoginModel logm = new LoginModel(uname, passwd);
        logm.setUname(uname);
        logm.setPass(passwd);
        LoginAuthenticate logauth = new LoginAuthenticate();
        int isValid_Id[] = logauth.userAuthentication(logm);
        if (isValid_Id[0] > 0) {
            m_class.setId(isValid_Id[0]);
            mc.setActive(m_class);
            if(isValid_Id[1]==0){
            session.setAttribute("iCloud_user_id", isValid_Id[0]);
            response.sendRedirect(request.getContextPath() + "/user/user-home/");
            }
            if(isValid_Id[1]==1){
                 session.setAttribute("iCloud_user_id", isValid_Id[0]);
                 response.sendRedirect(request.getContextPath() + "/user/admin_home/");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/user/index.jsp?status=false");
        }
    }

}
