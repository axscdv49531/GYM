package tw.gym.coach.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.gym.coach.model.CoachBean;

public interface CoachRepository extends JpaRepository<CoachBean, Integer> {

	@Query(value = "FROM CoachBean cb WHERE cb.coachEmail = :email")
	Optional<CoachBean> findByEmail(String email);
	
    @Query(value = "select cb from CoachBean cb where cb.coachAccount = :account")
    CoachBean getCoachByAccount(String account);

    @Query(value = "FROM CoachBean cb WHERE cb.coachAccount = :coachAccount and cb.coachPassword = :coachPassword")
    CoachBean findByAccountAndPassword(String coachAccount, String coachPassword);

    @Query(value = "select cb from CoachBean cb where cb.coachName = :coachName")
    CoachBean getCoachByName(String coachName);
}
