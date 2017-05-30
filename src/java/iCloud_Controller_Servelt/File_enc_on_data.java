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
import java.io.PrintWriter;
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
@WebServlet(name = "File_enc_on_data", urlPatterns = {"/user/user-home/File_enc_on_data"})
@MultipartConfig(maxFileSize = 524288000) // upload file up to 500MB
public class File_enc_on_data extends HttpServlet {

    private static final long serialVersionUID = -1623656324694499109L;
    String constPass = null;
    String constPassTDES = null;
    InputStream inputstreamTDES = null;
    InputStream inputstreamAES = null;
    InputStream inputstreamRC4 = null;
    String fname = null;
    long fsize;
    String ftype = null;
    int folder_id;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Main_Class m_in = new Main_Class();
        HttpSession session = request.getSession(false);
        int user_id = Integer.parseInt(session.getAttribute("iCloud_user_id").toString());
        PrintWriter out = response.getWriter();
        try {
            Part file = request.getPart("upload_file");
            if (file != null) {
                inputstreamTDES = file.getInputStream();
                inputstreamAES = file.getInputStream();
                inputstreamRC4 = file.getInputStream();
                constPass = getServletContext().getInitParameter("staticValueKey");
                constPassTDES = getServletContext().getInitParameter("staticValue3DES");
                if (request.getParameter("fder_id") != null) {
                    String referer = request.getHeader("Referer");
                    int method = Integer.parseInt(request.getParameter("iCheck"));
                    folder_id = Integer.parseInt(request.getParameter("fder_id"));
                    fname = file.getSubmittedFileName();
                    ftype = file.getContentType();
                    fsize = file.getSize();
                    switch (method) {
                        case 1:
                            //3DES
                            Model_class mc1 = new Model_class();
                            mc1.setFile(inputstreamTDES);
                            mc1.setConstPassValue(constPassTDES);
                            mc1.setAlgorithm("DESede");
                            mc1.setKeysize(168);
                            mc1.setId(user_id);
                            mc1.setFilename(fname);
                            mc1.setFiletype(ftype);
                            mc1.setFilesize(fsize);
                            mc1.setFolderid(folder_id);
                            mc1.setMethod(method);
                            mc1.setStatus(true);
                            long TDESresult[] = m_in.fileEncryption(mc1);
                            if (TDESresult[0] != 0) {
                                
                                //response.sendRedirect(request.getContextPath() + "/user/user-home/");
                                response.sendRedirect(referer);
                            } else {
                                response.sendRedirect(referer+"?sucess=false");
                                //response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp?sucess=false");
                            }
                            break;
                        case 2:
                            //RC4
                            Model_class mc2 = new Model_class();
                            mc2.setFile(inputstreamRC4);
                            mc2.setConstPassValue(constPass);
                            mc2.setKeysize(256);
                            mc2.setAlgorithm("RC4");
                            mc2.setId(user_id);
                            mc2.setFilename(fname);
                            mc2.setFiletype(ftype);
                            mc2.setFilesize(fsize);
                            mc2.setFolderid(folder_id);
                            mc2.setMethod(method);
                            mc2.setStatus(true);
                            long RCFresult[] = m_in.fileEncryption(mc2);
                            if (RCFresult[0] != 0) {
                                 response.sendRedirect(referer);
                                //response.sendRedirect(request.getContextPath() + "/user/user-home/");
                            } else {
                                response.sendRedirect(referer+"?sucess=false");
                                //response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp?sucess=false");
                            }
                            break;
                        case 3:
                            //AES
                            Model_class mc = new Model_class();
                            mc.setFile(inputstreamAES);
                            mc.setKeysize(256);
                            mc.setAlgorithm("AES");
                            mc.setConstPassValue(constPass);
                            mc.setId(user_id);
                            mc.setFilename(fname);
                            mc.setFiletype(ftype);
                            mc.setFilesize(fsize);
                            mc.setFolderid(folder_id);
                            mc.setMethod(method);
                            mc.setStatus(true);
                            long AESresult[] = m_in.fileEncryption(mc);
                            if (AESresult[0] != 0) {
                                response.sendRedirect(referer);
                                //response.sendRedirect(request.getContextPath() + "/user/user-home/");
                            } else {
                                response.sendRedirect(referer+"?sucess=false");
                                //response.sendRedirect(request.getContextPath() + "/user/user-home/index.jsp?sucess=false");
                            }
                            break;
                    }

                } else {
                    //3DES
                    Model_class mc1 = new Model_class();
                    mc1.setFile(inputstreamTDES);
                    mc1.setConstPassValue(constPassTDES);
                    mc1.setAlgorithm("DESede");
                    mc1.setKeysize(168);
                    mc1.setStatus(false);
                    long TDESresult[] = m_in.fileEncryption(mc1);
                    //AES
                    Model_class mc = new Model_class();
                    mc.setFile(inputstreamAES);
                    mc.setKeysize(256);
                    mc.setAlgorithm("AES");
                    mc.setConstPassValue(constPass);
                    mc.setStatus(false);
                    long AESresult[] = m_in.fileEncryption(mc);
                    //RC4
                    Model_class mc2 = new Model_class();
                    mc2.setFile(inputstreamRC4);
                    mc2.setConstPassValue(constPass);
                    mc2.setKeysize(256);
                    mc2.setAlgorithm("RC4");
                    mc2.setStatus(false);
                    long RC4result[] = m_in.fileEncryption(mc2);
                    
                    String time_p = TDESresult[0] + "," + RC4result[0] + "," + AESresult[0];
                    String mem_p = TDESresult[1] + "," + RC4result[1] + "," + AESresult[1];
                    out.println(time_p + " " + mem_p);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
