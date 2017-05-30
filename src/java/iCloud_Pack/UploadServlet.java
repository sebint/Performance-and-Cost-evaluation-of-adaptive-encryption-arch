/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "fileUpload", urlPatterns = {"/user/user-home/fileUpload", "/user/admin_home/fileUpload"})
@MultipartConfig(maxFileSize = 16177215) // upload file up to 16MB
public class UploadServlet extends HttpServlet {

    private static final long serialVersionUID = -1623656324694499109L;
    DBConnect dbcon = new DBConnect();

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        String referer = request.getHeader("Referer");
        HttpSession session = request.getSession(false);
        InputStream inputStream = null;
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("avatar_file");
        if (filePart != null) {
            // debug messages
            String fname = filePart.getName();
            int fsize = (int) filePart.getSize();
            String fcontent = filePart.getContentType();
            if (fcontent.equals("image/jpeg") || fcontent.equals("image/jpg") || fcontent.equals("image/png")) {

                // obtains input stream of the upload file
                inputStream = filePart.getInputStream();
                try {
                    if (inputStream != null) {
                        dbcon.cs = dbcon.con.prepareCall("{call icloud_proc_upload_dp(?,?)}");
                        dbcon.cs.setBlob(1, inputStream);
                        dbcon.cs.setInt(2, (Integer) session.getAttribute("iCloud_user_id"));
                    }
                    int row = dbcon.cs.executeUpdate();
                    if (row > 0) {
                        response.sendRedirect(referer);
                    }

                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            } else {
                request.setAttribute("message", "Invalid File Format(.jpg/,jpeg)");
                response.sendRedirect(referer);
                return;
            }
        }

    }

}
