package tw.fp.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "member")
@Component
public class MemberBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer memberId;
    String memberName;
    String memberAccount;
    String memberPassword;

    @OneToMany(mappedBy = "mBean")
    private Set<ClassMemberBean> cmBean = new HashSet<ClassMemberBean>();

    public MemberBean() {
    }

    public Set<ClassMemberBean> getCmBean() {
        return cmBean;
    }

    public void setCmBean(Set<ClassMemberBean> cmBean) {
        this.cmBean = cmBean;
    }

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getMemberAccount() {
        return memberAccount;
    }

    public void setMemberAccount(String memberAccount) {
        this.memberAccount = memberAccount;
    }

    public String getMemberPassword() {
        return memberPassword;
    }

    public void setMemberPassword(String memberPassword) {
        this.memberPassword = memberPassword;
    }


}
