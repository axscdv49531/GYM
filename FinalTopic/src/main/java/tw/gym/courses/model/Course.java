package tw.gym.courses.model;


//import java.io.Serializable;
import java.sql.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

import tw.gym.membercourse.model.Member_Course;
import tw.gym.model.CoachBean;

@Entity
@Table(name = "courses")
@Component
public class Course {
//public class Course implements Serializable{

	// OnetoMany:Course-MC

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Column(name="courseName")
	private String courseName;
	@Column(name="category")
	private String category;
	//private Integer weekday;
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date date;
	private String period;
	private String classroom;
	private Integer studentNum;
	private Integer maxStudentNum;
	private String state;
	private String information;
	
	//@Column(name = "fk_coach_id")
	@Transient
	private Integer coachId;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "course", cascade = CascadeType.ALL)
	@JsonIgnore
	private Set<Member_Course> MC = new LinkedHashSet<Member_Course>();

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="fk_coach_id")
//	@JsonIgnore
	private CoachBean coach;
	
	
	public Course() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

//	public Integer getWeekday() {
//		return weekday;
//	}
//
//	public void setWeekday(int weekday) {
//		this.weekday = weekday;
//	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getClassroom() {
		return classroom;
	}

	public void setClassroom(String classroom) {
		this.classroom = classroom;
	}

	public Integer getStudentNum() {
		return studentNum;
	}

	public void setStudentNum(int studentNum) {
		this.studentNum = studentNum;
	}

	public Integer getMaxStudentNum() {
		return maxStudentNum;
	}

	public void setMaxStudentNum(int maxStudentNum) {
		this.maxStudentNum = maxStudentNum;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getCoachId() {
		return coachId;
	}

	public void setCoachId(int coachId) {
		this.coachId = coachId;
	}



	public CoachBean getCoach() {
		return coach;
	}

	public void setCoach(CoachBean coach) {
		this.coach = coach;
	}

	public Set<Member_Course> getMC() {
		return MC;
	}

	public void setMC(Set<Member_Course> mC) {
		MC = mC;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setStudentNum(Integer studentNum) {
		this.studentNum = studentNum;
	}

	public void setMaxStudentNum(Integer maxStudentNum) {
		this.maxStudentNum = maxStudentNum;
	}


	public void setCoachId(Integer coachId) {
		this.coachId = coachId;
	}

	public String getInformation() {
		return information;
	}

	public void setInformation(String information) {
		this.information = information;
	}


}
