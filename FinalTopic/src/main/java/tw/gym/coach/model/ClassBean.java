package tw.gym.coach.model;

import java.io.Serializable;
import java.sql.Blob;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "classList")
@Component
// @JsonIgnoreProperties(value = { "hibernateLazyInitializer" })
public class ClassBean implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer classId;
    // Integer fk_user_id;
    String className;
    Integer classDuration;
    java.sql.Date classDate;
    @Transient
    String classStartTimeTemp;
    @Transient
    String classEndTimeTemp;
    java.sql.Time classStartTime;
    java.sql.Time classEndTime;
    Integer classPrice;
    String classDescription;
    @Transient
    String[] classLabel;
    @Column(updatable = false)
    java.sql.Timestamp classCreatedate;
    String classFileName;

    @Transient
    MultipartFile claPhoto;
    Blob classPhoto;
    String classPhotoMineType;
    Integer classAvaliable;

    // , insertable = false, updatable = false
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_coach_id", updatable = false)
    private CoachBean cBean;

    @OneToMany(mappedBy = "cBean")
    @JsonIgnore
    private Set<ClassMemberBean> cmBean = new HashSet<ClassMemberBean>();

    // @OneToMany(cascade = CascadeType.ALL)
    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "trainingPart", joinColumns = @JoinColumn(name = "fk_class_id"), inverseJoinColumns = @JoinColumn(name = "fk_skill_id"))
    private Set<SkillBean> sBean = new HashSet<SkillBean>();

    public ClassBean() {

    }

    // @JsonIgnoreProperties(ignoreUnknown = true, value = { "cBean" })
    public Set<ClassMemberBean> getCmBean() {
        return cmBean;
    }

    public void setCmBean(Set<ClassMemberBean> cmBean) {
        this.cmBean = cmBean;
    }

    public Integer getClassId() {
        return classId;
    }

    public void setClassId(Integer classId) {
        this.classId = classId;
    }

    // @JsonIgnoreProperties(ignoreUnknown = true, value = { "cBean" })
    public CoachBean getcBean() {
        return cBean;
    }

    public void setcBean(CoachBean cBean) {
        this.cBean = cBean;
    }

    public String getClassStartTimeTemp() {
        return classStartTimeTemp;
    }

    public void setClassStartTimeTemp(String classStartTimeTemp) {
        this.classStartTimeTemp = classStartTimeTemp;
    }

    public String getClassEndTimeTemp() {
        return classEndTimeTemp;
    }

    public void setClassEndTimeTemp(String classEndTimeTemp) {
        this.classEndTimeTemp = classEndTimeTemp;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Integer getClassDuration() {
        return classDuration;
    }

    public void setClassDuration(Integer classDuration) {
        this.classDuration = classDuration;
    }

    public java.sql.Date getClassDate() {
        return classDate;
    }

    public void setClassDate(java.sql.Date classDate) {
        this.classDate = classDate;
    }

    public Integer getClassPrice() {
        return classPrice;
    }

    public void setClassPrice(Integer classPrice) {
        this.classPrice = classPrice;
    }

    public java.sql.Time getClassStartTime() {
        return classStartTime;
    }

    public void setClassStartTime(java.sql.Time classStartTime) {
        this.classStartTime = classStartTime;
    }

    public java.sql.Time getClassEndTime() {
        return classEndTime;
    }

    public void setClassEndTime(java.sql.Time classEndTime) {
        this.classEndTime = classEndTime;
    }

    public String getClassDescription() {
        return classDescription;
    }

    public void setClassDescription(String classDescription) {
        this.classDescription = classDescription;
    }

    public String[] getClassLabel() {
        return classLabel;
    }

    public void setClassLabel(String[] classLabel) {
        this.classLabel = classLabel;
    }

    public java.sql.Timestamp getClassCreatedate() {
        return classCreatedate;
    }

    public void setClassCreatedate(java.sql.Timestamp classCreatedate) {
        this.classCreatedate = classCreatedate;
    }

    public Integer getClassAvaliable() {
        return classAvaliable;
    }

    public void setClassAvaliable(Integer classAvaliable) {
        this.classAvaliable = classAvaliable;
    }

    public Set<SkillBean> getsBean() {
        return sBean;
    }

    public void setsBean(Set<SkillBean> sBean) {
        this.sBean = sBean;
    }

    public String getClassFileName() {
        return classFileName;
    }

    public void setClassFileName(String classFileName) {
        this.classFileName = classFileName;
    }

    public MultipartFile getClaPhoto() {
        return claPhoto;
    }

    public void setClaPhoto(MultipartFile claPhoto) {
        this.claPhoto = claPhoto;
    }

    public Blob getClassPhoto() {
        return classPhoto;
    }

    public void setClassPhoto(Blob classPhoto) {
        this.classPhoto = classPhoto;
    }

    public String getClassPhotoMineType() {
        return classPhotoMineType;
    }

    public void setClassPhotoMineType(String classPhotoMineType) {
        this.classPhotoMineType = classPhotoMineType;
    }

}
