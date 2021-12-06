package tw.gym.menu.model;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class CreatOrderId {
	@Autowired
	private OrderMenuService service;
	String id ;
	int result;
	



	public int orderid() {
	
	                                                                                                                                                                 
		while(true) {
			 id ="";
			 for(int i=1;i<=6;i++) {
				 	int number=(int)(Math.random()*10);
					id=id+number;	
					System.out.println(id);	
			 }
			 
			 if(id.length()<6) {
				 continue;
			 }
			 
			
			result=Integer.valueOf(id);
				if(service.findAllByOrderId(result).size()==0) {
					 break;
				}	 
		
		}
		return result;
	}
}
