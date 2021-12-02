package tw.gym.coach.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.repository.ClassRepository;
import tw.gym.coach.service.ClassService;

@Transactional
@Service
public class ClassServiceImpl implements ClassService {

    @Autowired
    ClassRepository claRepo;

    @Override
    public Object save(ClassBean cBean) {

        return claRepo.save(cBean);
    }

    @Override
    public List<ClassBean> listAllClass() {
        return claRepo.findAll();
    }

    @Override
    public ClassBean getClassById(Integer id) {
        return claRepo.getById(id);
    }

    @Override
    public void updateClass(ClassBean cBean) {
        claRepo.save(cBean);
    }

    @Override
    public void deleteById(Integer classId) {
        claRepo.deleteById(classId);
    }

    @Override
    public List<ClassBean> findClassesByCoachId(Integer coachId) {
        return claRepo.findClassByCoachId(coachId);
    }

    @Override
    public void setAvaliable(Integer a, Integer classId) {
        claRepo.setAvaliable(a, classId);
    }

    @Override
    public List<ClassBean> findByClassNameContaining(String className) {
        return claRepo.findByClassNameContaining(className);
    }

    @Override
    public List<ClassBean> findByClassDateBetween(java.sql.Date sd, java.sql.Date ed) {
        return claRepo.findByClassDateBetween(sd, ed);
    }

    @Override
    public List<ClassBean> dynamicQuery(String className, String coachName, String skillName, String startDate,
            String endDate, String classStatus) {
        Specification<ClassBean> spec = new Specification<ClassBean>() {
            @Override
            public Predicate toPredicate(Root<ClassBean> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                List<Predicate> predicates = new ArrayList<>();

                if (className != null && !className.isEmpty()) {
                    Path<Object> cName = root.get("className");
                    Predicate nameSearch = cb.like(cName.as(String.class), "%" + className + "%");
                    predicates.add(nameSearch);
                    System.out.println("className");
                }
                if (coachName != null && !coachName.isEmpty() && !coachName.equals("請選擇")) {
                    Path<Object> coaName = root.join("cBean").get("coachName");
                    Predicate coachNameSearch = cb.equal(coaName, coachName);
                    predicates.add(coachNameSearch);
                    System.out.println("className");
                }

                if (skillName != null && !skillName.isEmpty() && !skillName.equals("請選擇")) {
                    Path<Object> sName = root.join("sBean").get("skillName");
                    Predicate skillSearch = cb.like(sName.as(String.class), "%" + skillName + "%");
                    predicates.add(skillSearch);
                    System.out.println("skillName");
                }

                if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date sd = null;
                    try {
                        sd = format.parse(startDate);
                    } catch (ParseException e2) {
                        e2.printStackTrace();
                    }
                    java.sql.Date sdate = new java.sql.Date(sd.getTime());

                    java.util.Date ed = null;
                    try {
                        ed = format.parse(endDate);
                    } catch (ParseException e1) {
                        e1.printStackTrace();
                    }
                    java.sql.Date edate = new java.sql.Date(ed.getTime());

                    Predicate dateSearch = cb.between(root.get("classDate"), sdate, edate);
                    predicates.add(dateSearch);
                    System.out.println("classDate");
                }

                if (classStatus != null && !classStatus.isEmpty() && !classStatus.equals("請選擇")) {
                    Path<Object> claStatus = root.get("classAvaliable");
                    Integer cStatus = Integer.parseInt(classStatus);
                    Predicate classStatus = cb.equal(claStatus, cStatus);
                    predicates.add(classStatus);
                    System.out.println("classStatus");
                }

                // Predicate and = cb(predicates);
                // if (predicates.size() > 1) {

                System.out.println(predicates.size());
                Predicate ands = cb.and(predicates.toArray(new Predicate[predicates.size()]));
                return ands;
                // } else {
                // Predicate and = predicates.get(0);
                // return and;
                // }
            }

        };
        // Sort sort = Sort.by(Sort.Direction.ASC, "classDate");
        List<ClassBean> cBean = claRepo.findAll(spec);
        System.out.println(cBean);
        return cBean;
    }

    @Override
    public List<String> findClassCoach() {
        return claRepo.findClassCoach();
    }

}
