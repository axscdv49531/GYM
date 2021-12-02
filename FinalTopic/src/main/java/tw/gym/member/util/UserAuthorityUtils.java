package tw.gym.member.util;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;

import tw.gym.member.Model.MemberBean;

public class UserAuthorityUtils {
	
	private static final List<GrantedAuthority> ADMIN_ROLES = AuthorityUtils
			.createAuthorityList("ROLE_ADMIN", "ROLE_USER");
			//利用Spring提供的AuthorityUtils中createAuthorityList將該群組加入相關roles
			//以便用一個List變數就儲存所有roles
	private static final List<GrantedAuthority> USER_ROLES = AuthorityUtils
			.createAuthorityList("ROLE_MEMBER");

	public static Collection<? extends GrantedAuthority> createAuthorities(
			MemberBean member) {
		String username = member.getEmail();
		if (username.contains("admin")) { //帳號中含有admin，即有管理者之role
			return ADMIN_ROLES;
		}
		return USER_ROLES; //否則則為一般使用者
	}
}
