package tw.gym.coach.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.CoachBean;
import tw.gym.member.Model.MemberBean;

@Service
@Transactional
public interface ClassService {
    String findDup(ClassBean cBean, MemberBean a);

    Object save(ClassBean cBean);

    List<ClassBean> listAllClass();

    List<ClassBean> findClassesByCoachId(Integer coachId);

    CoachBean findCoachByClassId(Integer classId);

    ClassBean getClassById(Integer id);

    void updateClass(ClassBean cBean);

    void deleteById(Integer classId);

    void setAvaliable(Integer a, Integer classId);

    List<ClassBean> findByClassNameContaining(String className);

    List<ClassBean> findByClassDateBetween(java.sql.Date sd, java.sql.Date ed);

    List<ClassBean> dynamicQuery(String className, String coachName, String skillName, String startDate,
            String endDate, String classStatus);

    List<String> findClassCoach();

    List<ClassBean> memberDynamicQuery(String className, String coachName, String skillName, String startDate,
            String endDate, String classStatus, List<ClassBean> mcBean);
}
