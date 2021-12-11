package tw.gym.coach.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.ClassMemberBean;
import tw.gym.member.Model.MemberBean;

public interface ClassMemberRepository extends JpaRepository<ClassMemberBean, Integer> {

    @Query("select cmBean.cBean from ClassMemberBean cmBean where cmBean.mBean.number = :memberId")
    List<ClassBean> findClassesByMemberId(Integer memberId);

    @Query("select cmBean.mBean from ClassMemberBean cmBean where cmBean.cBean.classId = :classId")
    List<MemberBean> findMemberByClassId(Integer classId);

}
