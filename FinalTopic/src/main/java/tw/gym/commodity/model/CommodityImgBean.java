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
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Component
@Entity
@Table(name="CommodityImage")
public class CommodityImgBean implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int itemImgId;
	
	@Column(name="fk_item_id")
	@Transient
	private int itemId;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "fk_item_id")
	private CommodityBean item;
	
	private String imgSrc;
	
	public int getItemImgId() {
		return itemImgId;
	}
	public void setItemImgId(int itemImgId) {
		this.itemImgId = itemImgId;
	}
	public CommodityBean getItem() {
		return item;
	}
	public void setItem(CommodityBean item) {
		this.item = item;
	}

	public String getImgSrc() {
		return imgSrc;
	}
	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	
	
	
	
}
