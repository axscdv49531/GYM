package tw.gym.membercourse.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

public interface Member_CourseRepository extends JpaRepository<Member_Course, Integer>,Member_CourseRepositoryCustom, JpaSpecificationExecutor<Member_Course>  {

	@Query(value="from Member_Course mc where mc.member.number=?1 AND mc.course.id=?2")
	public List<Member_Course> findByFkid(Integer memberNumber,Integer courseId);

	
	//@Query(value="from Member_Course mc WHERE mc.member.number=?1 ORDER BY mc.selecttime")
	//public Page<Member_Course> findByMember(Integer memberNumber);
}
