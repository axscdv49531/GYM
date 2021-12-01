package tw.fp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.fp.model.ClassBean;

@Service
@Transactional
public interface ClassService {
    Object save(ClassBean cBean);

    List<ClassBean> listAllClass();

    List<ClassBean> findClassesByCoachId(Integer coachId);

    ClassBean getClassById(Integer id);

    void updateClass(ClassBean cBean);

    void deleteById(Integer classId);

    void setAvaliable(Integer a, Integer classId);

    List<ClassBean> findByClassNameContaining(String className);

    List<ClassBean> findByClassDateBetween(java.sql.Date sd, java.sql.Date ed);

    List<ClassBean> dynamicQuery(String className, String coachName, String skillName, String startDate,
            String endDate, String classStatus);

    List<String> findClassCoach();
}
