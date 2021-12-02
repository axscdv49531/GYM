package tw.gym.menu.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="menu")
@Component("menu")
public class Menu {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="ID")
	private int id;
	
	@Column(name="MENUNAME")
	private String menuname;
	
	@Column(name="PRICE")
	private int price;
	
	@Column(name="MENUQTY")
	private int menuqty;
	
//	@JsonIgnore
//	@Column(name="MENUPICTURE")
//	private byte[]menupicture;
	@Column(name="MENUDETAIL")
	private String menudetail;
	
	
	

	
	@OneToMany(mappedBy = "menu")
	private List<OrderMenu>orderMenus = new ArrayList();
	
	

	

	public Menu() {
		// TODO Auto-generated constructor stub
	}





	public int getId() {
		return id;
	}





	public String getMenuName() {
		return menuname;
	}





	public int getPrice() {
		return price;
	}





	public int getMenuQty() {
		return menuqty;
	}




//
//	public byte[] getMenuPicture() {
//		return menupicture;
//	}



	






	





	public void setId(int id) {
		this.id = id;
	}





	public String getMenudetail() {
		return menudetail;
	}





	public void setMenudetail(String menudetail) {
		this.menudetail = menudetail;
	}





	public void setMenuName(String menuName) {
		this.menuname = menuName;
	}





	public void setPrice(int price) {
		this.price = price;
	}





	public void setMenuQty(int menuQty) {
		this.menuqty = menuQty;
	}





//	public void setMenuPicture(byte[] menuPicture) {
//		this.menupicture = menuPicture;
//	}










	public List<OrderMenu> getOrderMenus() {
		return orderMenus;
	}





	public void setOrderMenus(List<OrderMenu> orderMenus) {
		this.orderMenus = orderMenus;
	}





	@Override
	public String toString() {
		return "Menu [id=" + id + ", menuname=" + menuname + ", price=" + price + ", menuqty=" + menuqty
				+ ", menudetail=" + menudetail + ", orderMenus=" + orderMenus + "]";
	}















	











	


	









	
	
	
	
	

}
