package tw.gym.menu.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.stereotype.Component;

@Component
public class CalculateProduct {

	public List<Integer> showReport(List<OrderMenu>list) {
		int Quanty6=0;
		int Quanty3=0;
		int Quanty4=0;
		int Quanty5=0;
		int Quanty7=0;
		int Quanty9=0;
		int totalPrice6=0;
		int totalPrice3=0;
		int totalPrice4=0;
		int totalPrice5=0;
		int totalPrice7=0;
		int totalPrice9=0;
		
		int bestQuanty=0;
		int total=0;
		
			for(int i=0;i<list.size();i++) {
				String name=list.get(i).getMenu().getMenuName();
				Date date = list.get(i).getOrderTime();
				System.out.println(name+","+date);
				Integer qty=list.get(i).getQty();
				Integer price=list.get(i).getPrice();
				total += qty*price;
				if(name.equals("炙烤雞腿")) {
					Quanty3+=qty;
					totalPrice3+=qty*price;
					System.out.println("1");
				}else if(name.equals("香草豬排")) {
					Quanty4+=qty;
					totalPrice4+=qty*price;
					System.out.println("2");
				}else if(name.equals("椒麻雞胸")) {
					Quanty5+=qty;
					totalPrice5+=qty*price;
					System.out.println("3");
				}else if(name.equals("舒肥牛排")) {
					Quanty6+=qty;
					totalPrice6+=qty*price;
					System.out.println("4");
				}else if(name.equals("舒肥雞胸")) {
					Quanty7+=qty;
					totalPrice7+=qty*price;
					System.out.println("5");
				}else if(name.equals("蜜香排骨")) {
					Quanty9+=qty;
					totalPrice9+=qty*price;
					System.out.println("6");
				}	
			}
		
		
		bestQuanty=Quanty3;
		System.out.println("7");
			
		List<Integer>list2 = new ArrayList<Integer>();
			list2.add(Quanty3);
			list2.add(Quanty4);
			list2.add(Quanty5);
			list2.add(Quanty6);
			list2.add(Quanty7);
			list2.add(Quanty9);
			
			for(int i=0;i<list2.size();i++) {
				
				if(bestQuanty<list2.get(i)) {
					bestQuanty=list2.get(i);
				}
			}
			
			list2.add(totalPrice3);
			list2.add(totalPrice4);
			list2.add(totalPrice5);
			list2.add(totalPrice6);
			list2.add(totalPrice7);
			list2.add(totalPrice9);
			list2.add(bestQuanty);
			list2.add(total);
			System.out.println("8 -> " + list2);
			return list2;
		
	}
	
	
	


}
