/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import iCloud_Main.Main_Class;
import iCloud_Pack_modelClasses.Model_class;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "Upload_File", urlPatterns = {"/user/user-home/Upload_File"})
@MultipartConfig(maxFileSize = 524288000) // upload file up to 500MB
public class Upload_File extends HttpServlet {

    private static final long serialVersionUID = -1623656324694499109L;
    InputStream inputstream = null;
    String fname = null;
    long fsize;
    String ftype = null;
    int folder_id;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String referer=null;
        HttpSession session = request.getSession(false);
        int user_id = Integer.parseInt(session.getAttribute("iCloud_user_id").toString());
        Part file = request.getPart("upload_file");
        folder_id = Integer.parseInt(request.getParameter("fder_id"));
        if (file != null) {
            fname = file.getSubmittedFileName();
            fsize = file.getSize();
            ftype = file.getContentType();
            inputstream = file.getInputStream();
        }
        Model_class mc = new Model_class();
        mc.setFile(inputstream);
        mc.setFilename(fname);
        mc.setFilesize(fsize);
        mc.setFiletype(ftype);
        mc.setFolderid(folder_id);
        mc.setId(user_id);
        Main_Class m_in = new Main_Class();
        boolean isAffected = m_in.uploadFile(mc);
        if (isAffected) {
            referer = request.getHeader("Referer");
//            response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp");
            response.sendRedirect(referer);
        } else {
            referer = request.getHeader("Referer");
            response.sendRedirect(referer+"?file_store=false");
        }

    }

}
