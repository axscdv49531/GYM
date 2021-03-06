package tw.gym.member.Dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.ClassBean;
import tw.gym.coach.model.CoachBean;
import tw.gym.member.Model.MemberBean;

public interface MemberRepository extends JpaRepository<MemberBean, Integer>, MemberRepositoryCustom {

    public Optional<MemberBean> findByEmail(String email);

    @Query(value = "from MemberBean where number=?1", nativeQuery = false)
    public MemberBean findByNumber(Integer number);

    //Dean:管理者查詢課程學生
    @Query(value = "SELECT m from MemberBean m LEFT JOIN m.MC mc where mc.course.id=:courseId AND mc.state='已加選'")
    public List<MemberBean> findByCourse(Integer courseId);
    
    @Query(value = "select mb from MemberBean mb where mb.email = :email")
    public MemberBean getMemberByEmail(String email);

    // // Mark
    // @Query("FROM MemberBean mb WHERE mb.memberAccount = :memberAccount and mb.memberPassword = :memberPassword")
    // MemberBean findByAccountAndPassword(String memberAccount, String memberPassword);

    // Mark
    @Query("From ClassBean cb where cb.classId in ( select cmb.cBean.classId From ClassMemberBean cmb where cmb.mBean.number in ( :number ) )")
    List<ClassBean> findByMemberId(Integer number, Sort sort);

    // Mark
    @Transactional
    @Modifying
    @Query("delete from ClassMemberBean cmb where cmb.cBean.classId = :classId")
    void deleteByClassId(Integer classId);

    // @Query(value="from MemberBean where email=?1")
    // public MemberBean findByEmail(String email);
}
