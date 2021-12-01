package tw.gym.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "skillList")
@Component
public class SkillBean implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    // @Column(name = "fk_skill_id")
    Integer skillId;
    String skillName;

    // @ManyToOne(fetch = FetchType.EAGER)
    // private ClassBean cBean;

    public Integer getSkillId() {
        return skillId;
    }

    public void setSkillId(Integer skillId) {
        this.skillId = skillId;
    }

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    // public ClassBean getcBean() {
    // return cBean;
    // }
    //
    // public void setcBean(ClassBean cBean) {
    // this.cBean = cBean;
    // }


}
