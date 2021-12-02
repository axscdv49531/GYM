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
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="cost")
@Component()
public class Cost {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="COSTID")
	private Integer costid;
	
	@Column(name="COSTITEM")
	private String costitem;
	
	@Column(name="COSTPRICE")
	private String costprice;
	
	@Column(name="COSTDAY")
	private Date costday;
	
	@JsonIgnore
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "FK_MENU_ID")
	private Menu menu;

	public Cost() {
		super();
	}

	public Integer getCostid() {
		return costid;
	}

	public String getCostitem() {
		return costitem;
	}

	public String getCostprice() {
		return costprice;
	}

	public Date getCostday() {
		return costday;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setCostid(Integer costid) {
		this.costid = costid;
	}

	public void setCostitem(String costitem) {
		this.costitem = costitem;
	}

	public void setCostprice(String costprice) {
		this.costprice = costprice;
	}

	public void setCostday(Date costday) {
		this.costday = costday;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	@Override
	public String toString() {
		return "Cost [costid=" + costid + ", costitem=" + costitem + ", costprice=" + costprice + ", costday=" + costday
				+ ", menu=" + menu + "]";
	}
	
	
	

}
