package tw.gym.member.Service;

import java.util.List;

import tw.gym.member.Model.MemberBean;
import tw.gym.model.ClassBean;
import tw.gym.model.ClassMemberBean;

public interface MemberService {

    public MemberBean insert(MemberBean memberBean);

    public MemberBean update(MemberBean memberBean);

    public void deleteById(Integer number);

    public MemberBean findByNumber(Integer number);

    public List<MemberBean> findAll();

    public MemberBean findByEmail(String email);

    public List<MemberBean> findByCourse(Integer courseId);

    // // Mark
    // MemberBean findByAccountAndPassword(String coachAccount, String coachPassword);

    // Mark
    MemberBean getById(Integer memberId);

    // Mark
    void insertReservation(ClassMemberBean cmBean, Integer a, Integer classId);

    // Mark
    List<ClassBean> findByMemberId(Integer memberId);

    // Mark
    void deleteByClassId(Integer classId, Integer a);

}
