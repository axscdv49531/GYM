package tw.gym.commodity.model;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Component
@Entity
@Table(name = "TotalPriceRule")
@PrimaryKeyJoinColumn(name = "TotalPriceRuleId")
public class TotalPriceDiscountRule extends RuleBase {
	private static final long serialVersionUID = 1L;
	
	private Integer minDiscountPrice;
	private Integer discountAmount;
	
	public TotalPriceDiscountRule() {
	}

	public TotalPriceDiscountRule(Integer minDiscountPrice, Integer discountAmount, Date start, Date end) {
		this.minDiscountPrice = minDiscountPrice;
		this.discountAmount = discountAmount;
		this.setStartTime(start);
		this.setEndTime(end);
		this.setName("2滿額折扣: 滿"+ minDiscountPrice +"元折抵"+discountAmount+"元");
		this.setNote("每次交易限用一次");		
	}

	public Integer getMinDiscountPrice() {
		return minDiscountPrice;
	}

	public void setMinDiscountPrice(Integer minDiscountPrice) {
		this.minDiscountPrice = minDiscountPrice;
	}

	public Integer getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(Integer discountAmount) {
		this.discountAmount = discountAmount;
	}


	@Override
	public List<Discount> process(ShoppingCart cart) {
		List<Discount> discounts = new ArrayList<>();
		if (cart.getTotalPrice() >= this.minDiscountPrice) {
			discounts.add(new Discount(this, null, this.discountAmount));
		}
		return discounts;
	}

}
