<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf8">
<script src="./服务网点 - 顺驰（中国）不动产网络集团_files/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&ak=D27d1e49cc18403146d9aead1be9b520&services=&t=20141204161725"></script>
<style type="text/css">
.ditu_map{ width:1000px; height:448px; border:solid 1px #d2d2d2;}
</style>
<script type="text/javascript">
var data = JSON.parse('[{"LAT":"31.307687","NAME":"金门路连锁店","ADDRESS":"金门路905号银杏苑底墒","ID":"1176","LNG":"120.584438","TELEPHONE":"68621886"},{"LAT":"31.298527","NAME":"三香路连锁店","ADDRESS":"彩香二村3幢底层12号房","ID":"1177","LNG":"120.588199","TELEPHONE":"68660071"},{"LAT":"31.27718","NAME":"新康连锁店","ADDRESS":"解放西路144号金地名园西门","ID":"1178","LNG":"120.59506","TELEPHONE":"80983239"},{"LAT":"31.29705","NAME":"金山路连锁店","ADDRESS":"金山路48号","ID":"1179","LNG":"120.56083","TELEPHONE":"68079571"},{"LAT":"31.2867","NAME":"名馨连锁店","ADDRESS":"名馨花园246-04","ID":"1180","LNG":"120.5572","TELEPHONE":"80982787"},{"LAT":"31.28272","NAME":"新升新苑连锁店","ADDRESS":"新升新苑新生路商业房7号","ID":"1181","LNG":"120.53725","TELEPHONE":"68070270"},{"LAT":"31.28521","NAME":"馨泰花苑连锁店","ADDRESS":"馨泰花苑商业房5幢1C","ID":"1182","LNG":"120.55532","TELEPHONE":"68086713"},{"LAT":"31.30244","NAME":"滨河路连锁店","ADDRESS":"滨河路1555号16幢底层二单元","ID":"1183","LNG":"120.56568","TELEPHONE":"68417268"},{"LAT":"31.2898","NAME":"国际公馆连锁店","ADDRESS":"玉山路18号国际公馆1幢21号","ID":"1184","LNG":"120.5698","TELEPHONE":"80982789"},{"LAT":"31.30683","NAME":"何山路连锁店","ADDRESS":"何山路88-3","ID":"1185","LNG":"120.55542","TELEPHONE":"68417238"},{"LAT":"31.323092","NAME":"东港新村连锁店","ADDRESS":"东港新村171-7","ID":"1186","LNG":"120.648822","TELEPHONE":"67603608"},{"LAT":"31.320993","NAME":"日规路连锁店","ADDRESS":"日规路3号","ID":"1187","LNG":"120.643927","TELEPHONE":"67602316"},{"LAT":"31.329242","NAME":"苏安新村连锁店","ADDRESS":"苏安新村186-104","ID":"1188","LNG":"120.644072","TELEPHONE":"67603779"},{"LAT":"31.3188","NAME":"天域连锁店","ADDRESS":"天域花园2期商业街17商幢002室底层","ID":"1189","LNG":"120.6732","TELEPHONE":"62885618"}]');
$(function(){
	//创建map对象 
	var map = new BMap.Map("allmap"); 
	//定义地图中心点 和 地图等级
	var map_level = "14";
	map.centerAndZoom(new BMap.Point("120.55532","31.28521"), map_level);
	//地图覆盖物数组
	var myArea = new Array();
	//创建 overlay 对象方法
	function ComplexCustomOverlay(point, id, telephone,name,address){
	      this._point = point;
	      this._id = id;
	      this._telephone = telephone;
		  this._name = name;
		  this._address = address;
	}
	
	//向地图添加标注 
	function addMarker(stat_lng,stat_lat,stat_name) {
	     map.clearOverlays();   
	    //将地图中心店调整至 地铁站A的所在坐标点
	    map.centerAndZoom(new BMap.Point(stat_lng,stat_lat), map_level); 
		map.addControl(new BMap.NavigationControl()); 
		var icon = new BMap.Icon('http://www.allfang.com/special_topic/suzhou/tenyears/images/su_51.png', new BMap.Size(25, 37), {
			anchor: new BMap.Size(10, 30)
		});	
		var mkr = new BMap.Marker(new BMap.Point(stat_lng,stat_lat), {
			icon: icon
		});	
		map.addOverlay(mkr);	 	
		//设置 ComplexCustomOverlay 参数 样式 偏移量等等数据
		ComplexCustomOverlay.prototype = new BMap.Overlay();
	    ComplexCustomOverlay.prototype.initialize = function(map){
	      this._map = map;
	      var div = this._div = document.createElement("div");
	      div.style.position = "absolute";
	      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
	      div.style.background = "url(http://www.sunco.cn/images/ser_07.png) no-repeat";     
	      div.style.height = "68px";
		  div.style.width = "58px";
		  div.style.cursor = "pointer";
		  
	      var div1 = this._div1 = document.createElement("div");
		  div1.style.position = "absolute";
		  div1.style.height = "129px";
		  div1.style.width = "332px";  
		  div1.style.background = "url(http://www.sunco.cn/images/ser_03.png) no-repeat";   
		  div1.style.margin = "-140px 0px 0px -35px";
		  div1.style.display = "none";	
		  
		  var divewm = this._divewm = document.createElement("div"); 
		  divewm.style.height = "100px";
		  divewm.style.width = "100px";
		  divewm.style.margin = "6px 6px 6px 6px";
		  div1.appendChild(divewm); 
		  
		  var ewmImg = this._ewmImg = document.createElement("img");	  
		  ewmImg.src = "http://www.allfang.com/allfang/upload_date/sunco/shopImg/"+this._id+".png";
		  divewm.appendChild(ewmImg);
		  
		  var divInfo = this._divInfo = document.createElement("div"); 
		  divInfo.style.margin = "-100px 0px 0px 125px";
		  divInfo.style.lineHeight = "26px";
		  divInfo.style.float = "left";
		  div1.appendChild(divInfo); 
		  
		  var span = this._span = document.createElement("span");
		  span.style.color = "#fff";
		  span.style.fontSize = "18px";
		  span.style.fontFamily = "黑体";
		  span.style.display = "block";
	      divInfo.appendChild(span);
		  span.appendChild(document.createTextNode(this._name));   
		  
		  var spanTele = this._spanTele = document.createElement("span");
		  spanTele.style.color = "#fff";
		  spanTele.style.fontSize = "14px";
		  spanTele.style.fontFamily = "宋体";
		  spanTele.style.display = "block";
	      divInfo.appendChild(spanTele);
		  spanTele.appendChild(document.createTextNode("电话："+this._telephone)); 
		  
		  var spanAddr = this._spanAddr = document.createElement("span");
		  spanAddr.style.color = "#fff";
		  spanAddr.style.fontSize = "12px";
		  spanAddr.style.fontFamily = "宋体";
		  spanAddr.style.display = "block";
	      divInfo.appendChild(spanAddr);
		  spanAddr.appendChild(document.createTextNode("地址："+this._address));	  
		  
		  
		  div.appendChild(div1);
		  
	      var that = this;
	      var arrow = this._arrow = document.createElement("div");
	      arrow.style.background = "url(http://www.allfang.com/special_topic/suzhou/tenyears/images/su2222.png) no-repeat";
	      arrow.style.position = "absolute";
	      arrow.style.width = "17px";
	      arrow.style.height = "13px";
	      arrow.style.top = "22px";
	      arrow.style.left = "10px";
	      arrow.style.overflow = "hidden";
		  
		   div.onmouseover = function(){
		   div1.style.display = "";
		   }
		    div.onmouseout = function(){
			div1.style.display = "none";
			}
		 
		 // 将div添加到覆盖物容器中  
		 map.getPanes().labelPane.appendChild(div);        
		 // 保存div实例 
		 this._div = div;         
	      return div;
	    }
	    ComplexCustomOverlay.prototype.draw = function(){
	      var _map = this._map;
	      var pixel = _map.pointToOverlayPixel(this._point);
	      this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
	      this._div.style.top  = pixel.y - 30 + "px";
	    }
		
		var data = eval(stat_name);	
		for(var i=0;i<data.length;i++) {
			myArea[0] = new ComplexCustomOverlay(new BMap.Point(data[i].LNG, data[i].LAT), data[i].ID,data[i].TELEPHONE,data[i].NAME,data[i].ADDRESS);
			map.addOverlay(myArea[0]);		
		}
	}
	
	addMarker("120.55532","31.28521",data);
});




</script>
</head>
<body>
<div id="conntain">
  <!--底部内容开始-->
  <div id="allmap" class="ditu_map marginbottom100" style="overflow: hidden; position: relative; z-index: 0; color: rgb(0, 0, 0); text-align: left; background-color: rgb(243, 241, 236);"><div style="overflow: visible; position: absolute; z-index: 0; left: 0px; top: 0px; cursor: url(http://api0.map.bdimg.com/images/openhand.cur) 8 8, default;"><div class="BMap_mask" style="position: absolute; left: 0px; top: 0px; z-index: 9; overflow: hidden; -webkit-user-select: none; width: 1000px; height: 448px;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 200;"><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 800;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 700;"><span class="BMap_Marker BMap_noprint" unselectable="on" "="" style="position: absolute; padding: 0px; margin: 0px; border: 0px; cursor: pointer; width: 25px; height: 37px; left: 490px; top: 194px; z-index: -6257042; -webkit-user-select: none; background: url(http://api0.map.bdimg.com/images/blank.gif);" title=""></span><span class="BMap_Marker BMap_noprint" unselectable="on" "="" style="position: absolute; padding: 0px; margin: 0px; border: 0px; cursor: pointer; width: 18px; height: 18px; left: 547px; top: 74px; z-index: 19000000; -webkit-user-select: none; display: none; background: url(http://api0.map.bdimg.com/images/blank.gif);" title=""></span></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 600;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 500;"><div style="position: absolute; z-index: -6261536; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 693px; top: 12px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1176.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">金门路连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：68621886</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：金门路905号银杏苑底墒</span></div></div></div><div style="position: absolute; z-index: -6259704; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 719px; top: 86px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1177.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">三香路连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：68660071</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：彩香二村3幢底层12号房</span></div></div></div><div style="position: absolute; z-index: -6255436; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 766px; top: 259px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1178.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">新康连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：80983239</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：解放西路144号金地名园西门</span></div></div></div><div style="position: absolute; z-index: -6259410; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 528px; top: 98px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1179.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">金山路连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：68079571</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：金山路48号</span></div></div></div><div style="position: absolute; z-index: -6257340; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 503px; top: 182px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1180.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">名馨连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：80982787</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：名馨花园246-04</span></div></div></div><div style="position: absolute; z-index: -6256544; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 364px; top: 214px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1181.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">新升新苑连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：68070270</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：新升新苑新生路商业房7号</span></div></div></div><div style="position: absolute; z-index: -6257042; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 490px; top: 194px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1182.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">馨泰花苑连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：68086713</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：馨泰花苑商业房5幢1C</span></div></div></div><div style="position: absolute; z-index: -6260488; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 562px; top: 54px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1183.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">滨河路连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：68417268</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：滨河路1555号16幢底层二单元</span></div></div></div><div style="position: absolute; z-index: -6257960; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 591px; top: 157px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1184.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">国际公馆连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：80982789</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：玉山路18号国际公馆1幢21号</span></div></div></div><div style="position: absolute; z-index: -6261366; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 491px; top: 19px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1185.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">何山路连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：68417238</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：何山路88-3</span></div></div></div><div style="position: absolute; z-index: -6264618; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 1141px; top: -113px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1186.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">东港新村连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：67603608</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：东港新村171-7</span></div></div></div><div style="position: absolute; z-index: -6264198; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 1106px; top: -96px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1187.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">日规路连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：67602316</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：日规路3号</span></div></div></div><div style="position: absolute; z-index: -6265848; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 1107px; top: -163px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1188.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">苏安新村连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：67603779</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：苏安新村186-104</span></div></div></div><div style="position: absolute; z-index: -6263760; height: 68px; width: 58px; cursor: pointer; -webkit-user-select: none; left: 1310px; top: -78px; background: url(http://www.sunco.cn/images/ser_07.png) no-repeat;"><div style="position: absolute; height: 129px; width: 332px; margin: -140px 0px 0px -35px; display: none; background: url(http://www.sunco.cn/images/ser_03.png) no-repeat;"><div style="height: 100px; width: 100px; margin: 6px;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/1189.png"></div><div style="margin: -100px 0px 0px 125px; line-height: 26px; float: left;"><span style="color: rgb(255, 255, 255); font-size: 18px; font-family: 黑体; display: block;">天域连锁店</span><span style="color: rgb(255, 255, 255); font-size: 14px; font-family: 宋体; display: block;">电话：62885618</span><span style="color: rgb(255, 255, 255); font-size: 12px; font-family: 宋体; display: block;">地址：天域花园2期商业街17商幢002室底层</span></div></div></div><label class="BMapLabel" unselectable="on" style="position: absolute; display: none; cursor: inherit; border: 1px solid rgb(140, 140, 140); padding: 1px; white-space: nowrap; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 12px; line-height: normal; font-family: arial, sans-serif; z-index: 80; -webkit-user-select: none; color: rgb(77, 77, 77); background-color: rgb(255, 255, 225);">点击可查看详情</label></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 400;"><span class="BMap_Marker" unselectable="on" style="position: absolute; padding: 0px; margin: 0px; border: 0px; width: 0px; height: 0px; left: 490px; top: 194px; z-index: -6257042;"><div style="position: absolute; margin: 0px; padding: 0px; width: 25px; height: 37px; overflow: hidden;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/su_51.png" style="display: block; border:none;margin-left:0px; margin-top:0px; "></div></span><span class="BMap_Marker" unselectable="on" style="position: absolute; padding: 0px; margin: 0px; border: 0px; width: 0px; height: 0px; left: 547px; top: 74px; z-index: 19000000; display: none;"><div style="position: absolute; margin: 0px; padding: 0px; width: 18px; height: 18px; overflow: hidden;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/spotmkrs.png" style="display: block; border:none;margin-left:-196px; margin-top:-244px; "></div></span></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 300;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 201;"></div><div style="position: absolute; height: 0px; width: 0px; left: 0px; top: 0px; z-index: 200;"></div></div><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 1;"><div style="position: absolute; overflow: visible; z-index: -100; left: 500px; top: 224px; display: block; -webkit-transform: translate3d(0px, 0px, 0px);"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource" style="position: absolute; border: none; width: 256px; height: 256px; left: -368px; top: -130px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(1)" style="position: absolute; border: none; width: 256px; height: 256px; left: 144px; top: -130px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(2)" style="position: absolute; border: none; width: 256px; height: 256px; left: -112px; top: -130px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(3)" style="position: absolute; border: none; width: 256px; height: 256px; left: -112px; top: 126px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(4)" style="position: absolute; border: none; width: 256px; height: 256px; left: -112px; top: -386px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(5)" style="position: absolute; border: none; width: 256px; height: 256px; left: 400px; top: -130px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(6)" style="position: absolute; border: none; width: 256px; height: 256px; left: -624px; top: -130px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(7)" style="position: absolute; border: none; width: 256px; height: 256px; left: -368px; top: 126px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(8)" style="position: absolute; border: none; width: 256px; height: 256px; left: 144px; top: 126px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(9)" style="position: absolute; border: none; width: 256px; height: 256px; left: -368px; top: -386px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(10)" style="position: absolute; border: none; width: 256px; height: 256px; left: 144px; top: -386px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(11)" style="position: absolute; border: none; width: 256px; height: 256px; left: -624px; top: -386px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(12)" style="position: absolute; border: none; width: 256px; height: 256px; left: 400px; top: 126px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(13)" style="position: absolute; border: none; width: 256px; height: 256px; left: 400px; top: -386px; max-width: none; opacity: 1;"><img src="./服务网点 - 顺驰（中国）不动产网络集团_files/saved_resource(14)" style="position: absolute; border: none; width: 256px; height: 256px; left: -624px; top: 126px; max-width: none; opacity: 1;"></div></div><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 2; display: none;"><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 0; display: none;"></div><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 10; display: none;"></div></div><div style="position: absolute; overflow: visible; top: 0px; left: 0px; z-index: 3;"></div></div><div style="overflow: hidden; position: absolute; left: 0px; bottom: 0px; z-index: 2100; width: 100%; height: 30px; -webkit-user-select: none; visibility: hidden; font-size: 12px; color: rgb(54, 54, 54); line-height: 20px;"><div style="width: 1000px; overflow:hidden;"><a target="_blank" title="到百度地图查看此区域" href="http://map.baidu.com/" style="outline:none;float: left;"><img style="border:none;width:77px;height:32px;vertical-align:bottom;" src="./服务网点 - 顺驰（中国）不动产网络集团_files/copyright_logo.png"></a><div style="float: left; margin-top: 10px; font-size: 12px;"><span style="margin-left: 10px;"></span><span style="margin-left: 10px;">拍摄日期:</span></div></div></div><div title="退出全景" style="position: absolute; z-index: 1201; top: 10px; right: 10px; width: 17px; height: 16px; cursor: pointer; display: none; background: url(http://api0.map.bdimg.com/images/st-close.png) no-repeat;"></div><div class=" anchorBL" style="height: 32px; position: absolute; z-index: 30; bottom: 0px; right: auto; top: auto; left: 1px;"><a title="到百度地图查看此区域" target="_blank" href="http://map.baidu.com/?sr=1" style="outline: none;"><img style="border:none;width:77px;height:32px" src="./服务网点 - 顺驰（中国）不动产网络集团_files/copyright_logo.png"></a></div><div id="zoomer" style="position:absolute;z-index:0;top:0px;left:0px;overflow:hidden;visibility:hidden;cursor:url(http://api0.map.bdimg.com/images/openhand.cur) 8 8,default"><div class="BMap_zoomer" style="top:0;left:0;"></div><div class="BMap_zoomer" style="top:0;right:0;"></div><div class="BMap_zoomer" style="bottom:0;left:0;"></div><div class="BMap_zoomer" style="bottom:0;right:0;"></div></div><div unselectable="on" class=" BMap_cpyCtrl BMap_noprint anchorBL" style="cursor: default; white-space: nowrap; color: black; font-style: normal; font-variant: normal; font-weight: normal; font-stretch: normal; font-size: 11px; line-height: 15px; font-family: arial, sans-serif; bottom: 2px; right: auto; top: auto; left: 81px; position: absolute; z-index: 10; background: none;"><span _cid="1" style="display: inline;"><span style="font-size:11px">&#169; 2014 Baidu&nbsp;- Data &#169; <a target="_blank" href="http://www.navinfo.com/" style="display:inline;">NavInfo</a> &amp; <a target="_blank" href="http://www.cennavi.com.cn/" style="display:inline;">CenNavi</a> &amp; <a target="_blank" href="http://www.365ditu.com/" style="display:inline;">道道通</a></span></span></div><div unselectable="on" class=" BMap_stdMpCtrl BMap_stdMpType0 BMap_noprint anchorTL" style="width: 62px; height: 186px; bottom: auto; right: auto; top: 10px; left: 10px; position: absolute; z-index: 1100;"><div class="BMap_stdMpPan"><div class="BMap_button BMap_panN" title="向上平移"></div><div class="BMap_button BMap_panW" title="向左平移"></div><div class="BMap_button BMap_panE" title="向右平移"></div><div class="BMap_button BMap_panS" title="向下平移"></div><div class="BMap_stdMpPanBg BMap_smcbg"></div></div><div class="BMap_stdMpZoom" style="height: 141px; width: 62px;"><div class="BMap_button BMap_stdMpZoomIn" title="放大一级"><div class="BMap_smcbg"></div></div><div class="BMap_button BMap_stdMpZoomOut" title="缩小一级" style="top: 120px;"><div class="BMap_smcbg"></div></div><div class="BMap_stdMpSlider" style="height: 102px;"><div class="BMap_stdMpSliderBgTop" style="height: 102px;"><div class="BMap_smcbg"></div></div><div class="BMap_stdMpSliderBgBot" style="top: 25px; height: 81px;"></div><div class="BMap_stdMpSliderMask" title="放置到此级别"></div><div class="BMap_stdMpSliderBar" title="拖动缩放" style="cursor: url(http://api0.map.bdimg.com/images/openhand.cur) 8 8, default; top: 25px;"><div class="BMap_smcbg"></div></div></div><div class="BMap_zlHolder"><div class="BMap_zlSt"><div class="BMap_smcbg"></div></div><div class="BMap_zlCity"><div class="BMap_smcbg"></div></div><div class="BMap_zlProv"><div class="BMap_smcbg"></div></div><div class="BMap_zlCountry"><div class="BMap_smcbg"></div></div></div></div><div class="BMap_stdMpGeolocation" style="position: initial; display: none; margin-top: 43px; margin-left: 10px;"><div class="BMap_geolocationContainer" style="position: initial; width: 24px; height: 24px; overflow: hidden; margin: 0px; box-sizing: border-box;"><div class="BMap_geolocationIconBackground" style="width: 24px; height: 24px; background-image: url(http://api0.map.bdimg.com/images/navigation-control/geolocation-control/pc/bg-20x20.png); background-size: 20px 20px; background-position: 3px 3px; background-repeat: no-repeat;"><div class="BMap_geolocationIcon" style="position: initial; width: 24px; height: 24px; cursor: pointer; background-image: url(&#39;http://api0.map.bdimg.com/images/navigation-control/geolocation-control/pc/success-10x10.png&#39;); background-size: 10px 10px; background-repeat: no-repeat; background-position: center;"></div></div></div></div></div></div>
  <!--底部内容结束-->
</div>


</body>
</html>