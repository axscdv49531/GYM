package tw.gym.membercourse.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import tw.gym.courses.model.Course;
import tw.gym.courses.model.CourseRepository;
import tw.gym.member.Dao.MemberRepository;
import tw.gym.member.Model.MemberBean;

public class Member_CourseRepositoryImpl implements Member_CourseRepositoryCustom {

	private Member_CourseRepository mcReps;

	private CourseRepository cReps;

	private MemberRepository mReps;
	
	
	@Autowired
	public Member_CourseRepositoryImpl(@Lazy Member_CourseRepository mcReps, @Lazy CourseRepository cReps, @Lazy MemberRepository mReps) {
		super();
		this.mcReps = mcReps;
		this.cReps = cReps;
		this.mReps = mReps;
	}

	// 多方新增；新增一筆選課紀錄
	public Member_Course insertMC(Member_Course mc) {
			
//		Long datetime = System.currentTimeMillis();
//        Timestamp timestamp = new Timestamp(datetime);
//        mc.setSelecttime(timestamp);
		
		MemberBean member = mReps.findByNumber(mc.getFk_member_num());
				
		member.getMC().add(mc);
		mc.setMember(member);
			
		Course course = cReps.findById(mc.getFk_course_id()).get();
		course.getMC().add(mc);
		mc.setCourse(course);

		return mcReps.save(mc);
		}

	// 多方更新；
	public Member_Course updateMC(Member_Course mc) {

		
		Member_Course updatemc = mcReps.findById(mc.getId()).get();
		updatemc.setState(mc.getState());
		
		//		Long datetime = System.currentTimeMillis();
//        Timestamp timestamp = new Timestamp(datetime);
//		updatemc.setSelecttime(timestamp);

		
		MemberBean member = mReps.findByNumber(mc.getFk_member_num());
		member.getMC().add(updatemc);
		updatemc.setMember(member);
			
		Course course = cReps.findById(mc.getFk_course_id()).get();
		course.getMC().add(updatemc);
		updatemc.setCourse(course);

		return mcReps.save(updatemc);

	}
	

}
