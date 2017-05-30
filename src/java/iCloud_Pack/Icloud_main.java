/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack;

/**
 *
 * @author ZionZ
 */

import java.sql.Time;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Locale;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;
import java.util.Date;
public class Icloud_main {

    Cipher cipher;

    public SecretKey generateK() throws Exception {
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
        keyGenerator.init(128);
        SecretKey secretKey = keyGenerator.generateKey();
        cipher = Cipher.getInstance("AES");
        return secretKey;
    }

    public String[] encrypt(String plainText) throws Exception {
        SecretKey secretKey = generateK();
        String strEncodedKey = Base64.getEncoder().encodeToString(secretKey.getEncoded());
        byte[] plainTextByte = plainText.getBytes();
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedByte = cipher.doFinal(plainTextByte);
        Base64.Encoder encoder = Base64.getEncoder();
        String encryptedText = encoder.encodeToString(encryptedByte);
        String[] strarr = new String[2];
        strarr[0] = encryptedText;
        strarr[1] = strEncodedKey;
        return strarr;
    }

    public String decrypt(String encryptedText, String strKey) throws Exception {
        cipher = Cipher.getInstance("AES");
        byte[] decodedKey = Base64.getDecoder().decode(strKey);
        SecretKey secretKey = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");
        Base64.Decoder decoder = Base64.getDecoder();
        byte[] encryptedTextByte = decoder.decode(encryptedText);
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decryptedByte = cipher.doFinal(encryptedTextByte);
        String decryptedText = new String(decryptedByte);
        return decryptedText;
    }
    public String singleKeyEncrypt(String PlainText,String constKey){
         try {
            SecretKey key = new SecretKeySpec(constKey.getBytes(), "AES");
            cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] utf8 = PlainText.getBytes("UTF-8");
            byte[] enc = cipher.doFinal(utf8);
            Base64.Encoder encoder = Base64.getEncoder();
            return encoder.encodeToString(enc);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
     public String singleKeydecrypt(String encText,String constKey) {
        try {
            
            SecretKey key = new SecretKeySpec(constKey.getBytes(), "AES");
            cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, key);
            Base64.Decoder decoder = Base64.getDecoder();
            byte[] encryptedTextByte = decoder.decode(encText.replace(" ", "+"));
            byte[] utf8 = cipher.doFinal(encryptedTextByte);

            return new String(utf8, "UTF-8");
        } catch (Exception e) {
             e.printStackTrace();
        }
        return null;
    }

    public String formatFileSize(long size) {
        String hrSize = null;

        double b = size;
        double k = size / 1024.0;
        double m = ((size / 1024.0) / 1024.0);
        double g = (((size / 1024.0) / 1024.0) / 1024.0);
        double t = ((((size / 1024.0) / 1024.0) / 1024.0) / 1024.0);

        DecimalFormat dec = new DecimalFormat("0.00");

        if (t > 1) {
            hrSize = dec.format(t).concat(" TB");
        } else if (g > 1) {
            hrSize = dec.format(g).concat(" GB");
        } else if (m > 1) {
            hrSize = dec.format(m).concat(" MB");
        } else if (k > 1) {
            hrSize = dec.format(k).concat(" KB");
        } else {
            hrSize = dec.format(b).concat(" Bytes");
        }

        return hrSize;
    }

    public String setFileImage(String ftype) {
        if (ftype.equals("application/pdf")) {
            return "fa-file-pdf-o blue";
        }
        if (ftype.equals("application/msword")|| ftype.equals("application/vnd.oasis.opendocument.text")|| ftype.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document") ) {
            return "fa-file-word-o blue";
        }
        if (ftype.equals("image/jpeg")|| ftype.equals("image/png")|| ftype.equals("image/gif") || ftype.equals("image/x-icon") || ftype.equals("image/tiff")) {
            return "fa-image purple";
        }
        if (ftype.equals("application/vnd.ms-powerpoint")|| ftype.equals("application/vnd.openxmlformats-officedocument.presentationml.presentation")) {
            return "fa-file-powerpoint-o blue";
        }
        if (ftype.equals("audio/mp3") || ftype.equals("audio/x-m4a")|| ftype.equals("audio/mid") || ftype.equals("audio/aac") || ftype.equals("audio/wav")) {
            return "fa-music gray";
        }
        if (ftype.equals("video/mp4") || ftype.equals("video/mpeg") || ftype.equals("video/avi")|| ftype.equals("video/quicktime") || ftype.equals("video/3gpp") || ftype.equals("video/x-ms-wmv")) {
            return "fa-video-camera aero";
        }
        if (ftype.equals("application/octet-stream")) {
            return "fa-file-archive-o";
        }
         if (ftype.equals("text/plain")) {
            return "fa-file-text-o";
        }
          if (ftype.equals("text/html") || ftype.equals("text/css") || ftype.equals("application/javascript")) {
            return "fa-file-code-o";
        }
          if (ftype.equals("application/x-msdownload")) {
            return "fa-file-o";
        }
        return "fa-file";
        
    }
    public String formatDate(Date date){
        DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy",Locale.ENGLISH);
                String fdate=dateFormat.format(date);
                return fdate;
    }
    public String formatTime(Time time){
           SimpleDateFormat _12HourSDF = new SimpleDateFormat("hh:mm a");
           String rtime=_12HourSDF.format(time);
           return rtime;
    }
}
