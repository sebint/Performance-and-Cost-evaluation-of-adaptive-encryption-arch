/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import iCloud_Pack.DBConnect;
import iCloud_Pack.Icloud_main;
import java.sql.SQLException;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "ValReturn", urlPatterns = {"/user/user-home/ValReturn"})
public class ValReturn extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {      
        PrintWriter out = response.getWriter();
        String Typeid = request.getParameter("typeid");
        out.println(Typeid);
    }
}
