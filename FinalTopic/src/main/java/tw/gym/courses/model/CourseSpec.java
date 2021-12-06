package tw.gym.courses.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.data.jpa.domain.Specification;

public class CourseSpec implements Specification<Course> {

	
	public CourseSpec(String category, String classroom, Date date, Integer coachId) {
		this.category = category;
		this.classroom = classroom;
		this.date = date;
		this.coachId = coachId;
	}

	private static final long serialVersionUID = 1L;
	
	//private Course course;
	private String category;
	private String classroom;
	private Date date;
	private Integer coachId;
	
		@Override
		public Predicate toPredicate(Root root, CriteriaQuery criteriaQuery, CriteriaBuilder criteriaBuilder) {
		
			// 1.混合條件查詢
			List<Predicate> predicates = new ArrayList<>();
			
			if(null != category && !"".equals(category.trim())) {
				predicates.add(criteriaBuilder.equal(root.get("category"), category));
			}
			if(null != classroom && !"".equals(classroom.trim())) {
				predicates.add(criteriaBuilder.equal(root.get("classroom"), classroom));
			}
			if(null != date) {
				predicates.add(criteriaBuilder.equal(root.get("date"), date));
			}
			if(null != coachId && 0!=coachId) {
				predicates.add(criteriaBuilder.equal(root.get("coach").get("coachId"), coachId));
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


