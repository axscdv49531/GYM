package tw.gym.menu.model;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
@Transactional
public class MenuServiceImp implements MenuService {

	
		private MenuDao mdao;
	@Autowired	
	public MenuServiceImp(MenuDao mdao) {
		
			this.mdao = mdao;
		}

	@Override
	public Menu findMenu(String menuName) {
		// TODO Auto-generated method stub
		return mdao.findMenu( menuName);
	}

	@Override
	public List<Menu> findAll() {
		// TODO Auto-generated method stub
		return mdao.findAll();
	}

	@Override
	public Menu insert(Menu menu) {
		// TODO Auto-generated method stub
		return mdao.save(menu);
	}

	@Override
	public Menu findById(Integer id) {
		Optional<Menu>op1 = mdao.findById(id);
		if(op1.isPresent()) {
			return op1.get();
		}
		return null;
	}

	@Override
	public void update(Menu menu) {
		 mdao.save(menu);
		
	}

//	@Override
//	public List<Menu> findAllExecptPicture() {
//		// TODO Auto-generated method stub
//		return mdao.findAllExecptPicture();
//	}


}
