package tw.gym.commodity.model;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

public class ShoppingCart {
	
	private Map<Integer, OrderDetailBean> cart = new LinkedHashMap<>();

	public ShoppingCart() {
	}
	

	public Map<Integer, OrderDetailBean> getContent() {
		return cart;
	}

	public void addToCart(int id, OrderDetailBean odb) {
		if (cart.get(id) == null) {
			cart.put(id, odb);
		}else {
			OrderDetailBean odbInCart = cart.get(id);
			odbInCart.setOrderQty(odb.getOrderQty());
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
	
	public double getTotal() {
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
		for(int key : keySet) {
			OrderDetailBean odb = cart.get(key);
			nums += odb.getOrderQty();
		}
		return nums;
	}
	
}
