package tw.gym.member.util;

import org.springframework.http.HttpStatus;

public class DemoResponse {

    private Integer status;
    private String message;

    public DemoResponse() {
        this.status = HttpStatus.OK.value();
        this.message = "success";
    }

    public DemoResponse(Integer status, String message) {
        this.status = status;
        this.message = message;
    }

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

    // getters and setters...
}
