/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack_modelClasses;

import java.io.InputStream;

/**
 *
 * @author ZionZ
 */
public class Model_class {

    private String foldername = null;
    private String constPass = null;
    private int user_id;
    private InputStream file;
    private InputStream key;
    private String fname = null;
    private long fsize;
    private String ftype = null;
    private int folderid;
    private boolean n_upload;
    private int keySize;
    private String Algrithmname;
    private int method;
    private String mname;
    private String lname;
    private String gender;
    private String dob;
    private String country;
    private String state;
    private String phone;
    private String password;
    private int year;
    private int month;

    public int getMonth(){
        return month;
    }
    public void setMonth(int month){
        this.month=month;
    }
    public int getYear(){
        return year;
    }
    public void setYear(int year){
        this.year=year;
    }
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getlname() {
        return lname;
    }

    public void setlname(String lname) {
        this.lname = lname;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFname() {
        return foldername;
    }

    public int getId() {
        return user_id;
    }

    public void setFname(String foldername) {
        this.foldername = foldername;
    }

    public void setId(int user_id) {
        this.user_id = user_id;
    }

    public InputStream getFile() {
        return file;
    }

    public void setFile(InputStream file) {
        this.file = file;
    }

    public InputStream getKey() {
        return key;
    }

    public void setKey(InputStream key) {
        this.key = key;
    }

    public String getFilename() {
        return fname;
    }

    public void setFilename(String fname) {
        this.fname = fname;
    }

    public long getFilesize() {
        return fsize;
    }

    public void setFilesize(long fsize) {
        this.fsize = fsize;
    }

    public String getFiletype() {
        return ftype;
    }

    public void setFiletype(String ftype) {
        this.ftype = ftype;
    }

    public int getFolderid() {
        return folderid;
    }

    public void setFolderid(int folderid) {
        this.folderid = folderid;
    }

    public void setConstPassValue(String constPass) {
        this.constPass = constPass;
    }

    public String getConstPassValue() {
        return constPass;
    }

    public int getKeysize() {
        return keySize;
    }

    public void setKeysize(int keySize) {
        this.keySize = keySize;
    }

    public String getAlgorithm() {
        return Algrithmname;
    }

    public void setAlgorithm(String Algrithmname) {
        this.Algrithmname = Algrithmname;
    }

    public void setMethod(int method) {
        this.method = method;
    }

    public int getMethod() {
        return method;
    }

    public boolean getStatus() {
        return n_upload;
    }

    public void setStatus(boolean n_upload) {
        this.n_upload = n_upload;
    }

}
