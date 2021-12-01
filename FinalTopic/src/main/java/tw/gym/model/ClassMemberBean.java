package tw.gym.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "classMember")
@Component
public class ClassMemberBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer classmemberId;

    java.sql.Timestamp registerDate;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_class_id")
    private ClassBean cBean;

//    @ManyToOne(cascade = CascadeType.ALL)
//    @JoinColumn(name = "fk_member_id")
//    private MemberBean1 mBean;

    public ClassMemberBean() {
    }

    public ClassBean getcBean() {
        return cBean;
    }

    public void setcBean(ClassBean cBean) {
        this.cBean = cBean;
    }

//    public MemberBean1 getmBean() {
//        return mBean;
//    }
//
//    public void setmBean(MemberBean1 mBean) {
//        this.mBean = mBean;
//    }

    public Integer getClassmemberId() {
        return classmemberId;
    }

    public void setClassmemberId(Integer classmemberId) {
        this.classmemberId = classmemberId;
    }

    public java.sql.Timestamp getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(java.sql.Timestamp registerDate) {
        this.registerDate = registerDate;
    }


}
