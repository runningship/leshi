package org.bc.hermes.admin.entity;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

/**
 * 规格
 */
@Entity
public class Spec {
	
	@Id
	public String id;
	
	public String name;
	
	//备注
	public String strDesc;

	public String textVals;
	
	public String imgVals;
	
	public Integer orderx;
	
//	@OneToMany
//	@JoinColumn(name="specName")
//	public Set<SpecVal> vals;
}
