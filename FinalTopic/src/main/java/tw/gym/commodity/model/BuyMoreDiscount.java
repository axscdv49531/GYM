package tw.gym.commodity.model;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

//同商品任X件Y折
@Component
@Entity
@Table(name ="BuyMoreRule")
@PrimaryKeyJoinColumn(name = "BuyMoreRuleId")
public class BuyMoreDiscount extends RuleBase {
	private static final long serialVersionUID = 1L;
	
	private Integer itemCount;
	private Integer percentOff;
	
	public BuyMoreDiscount() {
	}

	public BuyMoreDiscount(Integer itemCount, Integer percentOff, Date start, Date end) {
		this.itemCount = itemCount;
		this.percentOff = percentOff;
		this.setName("1滿件折扣: 同一商品-任"+ itemCount +"件結帳"+ (100-percentOff) +"折!");
		this.setNote("指定商品且需同一商品項目");
		this.setStartTime(start);
		this.setEndTime(end);
	}

	public Integer getItemCount() {
		return itemCount;
	}

	public void setItemCount(Integer itemCount) {
		this.itemCount = itemCount;
	}

	public Integer getPercentOff() {
		return percentOff;
	}

	public void setPercentOff(Integer percentOff) {
		this.percentOff = percentOff;
	}

	@Override
	public List<Discount> process(ShoppingCart cart) {
		
		List<CommodityBean> matched_commodity = new ArrayList<>();
		List<Discount> discounts = new ArrayList<Discount>();
		
		Map<Integer, OrderDetailBean> content = cart.getContent();
		Set<Integer> keySet = content.keySet();
		for (Integer key : keySet) {//call every commodity in cart
			OrderDetailBean odb = content.get(key);
			CommodityBean bean = odb.getCommodity();
					
			for (CommodityBean ele : this.getCommodity()) {
				if (ele.getItemId().equals(bean.getItemId())) {
					int count = odb.getOrderQty()/this.itemCount;
					if (count > 0) {
						for (int i = 0; i<count; i++) {
							matched_commodity.add(bean);
							int amt = (int) Math.round(this.itemCount*bean.getUnitPrice()*this.percentOff/100);
							discounts.add(new Discount(this, matched_commodity, amt));
							matched_commodity = new ArrayList<>();
						}
					}
					break;
				}
			}
				
		}
		return discounts;
	}

}
