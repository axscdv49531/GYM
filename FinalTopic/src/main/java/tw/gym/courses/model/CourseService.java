package tw.gym.courses.model;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface CourseService {

	public Course insertCourse(Course course);

	public Course updateCourse(Course course);
	
	
	public void stuNumMinus(Integer courseId);
	
	public void stuNumPlus(Integer courseId);
	

	public void deleteById(Integer courseId);

	public Course findById(Integer courseId);

	public List<Course> findAllCourse();
	
	public List<Date> findAllDate();
	

	public List<Course> findByClassroom(String classroom);
	
	public Page<Course> findAllByPage(Pageable pageable);
	
	public List<Course> findAllByMember(Integer memberNum);
	
	public List<Course> findPastByMember(Integer memberNum);

	public Page<Course> findAll(CourseSpec courseSpec, Pageable pageable);
	
	public String findInfoById(Integer courseId);
	
	public List<Course> findOneWeekCourse(Date thisweek, Date nextweek);

}
