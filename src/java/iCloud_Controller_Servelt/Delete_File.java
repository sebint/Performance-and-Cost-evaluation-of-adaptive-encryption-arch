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
@WebServlet(name = "Delete_File", urlPatterns = {"/user/user-home/Delete_File"})
public class Delete_File extends HttpServlet {

    String file_id = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Icloud_main im = new Icloud_main();
            String encript_fid = request.getParameter("encFileId_delete");
            file_id = im.singleKeydecrypt(encript_fid, getServletContext().getInitParameter("staticValueKey"));
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        Model_class mc = new Model_class();
        mc.setFolderid(Integer.parseInt(file_id));
        Main_Class m_in = new Main_Class();
        boolean status = m_in.deleteFile(mc);
        if (status) {
            response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp?file_delete=false");
        }
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
