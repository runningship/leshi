package com.youwei.leshi.admin.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Post {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String title;
	
	public String conts;
	
	public Date addtime;
	
	public Date updatetime;
	
	//Board Id;
	public Integer bid;
	
}
