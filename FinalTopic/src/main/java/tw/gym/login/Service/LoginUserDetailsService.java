package tw.gym.login.Service;

import java.util.Collections;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.coach.model.CoachBean;
import tw.gym.coach.service.CoachService;
import tw.gym.login.Validator.UserNotFoundException;
import tw.gym.member.Model.Admin;
import tw.gym.member.Model.MemberBean;
import tw.gym.member.Service.AdminService;
import tw.gym.member.Service.MemberService;

@Service
@Transactional
public class LoginUserDetailsService implements UserDetailsService {

    @Autowired
    private MemberService memberService;

    @Autowired
    private CoachService coachService;

    @Autowired
    private AdminService adminService;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        Optional<MemberBean> member = memberService.findEmail(email);
        if (member.isEmpty()) {
            Optional<CoachBean> coach = coachService.findByEmail(email);
            if (coach.isEmpty()) {
                Optional<Admin> admin = adminService.findByEmail(email);
                if (admin.isEmpty()) {
                    throw new UserNotFoundException("Can't Find User");
                } else {
                    Integer aStatus = admin.get().getStatus();
                    if (aStatus == -1) {
                        throw new DisabledException(
                                admin.get().getId() + "It is first login. Password change is required!");
                    }
                    System.out.println(1000);
                    return new User(admin.get().getEmail(), admin.get().getPassword(), Collections.emptyList());
                }
            } else {
                // Collection<? extends GrantedAuthority> authorities=
                // UserAuthorityUtils.createAuthorities(coach.get());
                Integer cStatus = coach.get().getCoachStatus();
                if (cStatus == -1) {
                    throw new DisabledException(
                            coach.get().getCoachId() + "It is first login. Password change is required!");
                }
                System.out.println(3);
                return new User(coach.get().getCoachEmail(), coach.get().getCoachPassword(), Collections.emptyList());
            }
        } else {
            // Collection<? extends GrantedAuthority> authorities=
            // UserAuthorityUtils.createAuthorities(member.get());
            Integer mStatus = member.get().getStatus();
            if (mStatus == -1) {
                throw new DisabledException(
                        member.get().getNumber() + "It is first login. Password change is required!");
            }
            System.out.println(4);
            return new User(member.get().getEmail(), member.get().getPassword(), Collections.emptyList());
        }
    }
    // @Override
    // public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
    // MemberBean member = memberService.findByEmail(email);
    // if (member == null) {
    // CoachBean coach = coachService.findByEmail(email);
    // Collection<? extends GrantedAuthority> authorities=
    // UserAuthorityUtils.createAuthorities(coach);
    // return new User(coach.getCoachEmail(), coach.getCoachPassword(), authorities);
    // }
    // Collection<? extends GrantedAuthority> authorities=
    // UserAuthorityUtils.createAuthorities(member);
    // //UserAuthorityUtils是helper class
    // return new User(member.getEmail(), member.getPassword(), authorities);
    // }

}
