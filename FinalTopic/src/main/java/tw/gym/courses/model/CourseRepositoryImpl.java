package tw.gym.courses.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import tw.gym.model.CoachBean;
import tw.gym.repository.CoachRepository;

//@Repository
//@Transactional
public class CourseRepositoryImpl implements CourseRepositoryCustom {

	
	private CourseRepository cReps;

	
	private CoachRepository coachReps;
	
	@Autowired
	public CourseRepositoryImpl(@Lazy CourseRepository cReps, @Lazy CoachRepository coachReps) {

		this.cReps = cReps;
		this.coachReps = coachReps;
	}

	// 多方新增
	public Course insertCourse(Course course) {

		CoachBean coach = coachReps.findById(course.getCoachId()).get();
		coach.getCourses().add(course);
		course.setCoach(coach);

		return cReps.save(course);
	}

//多方更新
	public Course updateCourse(Course course) {

		Course updatedcourse = cReps.findById(course.getId()).get();
		updatedcourse.setCourseName(course.getCourseName());
		updatedcourse.setCategory(course.getCategory());
		updatedcourse.setClassroom(course.getClassroom());
		updatedcourse.setDate(course.getDate());
		updatedcourse.setPeriod(course.getPeriod());
		updatedcourse.setStudentNum(course.getStudentNum());
		updatedcourse.setMaxStudentNum(course.getMaxStudentNum());
		updatedcourse.setState(course.getState());
		updatedcourse.setInformation(course.getInformation());

		CoachBean coach = coachReps.findById(course.getCoachId()).get();
		coach.getCourses().add(updatedcourse);
		updatedcourse.setCoach(coach);

		// coachReps.save(coach);
		return cReps.save(updatedcourse);

	}

	// 多方更新：課程人數減一
	public void stuNumPlus(Integer courseId) {
		Course updatedcourse = cReps.findById(courseId).get();
		Integer num = updatedcourse.getStudentNum();
		num++;
		updatedcourse.setStudentNum(num);

//		CoachBean coach = coachReps.findById(coachId).get();
//		coach.getCourses().add(updatedcourse);
//		updatedcourse.setCoach(coach);

		cReps.save(updatedcourse);
	}

	// 多方更新：課程人數加一
	public void stuNumMinus(Integer courseId) {
		Course updatedcourse = cReps.findById(courseId).get();
		Integer num = updatedcourse.getStudentNum();
		num--;
		updatedcourse.setStudentNum(num);
		cReps.save(updatedcourse);
	}
}