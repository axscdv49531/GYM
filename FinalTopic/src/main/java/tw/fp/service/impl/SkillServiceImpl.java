package tw.fp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.fp.model.SkillBean;
import tw.fp.repository.SkillRepository;
import tw.fp.service.SkillService;

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
