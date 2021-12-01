//package tw.gym.service;
//
//import java.util.List;
//
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import tw.gym.model.ClassBean;
//import tw.gym.model.ClassMemberBean;
//import tw.gym.model.MemberBean1;
//
//@Service
//@Transactional
//public interface MemberService1 {
//
//    MemberBean1 findByAccountAndPassword(String coachAccount, String coachPassword);
//
//    MemberBean1 getById(Integer memberId);
//
//    void insertReservation(ClassMemberBean cmBean, Integer a, Integer classId);
//
//    List<ClassBean> findByMemberId(Integer memberId);
//
//    void deleteByClassId(Integer classId, Integer a);
//
//    // List<ClassBean> findByKeyWord(String keyWord);
//
//}
