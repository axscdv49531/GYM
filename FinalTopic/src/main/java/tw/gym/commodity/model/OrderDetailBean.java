package tw.gym.commodity.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="OrderDetail")
@Component
public class OrderDetailBean implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer orderDetailId;
	
	@Column(name="fk_order_id", insertable=false, updatable = false)
	private Integer orderId;
	private Integer orderQty;
	private Double unitPrice;
	private Double subTotal;
	
	@JsonBackReference
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="fk_order_id")
	private OrdersBean order;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "itemId")
	private CommodityBean commodity;
	
	
	public OrderDetailBean() {
	}
	
	public OrderDetailBean(CommodityBean item, Integer orderQty, Double unitPrice) {
		super();
		this.commodity = item;
		this.orderQty = orderQty;
		this.unitPrice = unitPrice;
	}

	public Integer getOrderDetailId() {
		return orderDetailId;
	}

	public void setOrderDetailId(Integer orderDetailId) {
		this.orderDetailId = orderDetailId;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getOrderQty() {
		return orderQty;
	}

	public void setOrderQty(Integer orderQty) {
		this.orderQty = orderQty;
	}

	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Double getSubTotal() {
		return subTotal;
	}

	public void setSubTotal(Double subTotal) {
		this.subTotal = subTotal;
	}

	public OrdersBean getOrder() {
		return order;
	}

	public void setOrder(OrdersBean order) {
		this.order = order;
	}

	public CommodityBean getCommodity() {
		return commodity;
	}

	public void setCommodity(CommodityBean commodity) {
		this.commodity = commodity;
	}
	
	
	
}
