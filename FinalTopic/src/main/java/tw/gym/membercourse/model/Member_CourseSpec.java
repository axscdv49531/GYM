package tw.gym.membercourse.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.data.jpa.domain.Specification;

public class Member_CourseSpec implements Specification<Member_Course> {

	private static final long serialVersionUID = 1L;
	

	private Integer memberNumber;
	
	public Member_CourseSpec(Integer memberNumber) {
	this.memberNumber = memberNumber;
	}

		@Override
		public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
		
			// 1.混合條件查詢
			List<Predicate> predicates = new ArrayList<>();
			
			if(null != memberNumber && 0!=memberNumber) {
				predicates.add(criteriaBuilder.equal(root.get("member").get("number"), memberNumber));
			}
			
			return criteriaQuery.where(predicates.toArray(new Predicate[predicates.size()])).getRestriction();
		}
		/*
		 * 類似的sql語句為: 
		 * Hibernate: 
		 * select 
		 * count(task0_.id) as col_0_0_ 
		 * from 
		 * tb_task task0_
		 * where ( task0_.task_name like ? )
		 *  and task0_.create_time<? 
		 *  or
		 * task0_.task_detail=?
		 */

		
		// 2.多表查詢
		/*
		 * Join<Task,Project> join = root.join("project", JoinType.INNER); Path<String>
		 * exp4 = join.get("projectName"); return cb.like(exp4, "%projectName%");
		 * 
		 * Hibernate: 
		 * select 
		 * count(task0_.id) as col_0_0_ 
		 * from 
		 * tb_task task0_
		 * inner join
		 * tb_project project1_ 
		 * on task0_.project_id=project1_.id 
		 * where
		 * project1_.project_name like ?
		 */

		//return null;
	}


