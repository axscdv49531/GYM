package tw.gym.menu.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;



public interface MenuDao extends JpaRepository<Menu, Integer> {
	@Query(value="Select * From Menu where menuName = ?1",nativeQuery=true)
	public Menu findMenu(String menuName);
//	@Transactional(timeout = 10)
//	@Query(value="Select id,menuname,price,menuqty From Menu",nativeQuery=true)
//	public List<Menu> findAll();
	
	
}
