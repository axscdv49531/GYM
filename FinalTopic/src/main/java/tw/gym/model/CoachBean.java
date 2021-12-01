package tw.gym.model;

import java.io.Serializable;
import java.sql.Blob;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
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

@Entity
@Table(name = "coachList")
@Component
// @JsonIgnoreProperties(value = { "hibernateLazyInitializer" })
public class CoachBean implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer coachId;
    private String coachName;
    private String coachAccount;
    private String coachPassword;
    private String coachGender;
    private String coachEmail;
    private Integer coachExp;
    private String coachAddress;
    private String fileName;
    @Transient
    private MultipartFile cPhoto;
    private Blob coachPhoto;
    private String coachPhotoMineType;
    @Transient
    private String coachBirthTemp;
    private java.sql.Date coachBirth;
    @Column(updatable = false)
    private Date coachRegisterdate;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "cBean", cascade = CascadeType.ALL)
    @JsonIgnore
    private Set<ClassBean> cBean = new HashSet<ClassBean>();

    public CoachBean() {
    }

    public Integer getCoachId() {
        return coachId;
    }

    public void setCoachId(Integer coachId) {
        this.coachId = coachId;
    }

    public String getCoachName() {
        return coachName;
    }

    public void setCoachName(String coachName) {
        this.coachName = coachName;
    }

    public String getCoachAccount() {
        return coachAccount;
    }

    public void setCoachAccount(String coachAccount) {
        this.coachAccount = coachAccount;
    }

    public String getCoachPassword() {
        return coachPassword;
    }

    public void setCoachPassword(String coachPassword) {
        this.coachPassword = coachPassword;
    }

    public String getCoachGender() {
        return coachGender;
    }

    public void setCoachGender(String coachGender) {
        this.coachGender = coachGender;
    }

    public String getCoachEmail() {
        return coachEmail;
    }

    public void setCoachEmail(String coachEmail) {
        this.coachEmail = coachEmail;
    }

    public Integer getCoachExp() {
        return coachExp;
    }

    public void setCoachExp(Integer coachExp) {
        this.coachExp = coachExp;
    }

    public String getCoachAddress() {
        return coachAddress;
    }

    public void setCoachAddress(String coachAddress) {
        this.coachAddress = coachAddress;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public MultipartFile getcPhoto() {
        return cPhoto;
    }

    public void setcPhoto(MultipartFile cPhoto) {
        this.cPhoto = cPhoto;
    }

    public Blob getCoachPhoto() {
        return coachPhoto;
    }

    public void setCoachPhoto(Blob coachPhoto) {
        this.coachPhoto = coachPhoto;
    }

    public java.sql.Date getCoachBirth() {
        return coachBirth;
    }

    public void setCoachBirth(java.sql.Date coachBirth) {
        this.coachBirth = coachBirth;
    }

    public Date getCoachRegisterdate() {
        return coachRegisterdate;
    }

    public void setCoachRegisterdate(Timestamp coachRegisterdate) {
        this.coachRegisterdate = coachRegisterdate;
    }

    public Set<ClassBean> getcBean() {
        return cBean;
    }

    public void setcBean(Set<ClassBean> cBean) {
        this.cBean = cBean;
    }

    public String getCoachPhotoMineType() {
        return coachPhotoMineType;
    }

    public void setCoachPhotoMineType(String coachPhotoMineType) {
        this.coachPhotoMineType = coachPhotoMineType;
    }

    public void setCoachRegisterdate(Date coachRegisterdate) {
        this.coachRegisterdate = coachRegisterdate;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("CoachBean [coachId=");
        builder.append(coachId);
        builder.append(", coachName=");
        builder.append(coachName);
        builder.append(", coachAccount=");
        builder.append(coachAccount);
        builder.append(", coachPassword=");
        builder.append(coachPassword);
        builder.append(", coachGender=");
        builder.append(coachGender);
        builder.append(", coachEmail=");
        builder.append(coachEmail);
        builder.append(", coachExp=");
        builder.append(coachExp);
        builder.append(", coachExpertise=");
        builder.append(coachAddress);
        builder.append(", coachPhoto=");
        builder.append(coachPhoto);
        builder.append(", coachBirth=");
        builder.append(coachBirth);
        builder.append(", coachRegisterdate=");
        builder.append(coachRegisterdate);
        builder.append("]");
        return builder.toString();
    }

}
