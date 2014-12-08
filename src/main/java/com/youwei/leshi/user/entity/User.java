package com.youwei.leshi.user.entity;

import java.util.Date;

import javax.persistence.Cacheable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * 终端用户
 */
@Entity
@Table(name="uc_user")
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String uname;
	
	/**
	 * 登录帐号
	 */
	public String lname;
	
	public String pwd;
	
	public Date addtime;
	
	public Date lasttime;
	
	public Integer roleId;
	
	public Integer lock;
	
	public String tel;
	
	public String ip;
	
	public String address;
	
	public Integer gender;
	
}
