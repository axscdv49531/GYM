package tw.gym.member.Service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.ClassMemberBean;
import tw.gym.coach.repository.ClassMemberRepository;
import tw.gym.coach.repository.ClassRepository;
import tw.gym.login.Validator.UserNotFoundException;
import tw.gym.member.Dao.MemberRepository;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.MemberService;

@Service
@Transactional
public class MemberServiceImpl implements MemberService {

    private MemberRepository memberRepository;

    // Mark
    // @Autowired
    // MemberRepository memRepo;
    // Mark
    @Autowired
    ClassMemberRepository cmRepo;
    // Mark
    @Autowired
    ClassRepository claRepo;

    @Autowired
    public MemberServiceImpl(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @Override
    public MemberBean insert(MemberBean memberBean) {
        return memberRepository.save(memberBean);
    }

    @Override
    public MemberBean update(MemberBean memberBean) {
        return memberRepository.save(memberBean);
    }

    @Override
    public void deleteById(Integer number) {
        memberRepository.deleteById(number);
    }

    @Override
    public MemberBean findByNumber(Integer number) {
        Optional<MemberBean> memberBean = memberRepository.findById(number);
        return memberBean.get();
    }

    @Override
    public List<MemberBean> findAll() {
        return memberRepository.findAll();
    }

    @Override
    public MemberBean findByEmail(String email) {
        Optional<MemberBean> member = memberRepository.findByEmail(email);
        // System.out.println(email);
        // System.out.println(member);
        if (member.isEmpty()) {
            throw new UserNotFoundException("Can't Find User");
        }
        return member.get();
    }
    
    @Override
    public Optional<MemberBean> findEmail(String email) {
    	 Optional<MemberBean> member = memberRepository.findByEmail(email);
         // System.out.println(email);
         // System.out.println(member);
//         if (member.isEmpty()) {
//             throw new UserNotFoundException("Can't Find User");
//         }
         return member;
    }
    
    @Override
    public MemberBean getMemberByEmail(String email) {
    	return memberRepository.getMemberByEmail(email);
    }

    public List<MemberBean> findByCourse(Integer courseId) {
        return memberRepository.findByCourse(courseId);
    }

    // // Mark
    // @Override
    // public MemberBean findByAccountAndPassword(String coachAccount, String coachPassword) {
    // return memberRepository.findByAccountAndPassword(coachAccount, coachPassword);
    // }

    // Mark
    @Override
    public MemberBean getById(Integer memberId) {
        return memberRepository.getById(memberId);
    }

    // Mark
    @Override
    public void insertReservation(ClassMemberBean cmBean, Integer a, Integer classId) {
        claRepo.setAvaliable(a, classId);
        cmRepo.save(cmBean);
    }

    // Mark
    @Override
    public List<ClassBean> findByMemberId(Integer memberId) {
        return memberRepository.findByMemberId(memberId);
    }

    // Mark
    @Override
    public void deleteByClassId(Integer classId, Integer a) {
        claRepo.setAvaliable(a, classId);
        memberRepository.deleteByClassId(classId);
    }



}
