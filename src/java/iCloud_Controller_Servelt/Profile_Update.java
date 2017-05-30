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
@WebServlet(name = "Profile_Update", urlPatterns = {"/user/user-home/Profile_Update"})
public class Profile_Update extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int user_id = Integer.parseInt(session.getAttribute("iCloud_user_id").toString());
        String fname=request.getParameter("fname");
        String mname=request.getParameter("mname");
        String lname=request.getParameter("lname");
        String gender=request.getParameter("gender");
        String dob=request.getParameter("dob");
        String country=request.getParameter("country");
        String state=request.getParameter("state");
        String phone=request.getParameter("phone");
        Model_class mc = new Model_class();
        mc.setId(user_id);
        mc.setFname(fname);
        mc.setMname(mname);
        mc.setlname(lname);
        mc.setGender(gender);
        mc.setDob(dob);
        mc.setCountry(country);
        mc.setState(state);
        mc.setPhone(phone);
        Main_Class m_class=new Main_Class();
        boolean flag=m_class.profileUpdate(mc);
        if(flag){
            response.sendRedirect(request.getContextPath() + "/user/user-home/profile_user.jsp");
        }else{
            response.sendRedirect(request.getContextPath() + "/user/user-home/profile_user.jsp?sucess=false");
        }
                
    }
    @Override
    public String getServletInfo() {
        return "Updating User Profile!";
    }// </editor-fold>

}
