/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack;

import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

/**
 *
 * @author ZionZ
 */
public class DBConnect {

    Connection con;
    Statement smt;
    ResultSet rs;
    CallableStatement cs;
    String[] strArr = new String[2];

    public DBConnect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/db_icloud", "root", "");
            smt = con.createStatement();
        } catch (Exception ex) {
            System.out.println(ex);
        }

    }

    public ResultSet gettData(String sql) throws Exception {
        rs = smt.executeQuery(sql);
        return rs;

    }

    public int putData(String sql) throws Exception {
        int i = 0;
        i = smt.executeUpdate(sql);
        return i;

    }

    public ResultSet getData(String sql, int userId, int pfolder_id) {
        try {
            cs = con.prepareCall(sql);
            cs.setInt(1, userId);
            cs.setInt(2, pfolder_id);
            boolean isResultset = cs.execute();
            if (isResultset) {
                rs = cs.getResultSet();
            }

        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return rs;
    }

    public int iCloud_Register(String name, String email, String pass, int role) {
        Icloud_main im = new Icloud_main();
        try {
            strArr = im.encrypt(pass);
            cs = con.prepareCall("{CALL icloud_proc_register(?,?,?,?,?,?)}");
            cs.setInt(1, 0);
            cs.setString(2, name);
            cs.setString(3, email);
            cs.setString(4, strArr[0]);
            cs.setString(5, strArr[1]);
            cs.setInt(6, role);
            return cs.executeUpdate();
        } catch (SQLException sqlex) {
            return 0;
        } catch (Exception ex) {
            return 0;
        }
    }

    public ResultSet chk_User(String uname) {
        try {
            cs = con.prepareCall("{call icloud_chk_user(?)}");
            cs.setString(1, uname);
            cs.execute();
            rs = cs.getResultSet();
        } catch (SQLException sqlex) {
            System.out.println(sqlex);
        }
        return rs;
    }

    public ResultSet get_Profile_Info(int icloud_id) {
        try {
            cs = con.prepareCall("{CALL icloud_proc_profile_info(?)}");
            cs.setInt(1, icloud_id);
            boolean isResultset = cs.execute();
            if (isResultset) {
                rs = cs.getResultSet();
            }
        } catch (SQLException sqlex) {
            System.out.println(sqlex);
        }
        return rs;
    }

    public ResultSet get_Country() {
        try {
            cs = con.prepareCall("{CALL icloud_proc_get_country()}");
            boolean isResultset = cs.execute();
            if (isResultset) {
                rs = cs.getResultSet();
            }
        } catch (SQLException sqlex) {
            System.out.println(sqlex);
        }
        return rs;
    }

    public String get_Country_Name(int country_id) {
        String country_name = null;
        try {
            cs = con.prepareCall("{CALL icloud_proc_get_countryname(?,?)}");
            cs.setInt(1, country_id);
            cs.registerOutParameter(2, Types.VARCHAR);
            cs.execute();
            country_name = cs.getString(2);
            return country_name;
        } catch (SQLException sqlex) {
            System.out.println(sqlex);
        }
        return null;
    }

    public String get_State_Name(int state_id) {
        String state_name = null;
        try {
            cs = con.prepareCall("{CALL icloud_proc_get_statename(?,?)}");
            cs.setInt(1, state_id);
            cs.registerOutParameter(2, Types.VARCHAR);
            cs.execute();
            state_name = cs.getString(2);
            return state_name;
        } catch (SQLException sqlex) {
            System.out.println(sqlex);
        }
        return null;
    }

    public ResultSet get_State(int country_id) {
        try {
            cs = con.prepareCall("{CALL icloud_proc_get_state(?)}");
            cs.setInt(1, country_id);
            boolean isResultset = cs.execute();
            if (isResultset) {
                rs = cs.getResultSet();
            }
        } catch (SQLException sqlex) {
            System.out.println(sqlex);
        }
        return rs;
    }

    public ResultSet get_User_Info(int icloud_id) {
        try {
            cs = con.prepareCall("{call icloud_user_info(?)}");
            cs.setInt(1, icloud_id);
            boolean isResultset = cs.execute();
            if (isResultset) {
                rs = cs.getResultSet();

            }
        } catch (SQLException sqlex) {
            System.out.println(sqlex);
        }
        return rs;
    }

    public int createFolder(String foldername, int user_id, int PfolderId) {
        try {
            cs = con.prepareCall("{call icloud_proc_create_folder(?,?,?)}");
            cs.setString(1, foldername);
            cs.setInt(2, user_id);
            cs.setInt(3, PfolderId);
            boolean isSuccess = cs.execute();
            if (isSuccess) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public int uploadFile(InputStream file, String filename, String filetype, long filesize, int folderId, int userId) {
        try {
            cs = con.prepareCall("{call icloud_proc_upload_file(?,?,?,?,?,?)}");
            cs.setString(1, filename);
            cs.setString(2, filetype);
            cs.setLong(3, filesize);
            cs.setBlob(4, file);
            cs.setInt(5, folderId);
            cs.setInt(6, userId);
            int isSuccess = cs.executeUpdate();
            if (isSuccess >= 1) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public ResultSet getFile(int folder_id, int user_id) {
        try {
            cs = con.prepareCall("{call icloud_proc_get_file(?,?)}");
            cs.setInt(1, folder_id);
            cs.setInt(2, user_id);
            boolean isResultset = cs.execute();
            if (isResultset) {
                rs = cs.getResultSet();
            }

        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return rs;
    }

    public ResultSet getFile_OnType(int user_id, int type) {
        try {
            cs = con.prepareCall("{call icloud_proc_get_file_ontype(?,?)}");
            cs.setInt(1, user_id);
            cs.setInt(2, type);
            boolean isResultset = cs.execute();
            if (isResultset) {
                rs = cs.getResultSet();
            }
            return rs;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }

    public int getFileCount(int folder_id) {
        int count = 0;
        try {
            cs = con.prepareCall("{call icloud_proc_get_folder_file_count(?,?)}");
            cs.setInt(1, folder_id);
            cs.registerOutParameter(2, Types.INTEGER);
            cs.execute();
            count = cs.getInt(2);
            return count;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return count;
    }

    public long getFolderSize(int folder_id) {
        long size = 0;
        try {
            cs = con.prepareCall("{call icloud_proc_get_folder_total_size(?,?)}");
            cs.setInt(1, folder_id);
            cs.registerOutParameter(2, Types.INTEGER);
            cs.execute();
            size = cs.getInt(2);
            return size;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return size;
    }

    public int deleteFolder(int folder_id) {
        try {
            cs = con.prepareCall("{call icloud_proc_delete_folder(?)}");
            cs.setInt(1, folder_id);
            int isSuccess = cs.executeUpdate();
            if (isSuccess > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public String getFolderName(int folder_id) {
        try {
            cs = con.prepareCall("{call icloud_proc_get_folder_name(?,?)}");
            cs.setInt(1, folder_id);
            cs.registerOutParameter(2, Types.VARCHAR);
            cs.execute();
            return cs.getString(2);

        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }

    public String getFileName(int file_id) {
        try {
            cs = con.prepareCall("{call icloud_proc_get_file_name(?,?)}");
            cs.setInt(1, file_id);
            cs.registerOutParameter(2, Types.VARCHAR);
            cs.execute();
            return cs.getString(2);
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }

    public int renameFolder(int folder_id, String folder_name) {
        try {
            cs = con.prepareCall("{call icloud_proc_rename_folder(?,?)}");
            cs.setInt(1, folder_id);
            cs.setString(2, folder_name);
            int status = cs.executeUpdate();
            if (status > 0) {
                return 1;
            } else {
                return 0;
            }

        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public int deleteFile(int file_id) {
        try {
            cs = con.prepareCall("{call icloud_proc_delete_file(?)}");
            cs.setInt(1, file_id);
            int isSuccess = cs.executeUpdate();
            if (isSuccess > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public int renameFile(int file_id, String file_name) {

        String sam = null;
        try {

            rs = this.getFileProperties(file_id);
            while (rs.next()) {
                sam = rs.getString("icloud_file_name").replace(".", ",");
            }
            String[] temp = sam.split(",");
            file_name = file_name + "." + temp[1];
            cs = con.prepareCall("{call icloud_proc_rename_file(?,?)}");
            cs.setInt(1, file_id);
            cs.setString(2, file_name);
            int status = cs.executeUpdate();
            if (status > 0) {
                return 1;
            } else {
                return 0;
            }

        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public ResultSet getFileProperties(int fileid) {
        try {
            cs = con.prepareCall("{call icloud_proc_get_file_properties(?)}");
            cs.setInt(1, fileid);
            boolean isResultset = cs.execute();
            if (isResultset) {
                return cs.getResultSet();
            } else {
                return null;
            }
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }

    public int storeFile(InputStream input, InputStream key, String filename, String filetype, long filesize, int folderid, int userid, int method) {

        try {
            cs = con.prepareCall("{call icloud_proc_upload_file(?,?,?,?,?,?,?,?)}");
            cs.setBlob(2, key);
            cs.setBlob(1, input);
            cs.setString(3, filename);
            cs.setString(4, filetype);
            cs.setLong(5, filesize);
            cs.setInt(6, folderid);
            cs.setInt(7, userid);
            cs.setInt(8, method);
            int status = cs.executeUpdate();
            return status;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public int profileUpdate(int id, String fname, String mname, String lname, String gender, String dob, int country, int state, String phone) {
        try {
            cs = con.prepareCall("{CALL icloud_proc_update_profile(?,?,?,?,?,?,?,?,?)}");
            cs.setInt(1, id);
            cs.setString(2, fname);
            cs.setString(3, mname);
            cs.setString(4, lname);
            cs.setString(5, gender);
            cs.setString(8, dob);
            cs.setInt(6, country);
            cs.setInt(7, state);
            cs.setString(9, phone);
            int status = cs.executeUpdate();
            return status;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public int[] file_Count(int icloud_id) {
        int[] fileCount = new int[6];
        try {
            cs = con.prepareCall("{CALL icloud_proc_file_count(?,?,?,?,?,?,?)}");
            cs.setInt(1, icloud_id);
            cs.registerOutParameter(2, Types.INTEGER);
            cs.registerOutParameter(3, Types.INTEGER);
            cs.registerOutParameter(4, Types.INTEGER);
            cs.registerOutParameter(5, Types.INTEGER);
            cs.registerOutParameter(6, Types.INTEGER);
            cs.registerOutParameter(7, Types.INTEGER);
            cs.execute();
            fileCount[0] = cs.getInt(2);
            fileCount[1] = cs.getInt(3);
            fileCount[2] = cs.getInt(4);
            fileCount[3] = cs.getInt(5);
            fileCount[4] = cs.getInt(6);
            fileCount[5] = cs.getInt(7);
            return fileCount;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }

    public long[] file_totalsize(int icloud_id) {
        long[] filesize = new long[3];
        try {
            cs = con.prepareCall("{CALL icloud_proc_file_size(?,?,?,?)}");
            cs.setInt(1, icloud_id);
            cs.registerOutParameter(2, Types.BIGINT);
            cs.registerOutParameter(3, Types.BIGINT);
            cs.registerOutParameter(4, Types.BIGINT);
            cs.execute();
            filesize[0] = cs.getLong(2);
            filesize[1] = cs.getLong(3);
            filesize[2] = cs.getLong(4);
            return filesize;
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return null;
    }

    public int[] other_Count(int icloud_id) {
        int[] count_other = new int[10];
        try {
            cs = con.prepareCall("{CALL icloud_proc_other_count(?,?,?)}");
            cs.setInt(1, icloud_id);
            cs.registerOutParameter(2, Types.INTEGER);
            cs.registerOutParameter(3, Types.INTEGER);
            cs.execute();
            count_other[0] = cs.getInt(2);
            count_other[1] = cs.getInt(3);
            return count_other;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int passwordUpdate(int icloud_id, String[] encData) {
        try {
            cs = con.prepareCall("{CALL icloud_proc_update_password(?,?,?)}");
            cs.setInt(1, icloud_id);
            cs.setString(2, encData[0]);
            cs.setString(3, encData[1]);
            return cs.executeUpdate();
        } catch (SQLException sqlex) {
            sqlex.printStackTrace();
        }
        return 0;
    }

    public int deleteAccount(int icloud_id) {
        try {
            cs = con.prepareCall("{CALL icloud_proc_del_acc(?)}");
            cs.setInt(1, icloud_id);
            return cs.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int createAd() {
        try {
            cs = con.prepareCall("{CALL icloud_create_ad(?)}");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.execute();
            return cs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1;
    }

    public String[] dashBoard_r1() {
        String[] arr = new String[6];
        try {
            cs = con.prepareCall("{CALL icloud_proc_dashboard_r1(?,?,?,?)}");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.registerOutParameter(2, Types.INTEGER);
            cs.registerOutParameter(3, Types.INTEGER);
            cs.registerOutParameter(4, Types.DOUBLE);
            cs.execute();
            arr[0] = cs.getString(1);
            arr[1] = cs.getString(2);
            arr[2] = cs.getString(3);
            arr[3] = cs.getString(4);
            return arr;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int setActive(int icloud_id, int state) {
        try {
            cs = con.prepareCall("{CALL icloud_proc_setactive(?,?)}");
            cs.setInt(1, icloud_id);
            cs.setInt(2, state);
            return cs.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return 0;
        }
    }

    public ResultSet getYear(int st) {
        try {

            cs = con.prepareCall("{CALL icloud_proc_get_year(?)}");
            cs.setInt(1, st);
            boolean isResultset = cs.execute();
            if (isResultset) {
                return cs.getResultSet();
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int getFileGrowth(int year, int month) {
        try {
            cs = con.prepareCall("{CALL icloud_proc_dashboard_r22(?,?,?)}");
            cs.setInt(1, year);
            cs.setInt(2, month);
            cs.registerOutParameter(3, Types.INTEGER);
            cs.execute();
            return cs.getInt(3);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public int getUserGrowth(int year, int month) {
        try {
            cs = con.prepareCall("{CALL icloud_proc_dashboard_r2(?,?,?)}");
            cs.setInt(1, year);
            cs.setInt(2, month);
            cs.registerOutParameter(3, Types.INTEGER);
            cs.execute();
            return cs.getInt(3);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public ResultSet getAllUser() {
        try {
            cs = con.prepareCall("{CALL icloud_proc_get_all_users()}");
            boolean isResultset = cs.execute();
            if (isResultset) {
                return cs.getResultSet();
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int chkUser(String fname) {
         try {
            cs = con.prepareCall("{CALL icloud_chk_user_exists(?,?)}");
            cs.setString(1, fname);
            cs.registerOutParameter(2, Types.INTEGER);
            cs.execute();
            return cs.getInt(2);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }
}
