package tw.gym.commodity.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="Orders")
@Component
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
public class OrdersBean implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer orderId;
	
	private Integer memberId;
	private Date orderDate;
	private Date pickUpDate;
	private Double totalAmt;
	private Integer status;

	
	@JsonManagedReference
	@OneToMany(fetch= FetchType.LAZY, mappedBy="order", cascade=CascadeType.ALL)
	private Set<OrderDetailBean> orderDetails;
	
	@JsonManagedReference
	@OneToMany(fetch= FetchType.LAZY, mappedBy="order", cascade=CascadeType.ALL)
	private Set<Discount> discount;
	
	
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public Date getPickUpDate() {
		return pickUpDate;
	}
	public void setPickUpDate(Date pickUpDate) {
		this.pickUpDate = pickUpDate;
	}
	
	public Double getTotalAmt() {
		return totalAmt;
	}
	public void setTotalAmt(Double totalAmt) {
		this.totalAmt = totalAmt;
	}
	
	public Set<OrderDetailBean> getOrderDetails() {
		return orderDetails;
	}
	public void setOrderDetails(Set<OrderDetailBean> orderDetails) {
		this.orderDetails = orderDetails;
	}
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Set<Discount> getDiscount() {
		return discount;
	}
	public void setDiscount(Set<Discount> discount) {
		this.discount = discount;
	}
	
	
	
	

}
