package com.youwei.leshi.admin.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String account;
	
	public String nickname;
	
	public String pwd;
	
	public Date addtime;
	
	public Date lasttime;
	
}
