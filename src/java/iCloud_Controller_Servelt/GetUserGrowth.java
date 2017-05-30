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

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "GetUserGrowth", urlPatterns = {"/user/admin_home/GetUserGrowth"})
public class GetUserGrowth extends HttpServlet {

  
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String outData="";
        int[] icount=new int[13];
        PrintWriter out = response.getWriter();
        String year = request.getParameter("year");
        Model_class mc = new Model_class();
        Main_Class m_class = new Main_Class();
        mc.setYear(Integer.parseInt(year));
        try{
        for (int i = 1; i <=12; i++) {
            mc.setMonth(i);
            icount[i]=m_class.getUserGrowth(mc);           
        }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        outData=icount[1]+","+icount[2]+","+icount[3]+","+icount[4]+","+icount[5]+","+icount[6]+","+icount[7]+","+icount[8]+","+icount[9]+","+icount[10]+","+icount[11]+","+icount[12];
        out.println(outData);
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
