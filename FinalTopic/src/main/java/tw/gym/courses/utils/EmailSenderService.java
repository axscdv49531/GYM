package tw.gym.courses.utils;

public interface EmailSenderService {

	void sendEmail(String toEmail, String subject, String body);
	
}
