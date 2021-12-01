package tw.gym.membercourse.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class Member_CourseServiceImpl implements Member_CourseService {
	
	@Autowired
	private Member_CourseRepository mcReps;
	
	public Member_Course insertMC(Member_Course mc) {
		return mcReps.insertMC(mc);
	}
	
	public Member_Course updateMC(Member_Course mc) {
		return mcReps.updateMC(mc);
	}
	
	public List<Member_Course> findByFkid(Integer memberNumber,Integer courseId){
		return mcReps.findByFkid(memberNumber, courseId);
	}
	
	public List<Member_Course> findByMember(Integer memberNumber){
		return mcReps.findByMember(memberNumber);
	}
}
