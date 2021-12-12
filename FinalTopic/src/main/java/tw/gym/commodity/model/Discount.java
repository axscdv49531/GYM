package tw.gym.commodity.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name ="Discount")
@Component
public class Discount implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ruleId")
	private RuleBase rule;
	private Integer amount;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "orderId")
	@JsonBackReference
	OrdersBean order;
	
	@Transient
	private List<CommodityBean> commodity;
	
	
	public Discount() {
	}

	public Discount(RuleBase rule, List<CommodityBean> commodity, Integer amount) {
		this.rule = rule;
		this.commodity = commodity;
		this.amount = amount;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public RuleBase getRule() {
		return rule;
	}
	public void setRule(RuleBase rule) {
		this.rule = rule;
	}	
	
	public Integer getAmount() {
		return amount;
	}
	
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	
	public List<CommodityBean> getCommodity() {
		return commodity;
	}

	public void setCommodity(List<CommodityBean> commodity) {
		this.commodity = commodity;
	}

	public OrdersBean getOrder() {
		return order;
	}

	public void setOrder(OrdersBean order) {
		this.order = order;
	}	
	
}
