package tw.gym.coach.model;

import org.springframework.stereotype.Component;

@Component
public class CoachClass {

    String coachId;

    public String getCoachId() {
        return coachId;
    }

    public void setCoachId(String coachId) {
        this.coachId = coachId;
    }

}
