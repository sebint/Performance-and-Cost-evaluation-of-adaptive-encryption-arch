/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package iCloud_Pack;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.security.Key;
import java.security.SecureRandom;
import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author ZionZ
 */
public class Security_Enc {

    private static final int ITERATIONS = 65536;
    DBConnect dbcon = new DBConnect();
    Runtime runtime = Runtime.getRuntime();
    Key key;
    String algorithm = null;
    int keySize;
    String fileName = null;
    String fileType = null;
    long fileSize;
    int folderid;
    int userid;
    int method;
    boolean status;

    public Security_Enc(String algorithm, int keySize, boolean status) {
        this.algorithm = algorithm;
        this.keySize = keySize;
        this.status = status;
    }

    public Security_Enc(String algorithm, int keySize, String fileName, String fileType, long fileSize, int folderid, int userid, int method, boolean status) {
        this.algorithm = algorithm;
        this.keySize = keySize;
        this.fileName = fileName;
        this.fileType = fileType;
        this.fileSize = fileSize;
        this.folderid = folderid;
        this.userid = userid;
        this.status = status;
        this.method = method;
    }

    public Security_Enc(String algorithm) {
        this.algorithm = algorithm;
    }

    private ByteArrayOutputStream generateKey(char[] pass) {
        try {
            KeyGenerator keyGenerator = KeyGenerator.getInstance(algorithm);
            keyGenerator.init(keySize);
            key = keyGenerator.generateKey();
            byte[] salt = new byte[8];
            SecureRandom random = new SecureRandom();
            random.nextBytes(salt);
            PBEKeySpec pbeKeySpec = new PBEKeySpec(pass);
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBEWithSHA1AndRC2_40");
            SecretKey pbeKey = keyFactory.generateSecret(pbeKeySpec);
            PBEParameterSpec pbeParamSpec = new PBEParameterSpec(salt, ITERATIONS);
            Cipher cipher = Cipher.getInstance("PBEWithSHA1AndRC2_40");
            cipher.init(Cipher.ENCRYPT_MODE, pbeKey, pbeParamSpec);
            byte[] encryptedKeyBytes = cipher.doFinal(key.getEncoded());
            ByteArrayOutputStream RCSalt = new ByteArrayOutputStream();
            RCSalt.write(salt);
            RCSalt.write(encryptedKeyBytes);
            return RCSalt;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    private Key loadKey(char[] password, InputStream keyInStream) {
        try {
            ByteArrayOutputStream keyOutStream = new ByteArrayOutputStream();
            int i = 0;
            while ((i = keyInStream.read()) != -1) {
                keyOutStream.write(i);
            }
            keyInStream.close();
            byte[] saltAndKeyBytes = keyOutStream.toByteArray();
            keyOutStream.close();
            // get the salt, which is the first 8 bytes
            byte[] salt = new byte[8];
            System.arraycopy(saltAndKeyBytes, 0, salt, 0, 8);
            // get the encrypted key bytes
            int length = saltAndKeyBytes.length - 8;
            byte[] encryptedKeyBytes = new byte[length];
            System.arraycopy(saltAndKeyBytes, 8, encryptedKeyBytes, 0, length);
            // Create the PBE cipher
            PBEKeySpec pbeKeySpec = new PBEKeySpec(password);
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBEWithSHA1AndRC2_40");
            SecretKey pbeKey = keyFactory.generateSecret(pbeKeySpec);
            PBEParameterSpec pbeParamSpec = new PBEParameterSpec(salt, ITERATIONS);
            Cipher cipher = Cipher.getInstance("PBEWithSHA1AndRC2_40");
            cipher.init(Cipher.DECRYPT_MODE, pbeKey, pbeParamSpec);
            // Decrypt the key bytes
            byte[] decryptedKeyBytes = cipher.doFinal(encryptedKeyBytes);
            // Create the key from the key bytes
            SecretKeySpec key = new SecretKeySpec(decryptedKeyBytes, algorithm);
            return key;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public long[] encryptFile(InputStream file, String pass) {
        int get = 0;
        try {
            runtime.gc();
            long membefore = runtime.totalMemory() - runtime.freeMemory();
            long starttime = System.currentTimeMillis();
            ByteArrayOutputStream encryptedFile = new ByteArrayOutputStream();
            ByteArrayOutputStream bstrem = generateKey(pass.toCharArray());
            byte[] temp = bstrem.toByteArray();
            //InputStream encKey = new ByteArrayInputStream(temp);
            InputStream encKey1 = new ByteArrayInputStream(temp);

            Cipher cipher = Cipher.getInstance(algorithm);
            cipher.init(Cipher.ENCRYPT_MODE, key);
            //CipherOutputStream cos = new CipherOutputStream(encryptedFile, cipher);
            //int theByte = 0;
            byte[] input = new byte[file.available()];
            int bytesRead;
            while ((bytesRead = file.read(input)) != -1) {
                byte[] output = cipher.update(input, 0, bytesRead);
                if (output != null) {
                    encryptedFile.write(output);
                }
            }
            byte[] output = cipher.doFinal();
            if (output != null) {
                encryptedFile.write(output);
            }
            long stoptime = System.currentTimeMillis();
            long usedmem = runtime.totalMemory() - runtime.freeMemory();
            byte[] enc = encryptedFile.toByteArray();
            InputStream encData = new ByteArrayInputStream(enc);
            if (status) {
                get = dbcon.storeFile(encData, encKey1, fileName, fileType, fileSize, folderid, userid, method);
            }
            encryptedFile.flush();
            encryptedFile.close();
            long[] result = new long[2];

            if (status) {
                result[0] = get;
                return result;
            } else {
                result[0] = stoptime - starttime;
                result[1] = ((usedmem - membefore) / 1024);
                return result;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public ByteArrayOutputStream decryptFile(InputStream file, String passPharse, InputStream keyStream) {
        try {
            ByteArrayOutputStream decryptedFile = new ByteArrayOutputStream();
            //char pass[] = convertPass(passPharse);
            Key keyD = loadKey(passPharse.toCharArray(), keyStream);
            Cipher cipher = Cipher.getInstance(algorithm);
            cipher.init(Cipher.DECRYPT_MODE, keyD);
            CipherInputStream cis = new CipherInputStream(file, cipher);
            byte[] buffer = new byte[file.available()];
            int theByte = cis.read(buffer);;
            while (theByte != -1) {
                decryptedFile.write(buffer, 0, theByte);
                theByte = cis.read(buffer);
            }
            cis.close();
            decryptedFile.close();
            return decryptedFile;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

}
