package tw.gym.member.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.ClassMemberBean;
import tw.gym.member.Model.MemberBean;

public interface MemberService {
	
	public MemberBean findBymNum(Integer number);
	
	public Page<MemberBean> findAllByPage(Pageable pageable);

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
    void insertReservation(ClassMemberBean cmBean);

    // Mark
    List<ClassBean> findByMemberId(Integer memberId);

    // Mark
    void deleteByClassId(Integer classId, Integer a);

}
