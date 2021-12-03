package tw.gym.login.util;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;

import tw.gym.coach.model.CoachBean;
import tw.gym.member.Model.MemberBean;

public class UserAuthorityUtils {

	private static final List<GrantedAuthority> ADMIN_ROLES = AuthorityUtils.createAuthorityList("ROLE_ADMIN",
			"ROLE_MEMBER", "ROLE_COACH");
	// 利用Spring提供的AuthorityUtils中createAuthorityList將該群組加入相關roles
	// 以便用一個List變數就儲存所有roles
	private static final List<GrantedAuthority> MEMBER_ROLES = AuthorityUtils.createAuthorityList("ROLE_MEMBER");

	private static final List<GrantedAuthority> COACH_ROLES = AuthorityUtils.createAuthorityList("ROLE_COACH");

	public static Collection<? extends GrantedAuthority> createAuthorities(MemberBean member) {
		String username = member.getEmail();

		if (username.contains("admin")) { // 帳號中含有admin，即有管理者之role
			return ADMIN_ROLES;
		}
		return MEMBER_ROLES; // 其餘皆為member之role

	}

	public static Collection<? extends GrantedAuthority> createAuthorities(CoachBean coach) {
		String username = coach.getCoachEmail();
		if (username.contains("admin")) { // 帳號中含有admin，即有管理者之role
			return ADMIN_ROLES;
		}
		return COACH_ROLES;
	}


}
