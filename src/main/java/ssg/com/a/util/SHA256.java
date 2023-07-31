package ssg.com.a.util;

import java.security.MessageDigest;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Properties;


// 해쉬암호 : SHA256
// src/main/resources에 있는 config.properties 파일에 mSalt 저장
public class SHA256 {
	 // private final static String mSalt="코스";
	   private final static String mSalt;

	    static {
	        Properties prop = new Properties();
	        try {
	            InputStream inputStream = SHA256.class.getResourceAsStream("/config.properties");
	            prop.load(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        mSalt = prop.getProperty("mSalt");
	    }

    public static String encodeSha256(String source) {
	        	
        String result = "";
        
        byte[] a = source.getBytes();
        byte[] salt = mSalt.getBytes();
        byte[] bytes = new byte[a.length + salt.length];
        
        System.arraycopy(a, 0, bytes, 0, a.length);
        System.arraycopy(salt, 0, bytes, a.length, salt.length);
        
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(bytes);
            
            byte[] byteData = md.digest();
            
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
            }
            
            result = sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }

}