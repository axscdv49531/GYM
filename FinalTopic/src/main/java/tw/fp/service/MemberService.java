package tw.fp.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.fp.model.ClassBean;
import tw.fp.model.ClassMemberBean;
import tw.fp.model.MemberBean;

@Service
@Transactional
public interface MemberService {

    MemberBean findByAccountAndPassword(String coachAccount, String coachPassword);

    MemberBean getById(Integer memberId);

    void insertReservation(ClassMemberBean cmBean, Integer a, Integer classId);

    List<ClassBean> findByMemberId(Integer memberId);

    void deleteByClassId(Integer classId, Integer a);

    // List<ClassBean> findByKeyWord(String keyWord);

}
