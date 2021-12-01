package tw.fp.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tw.fp.model.ClassMemberBean;

public interface ClassMemberRepository extends JpaRepository<ClassMemberBean, Integer> {

}
