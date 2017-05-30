/*

 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Main;

import iCloud_Pack_modelClasses.Model_class;
import iCloud_Pack.DBConnect;
import iCloud_Pack.Icloud_main;
import java.io.InputStream;
import java.sql.ResultSet;
import iCloud_Pack.Security_Enc;
import java.io.ByteArrayOutputStream;
import java.sql.SQLException;

/**
 *
 * @author ZionZ
 */
public class Main_Class {

    DBConnect dbcon = new DBConnect();
    int row;

    public boolean registerUser(Model_class mc) {
        String name = mc.getFname();
        String email = mc.getMname();
        String pass = mc.getPassword();
        int status = dbcon.iCloud_Register(name, email, pass, 0);
        if (status > 0) {
            return true;
        } else {
            return false;
        }
    }

    public boolean createFolder(Model_class mc) {
        String foldername = mc.getFname();
        int user_id = mc.getId();
        int PfolderId = mc.getFolderid();
        row = dbcon.createFolder(foldername, user_id, PfolderId);
        if (row == 1) {
            return false;
        } else {
            return true;
        }
    }

    public boolean uploadFile(Model_class mc) {
        InputStream file = mc.getFile();
        String fname = mc.getFilename();
        long fsize = mc.getFilesize();
        String ftype = mc.getFiletype();
        int folderid = mc.getFolderid();
        int userid = mc.getId();
        int status = dbcon.uploadFile(file, fname, ftype, fsize, folderid, userid);
        if (status == 1) {
            return true;
        } else {
            return false;
        }
    }

    public boolean deleteFolder(Model_class mc) {
        int folderid = mc.getFolderid();
        int status = dbcon.deleteFolder(folderid);
        if (status == 1) {
            return true;
        } else {
            return false;
        }
    }

    public boolean renameFolder(Model_class mc) {
        int folderid = mc.getFolderid();
        String foldername = mc.getFname();
        int status = dbcon.renameFolder(folderid, foldername);
        if (status > 0) {
            return true;
        } else {
            return false;
        }

    }

    public boolean deleteFile(Model_class mc) {
        int fileid = mc.getFolderid();
        int status = dbcon.deleteFile(fileid);
        if (status == 1) {
            return true;
        } else {
            return false;
        }
    }

    public boolean renameFile(Model_class mc) {
        int fileid = mc.getFolderid();
        String foldername = mc.getFname();
        int status = dbcon.renameFile(fileid, foldername);
        if (status > 0) {
            return true;
        } else {
            return false;
        }
    }

    public ResultSet downloadFile(Model_class mc) {

        int fileid = mc.getFolderid();
        return dbcon.getFileProperties(fileid);

    }

    public long[] fileEncryption(Model_class mc) {
        Security_Enc enc;
        InputStream file = mc.getFile();
        String constPass = mc.getConstPassValue();
        String Algorithm = mc.getAlgorithm();
        int keysize = mc.getKeysize();
        String fname = mc.getFilename();
        long fsize = mc.getFilesize();
        String ftype = mc.getFiletype();
        int folderid = mc.getFolderid();
        int userid = mc.getId();
        int method = mc.getMethod();
        boolean status = mc.getStatus();

        if (status) {
            enc = new Security_Enc(Algorithm, keysize, fname, ftype, fsize, folderid, userid, method, status);
        } else {
            enc = new Security_Enc(Algorithm, keysize, status);
        }
        long AEStime[] = enc.encryptFile(file, constPass);
        return AEStime;
    }

    public ByteArrayOutputStream fileDecryption(Model_class mc) {
        String algorithm = mc.getAlgorithm();
        InputStream data = mc.getFile();
        InputStream key = mc.getKey();
        String contKey = mc.getConstPassValue();
        Security_Enc dec = new Security_Enc(algorithm);
        return dec.decryptFile(data, contKey, key);
    }

    public ResultSet getState(Model_class mc) {
        int country_id = mc.getId();
        return dbcon.get_State(country_id);
    }

    public boolean profileUpdate(Model_class mc) {
        int rowAffectd = dbcon.profileUpdate(mc.getId(), mc.getFname(), mc.getMname(), mc.getlname(), mc.getGender(), mc.getDob(), Integer.parseInt(mc.getCountry()), Integer.parseInt(mc.getState()), mc.getPhone());
        if (rowAffectd > 0) {
            return true;
        } else {
            return false;
        }

    }

    public boolean passwordUpdate(Model_class mc) {
        Icloud_main im = new Icloud_main();
        try {
            String[] EncData = im.encrypt(mc.getPassword());
            int status = dbcon.passwordUpdate(mc.getId(), EncData);
            if (status > 0) {
                return true;
            } else {
                return false;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean deleteAccount(Model_class mc) {
        try {
            int status = dbcon.deleteAccount(mc.getId());
            if (status > 0) {
                return true;
            } else {
                return false;
            }

        } catch (Exception ex) {

        }
        return false;
    }

    public boolean setActive(Model_class mc) {
        int status = dbcon.setActive(mc.getId(), 0);
        if (status > 0) {
            return true;
        } else {
            return false;
        }
    }

    public int getFileGrowth(Model_class mc) {
        return dbcon.getFileGrowth(mc.getYear(), mc.getMonth());
    }

    public int getUserGrowth(Model_class mc) {
        return dbcon.getUserGrowth(mc.getYear(), mc.getMonth());
    }

    public int chkUser(Model_class mc) {
        return dbcon.chkUser(mc.getFname());
    }
}
