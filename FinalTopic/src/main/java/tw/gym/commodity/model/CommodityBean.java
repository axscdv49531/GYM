package tw.gym.commodity.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

@Component
@Entity
@Table(name="Commodity")
public class CommodityBean implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer itemId;

	private String itemName;
	private Integer itemStock;
	private Double unitPrice;
	private String itemDesc;
	
	@Column(updatable=false)
	private Date lastUpdated;
	
	@JsonProperty("onSale")
	private Boolean onSale;
	private String vendorName;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "item", cascade = CascadeType.ALL)
	private Set<CommodityImgBean> commodityImgs = new LinkedHashSet<CommodityImgBean>();
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name= "itemTypeId")
	private ItemTypeBean itemType;
	
	@JsonIgnore
	@Transient
	private MultipartFile[] file;
	
	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Integer getItemStock() {
		return itemStock;
	}

	public void setItemStock(Integer itemStock) {
		this.itemStock = itemStock;
	}

	public Double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getItemDesc() {
		return itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public Date getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated(Date lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	public Boolean getOnSale() {
		return onSale;
	}

	public void setOnSale(Boolean onSale) {
		this.onSale = onSale;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public Set<CommodityImgBean> getCommodityImgs() {
		return commodityImgs;
	}

	public void setCommodityImgs(Set<CommodityImgBean> commodityImgs) {
		this.commodityImgs = commodityImgs;
	}

	public MultipartFile[] getFile() {
		return file;
	}

	public void setFile(MultipartFile[] file) {
		this.file = file;
	} 
	
	public ItemTypeBean getItemType() {
		return itemType;
	}

	public void setItemType(ItemTypeBean itemType) {
		this.itemType = itemType;
	}
	
}
