package tw.gym.member.Model;

import java.io.Serializable;
import java.sql.Blob;
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
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import tw.gym.coach.model.ClassMemberBean;
import tw.gym.membercourse.model.Member_Course;

@Entity
@Table(name = "member")
@Component
public class MemberBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer number;
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
	private String fileName;
	private Integer status;

	@Transient
	private String password1;

	@Transient
	private String oldpwd;

	@Transient
	private String confirmedPassword;

	@Transient
	private MultipartFile mPhoto;
	private Blob memberPhoto;
	private String memberPhotoMineType;

	@OneToMany(mappedBy = "memberBean")
	@JsonIgnore
	Set<PaymentBean> payment = new HashSet<>();

	@OneToMany(mappedBy = "memberBean")
	@JsonIgnore
	Set<InbodyBean> inbody = new HashSet<>();

	@OneToMany(mappedBy = "memberBean")
	@JsonIgnore
	Set<DepositeBean> depositeBean = new HashSet<>();

	// Dean
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "member", cascade = CascadeType.ALL)
	@JsonIgnore
	private Set<Member_Course> MC = new LinkedHashSet<Member_Course>();

	// Mark
	@OneToMany(mappedBy = "mBean")
	@JsonIgnore
	private Set<ClassMemberBean> cmBean = new HashSet<ClassMemberBean>();

	public Set<Member_Course> getMC() {
		return MC;
	}

	public void setMC(Set<Member_Course> mC) {
		MC = mC;
	}

	public MemberBean() {

	}

	public MemberBean(Integer number, String password, String name, String gender, Date birthday, String phone,
			String email, String county, String district, String address, Integer deposite, Date expirationdate,
			String emergencyContact, String emergencyPhone, String fileName) {
		super();
		this.number = number;
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
		this.fileName = fileName;
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

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public MultipartFile getmPhoto() {
		return mPhoto;
	}

	public void setmPhoto(MultipartFile mPhoto) {
		this.mPhoto = mPhoto;
	}

	public Blob getMemberPhoto() {
		return memberPhoto;
	}

	public void setMemberPhoto(Blob memberPhoto) {
		this.memberPhoto = memberPhoto;
	}

	public String getMemberPhotoMineType() {
		return memberPhotoMineType;
	}

	public void setMemberPhotoMineType(String memberPhotoMineType) {
		this.memberPhotoMineType = memberPhotoMineType;
	}

	public String getPassword1() {
		return password1;
	}

	public void setPassword1(String password1) {
		this.password1 = password1;
	}

	public String getOldpwd() {
		return oldpwd;
	}

	public void setOldpwd(String oldpwd) {
		this.oldpwd = oldpwd;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("MemberBean [password=");
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
		builder.append(", password1=");
		builder.append(password1);
		builder.append(", memberPhoto=");
		builder.append(memberPhoto);
		builder.append("]");
		return builder.toString();
	}

}
