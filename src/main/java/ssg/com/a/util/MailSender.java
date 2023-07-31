package ssg.com.a.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender {
	 // private final static String mSalt="코스";
	   private final static String mailPassword;
	   private final static String emailAddress;
	   
	    static {
	        Properties prop = new Properties();
	        try {
	            InputStream inputStream = SHA256.class.getResourceAsStream("/config.properties");
	            prop.load(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        mailPassword = prop.getProperty("mailpassword");
	        emailAddress = prop.getProperty("emailaddress");
	    }
	
		public static String sendEmail(String receiver, String title, String content) {
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			
			String isS = "YES";
			Session session = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(emailAddress, mailPassword);
				}
			});
			
			Message message = new MimeMessage(session);
			try {
				message.setFrom(new InternetAddress(emailAddress, "관리자", "utf-8"));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
				message.setSubject(title);
				message.setContent(content, "text/html; charset=utf-8");
		
				Transport.send(message);
			} catch (Exception e) {
				e.printStackTrace();
				isS ="NO";
			}
			return isS;
		}
}