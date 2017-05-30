/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import iCloud_Main.Main_Class;
import iCloud_Pack_modelClasses.LoginAuthenticate;
import iCloud_Pack_modelClasses.LoginModel;
import iCloud_Pack_modelClasses.Model_class;
import java.io.IOException;
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
@WebServlet(name = "RegUser", urlPatterns = {"/user/RegUser"})
public class RegUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String name = request.getParameter("txt_name");
        String uname = request.getParameter("txt_email");
        String pass = request.getParameter("txt_pass");
        String r_pass = request.getParameter("txt_conpass");
        Model_class mc = new Model_class();
        if (pass.equals(r_pass)) {
            mc.setFname(name);
            mc.setMname(uname);
            mc.setPassword(pass);
            Main_Class m_class = new Main_Class();
            if (m_class.registerUser(mc)) {
                LoginModel logm = new LoginModel(uname, pass);
                logm.setUname(uname);
                logm.setPass(pass);
                LoginAuthenticate logauth = new LoginAuthenticate();
                int isValid_Id[] = logauth.userAuthentication(logm);
                if (isValid_Id[0] > 0) {
                    mc.setId(isValid_Id[0]);
                    m_class.setActive(mc);
                    session.setAttribute("iCloud_user_id", isValid_Id[0]);
                    response.sendRedirect(request.getContextPath() + "/user/user-home/");
                } else {
                    response.sendRedirect(request.getContextPath() + "/user/index.jsp?status=false");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/user/?user_create=0");
            }
        }
    }

}
