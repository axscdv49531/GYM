package tw.gym.member.Service;

import java.util.List;
import java.util.Optional;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.ClassMemberBean;
import tw.gym.member.Model.MemberBean;

public interface MemberService {

    public MemberBean insert(MemberBean memberBean);

    public MemberBean update(MemberBean memberBean);

    public void deleteById(Integer number);

    public MemberBean findByNumber(Integer number);

    public List<MemberBean> findAll();

    public MemberBean findByEmail(String email);

    public MemberBean getMemberByEmail(String email);
    
    public Optional<MemberBean> findEmail(String email);

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
