package tw.gym.coach.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tw.gym.coach.model.ClassMemberBean;

public interface ClassMemberRepository extends JpaRepository<ClassMemberBean, Integer> {

}
