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
public class LoginModel {
    private String uname,pass;
    public LoginModel(String uname,String pass){
        this.uname=uname;
        this.pass=pass;
    }
    public String getUname(){
        return uname;
    }
    public void setUname(String uname){
        this.uname=uname;
    }
     public String getPass(){
        return pass;
    }
    public void setPass(String Pass){
        this.pass=pass;
    }
}
