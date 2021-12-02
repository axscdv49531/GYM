package tw.gym.member.Service;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import tw.gym.member.Dao.MemberRepository;
import tw.gym.member.Model.MemberBean;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    MemberRepository memRepo;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        String userName = "";
        HttpSession session = request.getSession();
        // userName = ((User) authentication.getPrincipal()).getUsername();
        userName = authentication.getName();

        Optional<MemberBean> mBean = memRepo.findByEmail(userName);

        session.setAttribute("loginUser", mBean.get());

 
        response.sendRedirect("/login/welcome");

        // Collection<GrantedAuthority> authorities = null;
        // if (authentication.getPrincipal() instanceof Principal) {
        // userName = ((Principal) authentication.getPrincipal()).getName();
        // session.setAttribute("role", "none");
        // } else {
        // User loginUser = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        // session.setAttribute("role", String.valueOf(loginUser.getAuthorities()));
        // session.setAttribute("connectedUser",
        // managerFactory.getUserManager().findByUserName(userSpringSecu.getUsername()));
            // }
        // response.sendRedirect("/public/showAtlas");

    }

}
