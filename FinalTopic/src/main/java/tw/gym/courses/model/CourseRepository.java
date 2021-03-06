package tw.gym.courses.model;


import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
//import org.springframework.data.jpa.repository.Query;
//import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface CourseRepository extends JpaRepository<Course, Integer>,CourseRepositoryCustom, JpaSpecificationExecutor<Course> {

	//我的課表
	@Query(value="from Course c left join c.MC mc WHERE mc.member.number =?1 and mc.state='已加選' and c.state='即將開課' ORDER BY date ASC, period ASC")
	public List<Course> findAllByMember(Integer memberNum);
	
	//上課紀錄
	@Query(value="from Course c left join c.MC mc WHERE mc.member.number =?1 and c.state='已經結束' ORDER BY date ASC, period ASC")
	public List<Course> findPastByMember(Integer memberNum);
	
	@Query(value="select DISTINCT date from Course ORDER BY date ASC" , nativeQuery = false)
	public List<Date> findAllDate();
	
	
	@Query(value="from Course where classroom=?1", nativeQuery = false)
	public List<Course> findByClassroom(String classroom);
	
	@Query(value="select information from Course c where c.id = :courseId")
	public String findInfoById(Integer courseId);

	@Query(value="from Course c where c.date >= :thismonday and c.date < :nextmonday and c.classroom= :classroom")
	public List<Course> findOneWeekCourse(Date thismonday, Date nextmonday,String classroom);
	
//	//批量刪除
//	 @Modifying
//	 @Transactional
//	 @Query("delete from Course c where c.id in (?1)")
//	 public void deleteBatch(List<Integer> ids);

	


}
