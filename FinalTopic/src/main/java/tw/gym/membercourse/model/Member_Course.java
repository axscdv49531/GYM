package tw.gym.membercourse.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

import tw.gym.courses.model.Course;
import tw.gym.member.Model.MemberBean;

@Entity
@Table(name="member_course")
@Component
public class Member_Course {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Transient
	private Integer fk_member_num ;
	
	@Transient
	private Integer fk_course_id ;
	
	private String state;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	private Date selecttime;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="fk_member_num")
	@JsonIgnore
	private MemberBean member;
	

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="fk_course_id")
	@JsonIgnore
	private Course course;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getFk_member_num() {
		return fk_member_num;
	}

	public void setFk_member_num(Integer fk_member_num) {
		this.fk_member_num = fk_member_num;
	}

	public Integer getFk_course_id() {
		return fk_course_id;
	}

	public void setFk_course_id(Integer fk_course_id) {
		this.fk_course_id = fk_course_id;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
//
//	public Member getMember() {
//		return member;
//	}
//
//	public void setMember(Member member) {
//		this.member = member;
//	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}
	
	public Date getSelecttime() {
		return selecttime;
	}

	public void setSelecttime(Date selecttime) {
		this.selecttime = selecttime;
	}
	
	
	public MemberBean getMember() {
		return member;
	}

	public void setMember(MemberBean member) {
		this.member = member;
	}

}
