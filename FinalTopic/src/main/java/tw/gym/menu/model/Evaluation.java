package tw.gym.menu.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="evaluation")
@Component
public class Evaluation {
	@Id
	@Column(name="EVALUATIONID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer evaluationid;
	
	@Column(name="SCORE")
	private String score;
	
	@Column(name="SUGGESTION")
	private String suggestion;
	
	
	@Column(name="MENUNAME")
	private String menuname;
	
	@JsonIgnore
	@Column(name="FK_MEMBER_ID")
	private String fk_member_id;


	public Evaluation() {
		
	}
	
	


	public Evaluation(String score, String suggestion, String menuname) {
		super();
		this.score = score;
		this.suggestion = suggestion;
		this.menuname = menuname;
	}




	public Integer getEvaluationid() {
		return evaluationid;
	}


	public String getScore() {
		return score;
	}


	public String getSuggestion() {
		return suggestion;
	}


	public String getMenuname() {
		return menuname;
	}


	public String getFk_member_id() {
		return fk_member_id;
	}


	public void setEvaluationid(Integer evaluationid) {
		this.evaluationid = evaluationid;
	}


	public void setScore(String score) {
		this.score = score;
	}


	public void setSuggestion(String suggestion) {
		this.suggestion = suggestion;
	}


	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}


	public void setFk_member_id(String fk_member_id) {
		this.fk_member_id = fk_member_id;
	}
	
	
	
	
	


}
