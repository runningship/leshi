package com.youwei.leshi.admin.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.youwei.SimpDaoTool;

@Entity
public class Board {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String name;
	
	public String fname;
	
	public Integer fid;
	
	public Integer orderx;
	
	public List<Board> getChildren(){
		List<Board> list = SimpDaoTool.getGlobalCommonDaoService().listByParams(Board.class, "from Board where fid=? order by orderx" ,id);
		return list;
	}
}
