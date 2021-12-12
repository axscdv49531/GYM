package tw.gym.commodity.model;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ShoppingCart {
	
	private Map<Integer, OrderDetailBean> cart = new LinkedHashMap<>();
	private List<Discount> appliedDiscount = new ArrayList<>();
	private double totalPrice;

	public ShoppingCart() {
	}
	
	public List<Discount> getAppliedDiscount() {
		return appliedDiscount;
	}

	public void setAppliedDiscount(List<Discount> appliedDiscount) {
		this.appliedDiscount = appliedDiscount;
	}
	
	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Map<Integer, OrderDetailBean> getContent() {
		return cart;
	}

	public void addToCart(int id, OrderDetailBean odb) {
		if (cart.get(id) == null) {
			cart.put(id, odb);
		}else {
			OrderDetailBean odbInCart = cart.get(id);
			odbInCart.setOrderQty(odbInCart.getOrderQty() + odb.getOrderQty());
//			odbInCart.setOrderQty(odb.getOrderQty());
		}
	}
	
	public int deleteItem(int id) {
		if(cart.get(id)!=null) {
			cart.remove(id);
			return 1;
		}else {
			return 0;
		}
	}


	public double processTotal() {
		double total = 0;
		Set<Integer> keySet = cart.keySet();
		for(int key : keySet) {
			double subtotal = 0;
			OrderDetailBean odb = cart.get(key);
			subtotal = odb.getOrderQty() * odb.getUnitPrice();
			odb.setSubTotal(subtotal);
			total += subtotal;
		}
		return total;
	}
	
	public Integer getVolume() {
		int nums = 0;
		Set<Integer> keySet = cart.keySet();
		System.out.println("keySet size :"+ keySet.size());
		for(int key : keySet) {
			OrderDetailBean odb = cart.get(key);
			nums += odb.getOrderQty();
			System.out.println(nums);
		}
		return nums;
	}
	
}
