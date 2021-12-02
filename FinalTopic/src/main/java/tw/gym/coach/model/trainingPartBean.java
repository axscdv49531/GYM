package tw.gym.coach.model;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "trainingPart")
@Component
public class trainingPartBean {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer trainingPartId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_class_id", updatable = false)
    private ClassBean cBean;

    public Integer getTrainingPartId() {
        return trainingPartId;
    }

    public void setTrainingPartId(Integer trainingPartId) {
        this.trainingPartId = trainingPartId;
    }

    public ClassBean getcBean() {
        return cBean;
    }

    public void setcBean(ClassBean cBean) {
        this.cBean = cBean;
    }

}
