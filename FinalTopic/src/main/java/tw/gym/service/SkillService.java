package tw.gym.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.model.SkillBean;

@Service
@Transactional
public interface SkillService {

    List<String> listAllSkill();

    List<SkillBean> findAll();

    SkillBean findBySkillName(String name);
}
