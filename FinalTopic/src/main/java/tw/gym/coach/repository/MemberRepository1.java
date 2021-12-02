package tw.gym.coach.repository;
//package tw.gym.repository;
//
//import java.util.List;
//
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.jpa.repository.Modifying;
//import org.springframework.data.jpa.repository.Query;
//import org.springframework.transaction.annotation.Transactional;
//
//import tw.gym.model.ClassBean;
//import tw.gym.model.MemberBean1;
//
//public interface MemberRepository1 extends JpaRepository<MemberBean1, Integer> {
//    @Query("FROM MemberBean mb WHERE mb.memberAccount = :memberAccount and mb.memberPassword = :memberPassword")
//    MemberBean1 findByAccountAndPassword(String memberAccount, String memberPassword);
//
//    @Query("From ClassBean cb where cb.classId in ( select cmb.cBean.classId From ClassMemberBean cmb where cmb.mBean.memberId in ( :memberId ) )")
//    List<ClassBean> findByMemberId(Integer memberId);
//
//    @Transactional
//    @Modifying
//    @Query("delete from ClassMemberBean cmb where cmb.cBean.classId = :classId")
//    void deleteByClassId(Integer classId);
//
//    // @Query("from ClassBean cb where cb.className like :keyWord")
//    // List<ClassBean> findByClassNameContaining(String className);
//}
