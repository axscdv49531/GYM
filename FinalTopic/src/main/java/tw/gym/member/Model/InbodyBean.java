package tw.gym.member.Model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "Inbody")
@Component
public class InbodyBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer no;
	private Date measurementDate;
	private float height;
	private float weight;
	private float smm;
	private float bodyFatMass;
	private float bmi;
	private float pbf;
	
	@Transient
	private Integer number;	

	@ManyToOne
	@JoinColumn(name = "fk_member_number")
	private MemberBean memberBean;

	public InbodyBean(Integer no, Date measurementDate, float height, float weight, float smm, float bodyFatMass, float bmi,
			float pbf, Integer number) {
		super();
		this.no = no;
		this.measurementDate = measurementDate;
		this.height = height;
		this.weight = weight;
		this.smm = smm;
		this.bodyFatMass = bodyFatMass;
		this.bmi = bmi;
		this.pbf = pbf;
		this.number = number;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public Date getMeasurementDate() {
		return measurementDate;
	}

	public void setMeasurementDate(Date measurementDate) {
		this.measurementDate = measurementDate;
	}

	public float getHeight() {
		return height;
	}

	public void setHeight(float height) {
		this.height = height;
	}

	public float getWeight() {
		return weight;
	}

	public void setWeight(float weight) {
		this.weight = weight;
	}

	public float getSmm() {
		return smm;
	}

	public void setSmm(float smm) {
		this.smm = smm;
	}

	public float getBodyFatMass() {
		return bodyFatMass;
	}

	public void setBodyFatMass(float bodyFatMass) {
		this.bodyFatMass = bodyFatMass;
	}

	public float getBmi() {
		return bmi;
	}

	public void setBmi(float bmi) {
		this.bmi = bmi;
	}

	public float getPbf() {
		return pbf;
	}

	public void setPbf(float pbf) {
		this.pbf = pbf;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public MemberBean getMemberBean() {
		return memberBean;
	}

	public void setMemberBean(MemberBean memberBean) {
		this.memberBean = memberBean;
	}

	public InbodyBean() {
	}

}
