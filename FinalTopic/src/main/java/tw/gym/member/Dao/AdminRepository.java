package tw.gym.member.Dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import tw.gym.member.Model.Admin;

public interface AdminRepository extends JpaRepository<Admin, Integer> {

	public Optional<Admin> findByEmail(String email);
}
