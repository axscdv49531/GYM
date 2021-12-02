package tw.gym.membercourse.model;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface Member_CourseService {
	public Member_Course insertMC(Member_Course mc) ;
	
	
	public Member_Course updateMC(Member_Course mc);
	
	public List<Member_Course> findByFkid(Integer memberNumber,Integer courseId);
	
	public Page<Member_Course> findByMemberNumber(Member_CourseSpec mcSpec,Pageable pagealbe);
}
