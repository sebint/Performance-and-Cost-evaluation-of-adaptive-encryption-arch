/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import iCloud_Main.Main_Class;
import iCloud_Pack.DBConnect;
import iCloud_Pack_modelClasses.Model_class;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Random;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "Reset_Pass", urlPatterns = {"/user/Reset_Pass"})
public class Reset_Pass extends HttpServlet {

    static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static Random rnd = new Random();
    DBConnect dbcon = new DBConnect();

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String referer = request.getHeader("Referer");

        Model_class mc = new Model_class();
        String uname = request.getParameter("txt_uname");
        mc.setFname(uname);
        Main_Class m_in = new Main_Class();
        if (m_in.chkUser(mc) > 0) {
            String rand_pass = randomString(8);
            try {
                ResultSet rs = dbcon.chk_User(uname);
                if (rs.next()) {
                    
                    mc.setPassword(rand_pass);
                    mc.setId(rs.getInt("icloud_id"));
                    if (m_in.passwordUpdate(mc)) {
                        response.sendRedirect(request.getContextPath() + "/user/password_reset.jsp?reset_pass=true");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/user/password_reset.jsp?reset_pass=false");
                    }
                } else {

                    response.sendRedirect(request.getContextPath() + "/user/password_reset.jsp?reset_pass=false");
                }
            } catch (SQLException ex) {
                ex.printStackTrace();

                response.sendRedirect(request.getContextPath() + "/user/password_reset.jsp?reset_pass=false");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/user/password_reset.jsp?user_exist=false");
        }
    }

    public String randomString(int len) {
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(AB.charAt(rnd.nextInt(AB.length())));
        }
        return sb.toString();
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
