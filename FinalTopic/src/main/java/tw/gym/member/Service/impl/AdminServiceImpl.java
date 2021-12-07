package tw.gym.member.Service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.member.Dao.AdminRepository;
import tw.gym.member.Model.Admin;
import tw.gym.member.Service.AdminService;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

	private AdminRepository adminRepository;

	@Autowired
	public AdminServiceImpl(AdminRepository adminRepository) {
		this.adminRepository = adminRepository;
	}

	@Override
	public Admin insert(Admin admin) {
		return adminRepository.save(admin);
	}

	@Override
	public Optional<Admin> findByEmail(String email) {
		Optional<Admin> admin = adminRepository.findByEmail(email);
		return admin;
	}

}
