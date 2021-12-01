package tw.gym.membercourse.model;

import java.util.List;

public interface Member_CourseService {
	public Member_Course insertMC(Member_Course mc) ;
	
	
	public Member_Course updateMC(Member_Course mc);
	
	public List<Member_Course> findByFkid(Integer memberNumber,Integer courseId);
	
	public List<Member_Course> findByMember(Integer memberNumber);
}
