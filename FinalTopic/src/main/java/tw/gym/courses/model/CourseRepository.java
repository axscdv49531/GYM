package tw.gym.courses.model;


import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
//import org.springframework.data.jpa.repository.Query;
//import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;

public interface CourseRepository extends JpaRepository<Course, Integer>,CourseRepositoryCustom, JpaSpecificationExecutor<Course> {

	@Query(value="from Course c left join c.MC mc WHERE mc.member.number =?1 and mc.state='已加選' ORDER BY date ASC, period ASC")
	public List<Course> findAllByMember(Integer memberNum);
	
	@Query(value="select DISTINCT date from Course ORDER BY date ASC" , nativeQuery = false)
	public List<Date> findAllDate();
	
	
	@Query(value="from Course where classroom=?1", nativeQuery = false)
	public List<Course> findByClassroom(String classroom);
	
	@Query(value="select information from Course c where c.id = :courseId")
	public String findInfoById(Integer courseId);

	@Query(value="from Course c where c.date >= :thisweek and c.date < :nextweek")
	public List<Course> findOneWeekCourse(Date thisweek, Date nextweek);
	

	


}
