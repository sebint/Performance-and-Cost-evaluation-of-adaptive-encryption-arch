/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Controller_Servelt;

import iCloud_Pack.Icloud_main;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import iCloud_Main.Main_Class;
import iCloud_Pack_modelClasses.Model_class;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

/**
 *
 * @author ZionZ
 */
@WebServlet(name = "File_download", urlPatterns = {"/user/user-home/File_download"})
public class File_download extends HttpServlet {

    private static final int BUFFER_SIZE = 4096;
    ByteArrayOutputStream outStream;
    InputStream dat;
    String fileid = null;
    String fileName = null;
    String method = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Icloud_main im = new Icloud_main();
            String encript_fid = request.getParameter("pfile_id");
            fileid = im.singleKeydecrypt(encript_fid, getServletContext().getInitParameter("staticValueKey"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        Model_class mc = new Model_class();
        Main_Class mclass = new Main_Class();
        mc.setFolderid(Integer.parseInt(fileid));
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
                ServletContext context = getServletContext();
                // sets MIME type for the file download
                String mimeType = context.getMimeType(fileName);
                if (mimeType == null) {
                    mimeType = "application/octet-stream";
                }
                // set content properties and header attributes for the response
                response.setContentType(mimeType);
                response.setContentLength(fileLength);
                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", fileName);
                response.setHeader(headerKey, headerValue);

                // writes the file to the client
                //
                if (method.equals("1")) {
                    mc.setAlgorithm("DESede");
                    String conKey = getServletContext().getInitParameter("staticValue3DES");
                    mc.setConstPassValue(conKey);
                    mc.setFile(inputStream_data);
                    mc.setKey(inputStream_key);
                    outStream = mclass.fileDecryption(mc);
                }
                if (method.equals("2")) {
                    mc.setAlgorithm("RC4");
                    String conKey = getServletContext().getInitParameter("staticValueKey");
                    mc.setConstPassValue(conKey);
                    mc.setFile(inputStream_data);
                    mc.setKey(inputStream_key);
                    outStream = mclass.fileDecryption(mc);
                }
                if (method.equals("3")) {
                    mc.setAlgorithm("AES");
                    String conKey = getServletContext().getInitParameter("staticValueKey");
                    mc.setConstPassValue(conKey);
                    mc.setFile(inputStream_data);
                    mc.setKey(inputStream_key);
                    outStream = mclass.fileDecryption(mc);
                }
                byte[] temp = outStream.toByteArray();
                dat = new ByteArrayInputStream(temp);
                OutputStream outStreamd = response.getOutputStream();
                byte[] buffer = new byte[BUFFER_SIZE];
                int bytesRead = -1;
                while ((bytesRead = dat.read(buffer)) != -1) {
                    outStreamd.write(buffer, 0, bytesRead);
                }
                inputStream_data.close();
                inputStream_key.close();
                outStreamd.close();
                outStream.close();
                dat.close();
            } else {
                // no file found
//                response.getWriter().print("File not found for the id: " + uploadId);
            }
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
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
