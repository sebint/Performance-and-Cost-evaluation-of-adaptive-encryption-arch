/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "ImageRetrieveServlet", urlPatterns = {"/user/user-home/ImageRetrieveServlet","/user/admin_home/ImageRetrieveServlet"})
public class ImageRetrieveServlet extends HttpServlet {

    DBConnect dbcon = new DBConnect();
    ResultSet rs;
    String imgLen = "";
    private static final long serialVersionUID = 6290659385134794998L;

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    public void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        String icloud_id;
        icloud_id = request.getParameter("icloud_id");
        try {
            dbcon.cs = dbcon.con.prepareCall("{call icloud_proc_get_dp(?)}");
            dbcon.cs.setInt(1,Integer.parseInt(icloud_id));
            boolean isResultset = dbcon.cs.execute();
            if (isResultset) {
                rs = dbcon.cs.getResultSet();
            }
            if (rs.next()) {
                imgLen = rs.getString(1);
                int len = imgLen.length();
                byte[] rb = new byte[len];
                InputStream readImg = rs.getBinaryStream(1);
                int index = readImg.read(rb, 0, len);
                response.reset();
                response.setContentType("image/jpg");
                response.getOutputStream().write(rb, 0, len);
                response.getOutputStream().flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
