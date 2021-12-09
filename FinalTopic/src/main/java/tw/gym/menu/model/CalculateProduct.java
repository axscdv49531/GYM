package tw.gym.menu.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.stereotype.Component;

@Component
public class CalculateProduct {
	
	

	public Map<String,Integer> showReport(List<OrderMenu>list) {
	


		Map<String,Integer> Qty= new HashMap<String,Integer>();

		
			for(int i=0;i<list.size();i++) {
				String name=list.get(i).getMenu().getMenuName();
				Integer qty=list.get(i).getQty();
				
				if(Qty.get(name)!=null) {
					Qty.put(name,Qty.get(name)+qty);
					System.out.println("product"+name+"="+qty);
				}else {
					Qty.put(name, qty);
					System.out.println("product"+name+"="+qty);
				}

			}
			
			
		
			
			
			
			
			
			return Qty;
	
	}
	
	

}
