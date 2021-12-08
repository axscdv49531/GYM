package tw.gym.coach.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import tw.gym.coach.model.ClassBean;

public interface ClassRepository extends JpaRepository<ClassBean, Integer>, JpaSpecificationExecutor<ClassBean> {
    // String hql = "From ClassBean cb where cb.cBean.coachId = :coachId";
    @Query("From ClassBean cb where cb.cBean.coachId = :coachId")
    List<ClassBean> findClassByCoachId(Integer coachId, Sort sort);

    // @Transactional
    // @Transactional(propagation = Propagation.REQUIRES_NEW)
    // @Modifying(clearAutomatically = true)
    @Modifying
    @Query("Update ClassBean cb set cb.classAvaliable = :a where cb.classId = :classId")
    void setAvaliable(Integer a, Integer classId);

    List<ClassBean> findByClassNameContaining(String className);

    List<ClassBean> findByClassDateBetween(java.sql.Date sd, java.sql.Date ed);

    @Query("select DISTINCT cb.cBean.coachName from ClassBean cb")
    List<String> findClassCoach();

    List<ClassBean> findAllByOrderByClassDateAsc();


}
