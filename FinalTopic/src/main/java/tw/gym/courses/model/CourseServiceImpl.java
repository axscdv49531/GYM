package tw.gym.courses.model;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class CourseServiceImpl implements CourseService{
	
	@Autowired
	private CourseRepository cReps;
	
	public Course insertCourse(Course course) {
		
		return cReps.insertCourse(course);
	}
	
	public Course updateCourse(Course course) {
		return cReps.updateCourse(course);
		
	}
	
	public void stuNumMinus(Integer courseId) {
		cReps.stuNumMinus(courseId);
	}
	
	public void stuNumPlus(Integer courseId) {
		cReps.stuNumPlus(courseId);
	}
	
	public void deleteById(Integer courseId) {
		cReps.deleteById(courseId);
		
	}
	
	public Course findById(Integer courseId) {
		Optional<Course> opt1 = cReps.findById(courseId);
		return opt1.get(); //找不到，會回傳null;
	}
	
	public List<Course> findAllCourse(){
		return cReps.findAll();
	}
	
	public List<Date> findAllDate(){
		return cReps.findAllDate();
	}
	
	public Page<Course> findAll(CourseSpec courseSpec,Pageable pagealbe){
		return cReps.findAll(courseSpec,pagealbe);
	}
	
	public List<Course> findByClassroom(String classroom){
		return cReps.findByClassroom(classroom);
	}
	
	public Page<Course> findAllByPage(Pageable pageable){
		return cReps.findAll(pageable);
	}

	public List<Course> findAllByMember(Integer memberNum){
		return cReps.findAllByMember(memberNum);
	}
	
	public List<Course> findPastByMember(Integer memberNumber){
		return cReps.findPastByMember(memberNumber);
		
	}
	
	public String findInfoById(Integer courseId) {
		return cReps.findInfoById(courseId);
	}
	
	public List<Course> findOneWeekCourse(Date thismonday, Date nextmonday,String classroom){
		return  cReps.findOneWeekCourse(thismonday, nextmonday, classroom);
	}
//	
}
