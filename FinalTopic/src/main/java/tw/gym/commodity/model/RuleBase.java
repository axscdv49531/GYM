package tw.gym.commodity.model;

import java.io.Serializable;
import java.sql.Blob;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Component
@Entity
@Table(name = "RuleBase")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class RuleBase implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String name;
	private String note;
	private Date startTime;
	private Date endTime;
	
	@JsonIgnore
	private String mimeType;
	
	@JsonIgnore
	private Blob image;
	
	@JsonIgnore
	@Transient
	private MultipartFile photo;
	
	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinTable(name = "RuleBase_Commodity", joinColumns = {@JoinColumn(name="fk_ruleBaseId", referencedColumnName = "id")},
			inverseJoinColumns = {@JoinColumn(name="fk_commodityId", referencedColumnName = "itemId")})
	private Set<CommodityBean> commodity = new HashSet<CommodityBean>();
	
	@JsonIgnore
	@OneToMany(fetch= FetchType.LAZY, mappedBy="order", cascade=CascadeType.ALL)
	private Set<Discount> discount;
	
	public abstract List<Discount> process(ShoppingCart cart);
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Set<CommodityBean> getCommodity() {
		return commodity;
	}

	public void setCommodity(Set<CommodityBean> commodity) {
		this.commodity = commodity;
	}
	
	public Set<Discount> getDiscount() {
		return discount;
	}

	public void setDiscount(Set<Discount> discount) {
		this.discount = discount;
	}

	public String getMimeType() {
		return mimeType;
	}

	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}

	public Blob getImage() {
		return image;
	}

	public void setImage(Blob image) {
		this.image = image;
	}

	public MultipartFile getPhoto() {
		return photo;
	}

	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}

	
//	Hibernate: 
//	    insert 
//	    into
//	        RuleBase
//	        (endTime, name, note, startTime) 
//	    values
//	        (?, ?, ?, ?)
//	Hibernate: 
//	    insert 
//	    into
//	        BuyMoreRule
//	        (itemCount, percentOff, targetTag, BuyMoreRuleId) 
//	    values
//	        (?, ?, ?, ?)
//	Hibernate: 
//	    insert 
//	    into
//	        RuleBase
//	        (endTime, name, note, startTime) 
//	    values
//	        (?, ?, ?, ?)
//	Hibernate: 
//	    insert 
//	    into
//	        TotalPriceRule
//	        (discountAmount, minDiscountPrice, TotalPriceRuleId) 
//	    values
//	        (?, ?, ?)
//	Hibernate: 
//	    select
//	        rulebase0_.id as id1_8_,
//	        rulebase0_.endTime as endtime2_8_,
//	        rulebase0_.name as name3_8_,
//	        rulebase0_.note as note4_8_,
//	        rulebase0_.startTime as starttim5_8_,
//	        rulebase0_1_.itemCount as itemcoun1_1_,
//	        rulebase0_1_.percentOff as percento2_1_,
//	        rulebase0_1_.targetTag as targetta3_1_,
//	        rulebase0_2_.discountAmount as discount1_11_,
//	        rulebase0_2_.minDiscountPrice as mindisco2_11_,
//	        case 
//	            when rulebase0_1_.BuyMoreRuleId is not null then 1 
//	            when rulebase0_2_.TotalPriceRuleId is not null then 2 
//	            when rulebase0_.id is not null then 0 
//	        end as clazz_ 
//	    from
//	        RuleBase rulebase0_ 
//	    left outer join
//	        BuyMoreRule rulebase0_1_ 
//	            on rulebase0_.id=rulebase0_1_.BuyMoreRuleId 
//	    left outer join
//	        TotalPriceRule rulebase0_2_ 
//	            on rulebase0_.id=rulebase0_2_.TotalPriceRuleId
	
	
}
