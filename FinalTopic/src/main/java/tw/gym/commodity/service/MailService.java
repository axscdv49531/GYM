package tw.gym.commodity.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	
	private JavaMailSender mailsender;
	
	@Autowired
	public MailService(JavaMailSender mailsender) {
		this.mailsender = mailsender;
	}
	
	public void sendEmail(String toEmail, String subject, String body, byte[] bytearray) throws MessagingException {
		mailsender.send(new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				MimeMessageHelper msg = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				msg.setTo(toEmail);
				msg.setSubject(subject);
				msg.setText(body, true);
				msg.addInline("img", new ByteArrayResource(bytearray), "image/jpeg");
			}
		});
	}
	
	
	
}
