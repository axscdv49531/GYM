package tw.gym.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tw.gym.model.ClassMemberBean;

public interface ClassMemberRepository extends JpaRepository<ClassMemberBean, Integer> {

}
