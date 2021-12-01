package tw.gym.courses.model;

import java.util.Date;
import java.util.List;

//自定義CRUD方法
public interface CourseRepositoryCustom {
	
//	public List<Course> findByQueryForm(String category, String classroom, Date date, Integer coachId);
	
	public Course insertCourse(Course course);
	
	public Course updateCourse(Course course);
	
	public void stuNumMinus(Integer courseId);
	
	public void stuNumPlus(Integer courseId);
}
