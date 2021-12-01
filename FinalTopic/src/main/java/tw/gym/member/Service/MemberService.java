package tw.gym.member.Service;

import java.util.List;

import tw.gym.member.Model.MemberBean;

public interface MemberService {
	
	public MemberBean insert(MemberBean memberBean);
	
	public MemberBean update(MemberBean memberBean);
	
	public void deleteById(Integer number);
	
	public MemberBean findByNumber(Integer number);
	
	public List<MemberBean> findAll();
	
	public MemberBean findByEmail(String email);
	
	public List<MemberBean> findByCourse(Integer courseId);


}
