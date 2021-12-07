package tw.gym.menu.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

import tw.gym.member.Model.MemberBean;

@Entity
@Table(name="ordermenu")
@Component()
public class OrderMenu {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="ID")
	private int id;
	
	@Column(name="ORDERID")
	private int orderid;
	
	@Column(name="QTY")
	private int qty;
	
	@Column(name="ORDERTIME")
	private Date ordertime;
	
	@Column(name="DELIVERYTIME")
	private Date deliverytime;
	
	@Column(name="STATUSE")
	private String statuse;
	
	@JsonIgnore
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "FK_MENU_ID")
	private Menu menu;
	
	@Column(name="PRICE")
	private int price;
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="FK_MEMBER_ID")
	private MemberBean memberBean;
	
	public OrderMenu() {
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public int getOrderId() {
		return orderid;
	}

	public int getQty() {
		return qty;
	}

	public Date getOrderTime() {
		return ordertime;
	}

	public Date getDeliveryTime() {
		return deliverytime;
	}

	public String getStatuse() {
		return statuse;
	}

	public Menu getMenu() {
		return menu;
	}

	public int getPrice() {
		return price;
	}

	

	public void setId(int id) {
		this.id = id;
	}

	public void setOrderId(int orderId) {
		this.orderid = orderId;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public void setOrderTime(Date orderTime) {
		this.ordertime = orderTime;
	}

	public void setDeliveryTime(Date deliveryTime) {
		this.deliverytime = deliveryTime;
	}

	public void setStatuse(String statuse) {
		this.statuse = statuse;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public MemberBean getMemberBean() {
		return memberBean;
	}

	public void setMemberBean(MemberBean memberBean) {
		this.memberBean = memberBean;
	}

	@Override
	public String toString() {
		return "OrderMenu [id=" + id + ", orderid=" + orderid + ", qty=" + qty + ", ordertime=" + ordertime
				+ ", deliverytime=" + deliverytime + ", statuse=" + statuse + ", menu=" + menu + ", price=" + price
				+ ", memberBean=" + memberBean + "]";
	}





	



	
	
	
}
