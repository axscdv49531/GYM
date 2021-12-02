package tw.gym.menu.model;

import java.util.List;
import java.util.Optional;

public interface MenuService {
	public Menu findMenu(String menuName);
	public List<Menu> findAll();
	public Menu insert(Menu menu);
//	public List<Menu> findAllExecptPicture();
	public Menu findById(Integer id);
	public void update(Menu menu);

}
