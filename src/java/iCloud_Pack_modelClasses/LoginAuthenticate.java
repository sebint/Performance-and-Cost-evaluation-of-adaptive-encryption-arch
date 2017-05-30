/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack_modelClasses;

/**
 *
 * @author ZionZ
 */
import iCloud_Pack.DBConnect;
import iCloud_Pack.Icloud_main;
import java.sql.ResultSet;

public class LoginAuthenticate {

    ResultSet rs;
    DBConnect dbcon = new DBConnect();
    Icloud_main icm = new Icloud_main();
    int u_id;
    String u_pass = null;
    String u_key = null;
    int u_rle=0;

    public int[] userAuthentication(LoginModel logm) {
        int[] rarr=new int[2];
        rarr[0]=0;
        String username = logm.getUname();
        String Password = logm.getPass();
        try {
           
                rs = dbcon.chk_User(username);
                if(rs==null){
                    //System.out.println("resultset contin no rows");
                    return rarr;
                }else{
                while (rs.next()) {
                    u_id = rs.getInt("icloud_id");
                    u_pass = rs.getString("pass");
                    u_key = rs.getString("icloud_k");
                    u_rle=rs.getInt("role");
                }
                String decryptedStr = icm.decrypt(u_pass, u_key);
                if (Password.equals(decryptedStr)) {
                    rarr[0]=u_id;
                    rarr[1]=u_rle;
                    return rarr;
                } else {
                    
                    return rarr;
                }
                }
           
        } catch (Exception e) {
            e.printStackTrace();
        }
         return rarr;
    }
}
