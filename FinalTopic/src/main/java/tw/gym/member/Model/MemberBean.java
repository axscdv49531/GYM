package tw.gym.member.Model;

import java.sql.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

import tw.gym.membercourse.model.Member_Course;
import tw.gym.model.ClassMemberBean;

@Entity
@Table(name = "member")
@Component
public class MemberBean {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer number;
	private String id;
	private String password;
	private String name;
	private String gender;
	private Date birthday;
	private String phone;
	private String email;
	private String county;
	private String district;
	private String address;
	private Integer deposite;
	private Date expirationdate;
	private String emergencyContact;
	private String emergencyPhone;

	@Transient
	private String confirmedPassword;

	@OneToMany(mappedBy = "memberBean")
	Set<PaymentBean> payment = new HashSet<>();

	@OneToMany(mappedBy = "memberBean")
	Set<InbodyBean> inbody = new HashSet<>();

	@OneToMany(mappedBy = "memberBean")
	Set<DepositeBean> depositeBean = new HashSet<>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member", cascade = CascadeType.ALL)
	@JsonIgnore
	private Set<Member_Course> MC = new LinkedHashSet<Member_Course>();

    // Mark
    @OneToMany(mappedBy = "mBean")
    private Set<ClassMemberBean> cmBean = new HashSet<ClassMemberBean>();

	public Set<Member_Course> getMC() {
		return MC;
	}

	public void setMC(Set<Member_Course> mC) {
		MC = mC;
	}

	public MemberBean() {

	}

	public MemberBean(Integer number, String id, String password, String name, String gender, Date birthday,
			String phone, String email, String county, String district, String address, Integer deposite,
			Date expirationdate, String emergencyContact, String emergencyPhone) {
		super();
		this.number = number;
		this.id = id;
		this.password = password;
		this.name = name;
		this.gender = gender;
		this.birthday = birthday;
		this.phone = phone;
		this.email = email;
		this.county = county;
		this.district = district;
		this.address = address;
		this.deposite = deposite;
		this.expirationdate = expirationdate;
		this.emergencyContact = emergencyContact;
		this.emergencyPhone = emergencyPhone;
	}

	public Set<DepositeBean> getDepositeBean() {
		return depositeBean;
	}

	public void setDepositeBean(Set<DepositeBean> depositeBean) {
		this.depositeBean = depositeBean;
	}

	public Set<PaymentBean> getPayment() {
		return payment;
	}

	public void setPayment(Set<PaymentBean> payment) {
		this.payment = payment;
	}

	public Set<InbodyBean> getInbody() {
		return inbody;
	}

	public void setInbody(Set<InbodyBean> inbody) {
		this.inbody = inbody;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirmedPassword() {
		return confirmedPassword;
	}

	public void setConfirmedPassword(String confirmedPassword) {
		this.confirmedPassword = confirmedPassword;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getDeposite() {
		return deposite;
	}

	public void setDeposite(Integer deposite) {
		this.deposite = deposite;
	}

	public Date getExpirationdate() {
		return expirationdate;
	}

	public void setExpirationdate(Date expirationdate) {
		this.expirationdate = expirationdate;
	}

	public String getEmergencyContact() {
		return emergencyContact;
	}

	public void setEmergencyContact(String emergencyContact) {
		this.emergencyContact = emergencyContact;
	}

	public String getEmergencyPhone() {
		return emergencyPhone;
	}

	public void setEmergencyPhone(String emergencyPhone) {
		this.emergencyPhone = emergencyPhone;
	}

    public Set<ClassMemberBean> getCmBean() {
        return cmBean;
    }

    public void setCmBean(Set<ClassMemberBean> cmBean) {
        this.cmBean = cmBean;
    }

    @Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("MemberBean [id=");
		builder.append(id);
		builder.append(", password=");
		builder.append(password);
		builder.append(", name=");
		builder.append(name);
		builder.append(", gender=");
		builder.append(gender);
		builder.append(", birthday=");
		builder.append(birthday);
		builder.append(", phone=");
		builder.append(phone);
		builder.append(", email=");
		builder.append(email);
		builder.append(", address=");
		builder.append(address);
		builder.append(", expirationdate=");
		builder.append(expirationdate);
		builder.append(", emergencyContact=");
		builder.append(emergencyContact);
		builder.append(", emergencyPhone=");
		builder.append(emergencyPhone);
		builder.append(", confirmedPassword=");
		builder.append(confirmedPassword);
		builder.append("]");
		return builder.toString();
	}

}
