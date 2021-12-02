package tw.gym.coach.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.SkillBean;
import tw.gym.coach.repository.SkillRepository;
import tw.gym.coach.service.SkillService;

@Transactional
@Service
public class SkillServiceImpl implements SkillService {

    @Autowired
    SkillRepository skiRepo;

    @Override
    public List<String> listAllSkill() {
        return skiRepo.listAllSkill();
    }

    @Override
    public SkillBean findBySkillName(String name) {
        return skiRepo.findBySkillName(name);
    }

    @Override
    public List<SkillBean> findAll() {
        return skiRepo.findAll();
    }

}
