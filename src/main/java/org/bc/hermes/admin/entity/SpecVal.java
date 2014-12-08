package org.bc.hermes.admin.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 规格
 */
@Entity
public class SpecVal {
	
	@Id
	public String id;
	
	public String name;
	
	public String img;
	
	public Integer orderx;

	public String specId;
	
//	@ManyToOne
//	@JoinColumn(name="name")//关联表的连接字段
//	public Spec spec;
}
