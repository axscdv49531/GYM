package tw.gym.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.gym.model.CoachBean;

public interface CoachRepository extends JpaRepository<CoachBean, Integer> {

    @Query(value = "select cb from CoachBean cb where cb.coachAccount = :account")
    CoachBean getCoachByAccount(String account);

    @Query(value = "FROM CoachBean cb WHERE cb.coachAccount = :coachAccount and cb.coachPassword = :coachPassword")
    CoachBean findByAccountAndPassword(String coachAccount, String coachPassword);
}
