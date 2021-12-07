package tw.gym.member.Service;

import java.util.Optional;

import tw.gym.member.Model.Admin;

public interface AdminService {
	
	public Admin insert(Admin admin);
	
	public Optional<Admin> findByEmail(String email);
}
