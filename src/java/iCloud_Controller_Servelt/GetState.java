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
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "GetState", urlPatterns = {"/user/user-home/GetState"})
public class GetState extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int i = 0;
        PrintWriter out = response.getWriter();
//        StringBuffer text = new StringBuffer();
//        String rst = null;
//        String output = "";
        int country_id = Integer.parseInt(request.getParameter("country_id"));
        Model_class mc = new Model_class();
        mc.setId(country_id);
        Main_Class m_in = new Main_Class();
        try {
            ResultSet rs = m_in.getState(mc);
            while (rs.next()) {
                out.println("<option value=\"" + rs.getString(1) + "\">" + rs.getString(2) + "</option>");

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
