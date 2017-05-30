/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import iCloud_Main.Main_Class;
import iCloud_Pack_modelClasses.Model_class;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
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
@WebServlet(name = "ImageView", urlPatterns = {"/user/user-home/ImageView"})
public class ImageView extends HttpServlet {

    private static final int BUFFER_SIZE = 4096;
    ByteArrayOutputStream outStream;
    InputStream dat;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fileName = null;
        String method = null;
        PrintWriter out = response.getWriter();
        int fileid = Integer.parseInt(request.getParameter("fileid"));
        Model_class mc = new Model_class();
        mc.setFolderid(fileid);
        Main_Class m_in = new Main_Class();
        ResultSet rs = m_in.downloadFile(mc);
        try {
            if (rs.next()) {
                fileName = rs.getString("icloud_file_name");
                method = rs.getString("icloud_enc_method");
                Blob blob_data = rs.getBlob("icloud_file_data");
                Blob blob_key = rs.getBlob("icloud_file_key");
                InputStream inputStream_data = blob_data.getBinaryStream();
                InputStream inputStream_key = blob_key.getBinaryStream();
                int fileLength = inputStream_data.available();

                if (method.equals("1")) {
                    mc.setAlgorithm("DESede");
                    String conKey = getServletContext().getInitParameter("staticValue3DES");
                    mc.setConstPassValue(conKey);
                    mc.setFile(inputStream_data);
                    mc.setKey(inputStream_key);
                    outStream = m_in.fileDecryption(mc);
                }
                if (method.equals("2")) {
                    mc.setAlgorithm("RC4");
                    String conKey = getServletContext().getInitParameter("staticValueKey");
                    mc.setConstPassValue(conKey);
                    mc.setFile(inputStream_data);
                    mc.setKey(inputStream_key);
                    outStream = m_in.fileDecryption(mc);
                }
                if (method.equals("3")) {
                    mc.setAlgorithm("AES");
                    String conKey = getServletContext().getInitParameter("staticValueKey");
                    mc.setConstPassValue(conKey);
                    mc.setFile(inputStream_data);
                    mc.setKey(inputStream_key);
                    outStream = m_in.fileDecryption(mc);
                }
                byte[] temp = outStream.toByteArray();
                dat = new ByteArrayInputStream(temp);
                int len = dat.available();
                byte[] rb = new byte[len];
                int index = dat.read(rb, 0, len);
                response.reset();
                response.setContentType("image/jpg");
                response.getOutputStream().write(rb, 0, len);
                response.getOutputStream().flush();

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
