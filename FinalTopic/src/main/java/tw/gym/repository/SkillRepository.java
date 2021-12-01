package tw.gym.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.gym.model.SkillBean;

public interface SkillRepository extends JpaRepository<SkillBean, Integer> {

    @Query("select sb.skillName from SkillBean sb")
    List<String> listAllSkill();

    // @Query("from SkillBean sb where sb.skillName = :name")
    SkillBean findBySkillName(String name);
}
