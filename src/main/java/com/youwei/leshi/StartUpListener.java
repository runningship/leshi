package com.youwei.leshi;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.jsp.JspFactory;

import org.bc.sdak.SessionFactoryBuilder;
import org.hibernate.cfg.AvailableSettings;

import com.youwei.SQL2008Dialect;
import com.youwei.leshi.cache.ConfigCache;
import com.youwei.web.ModuleManager;
import com.youwei.web.PublicFieldSupportingELResolver;

public class StartUpListener implements ServletContextListener{

	public void contextDestroyed(ServletContextEvent arg0) {
	}

	public void contextInitialized(ServletContextEvent event) {
		initDataSource();
		initModule();
		JspFactory.getDefaultFactory()
        .getJspApplicationContext(event.getServletContext())
        .addELResolver(new PublicFieldSupportingELResolver());
	}

	private void initModule() {
		ModuleManager.add("com.youwei.leshi");
	}

	public static synchronized void initDataSource(){
		Map<String,String> settings = new HashMap<String , String>();
//		settings.put(AvailableSettings.URL, "jdbc:mysql://localhost:3306/ihouse?characterEncoding=utf-8");
//		settings.put(AvailableSettings.USER, "root");
//		settings.put(AvailableSettings.PASS, "");
		settings.put(AvailableSettings.SHOW_SQL, "true");
		settings.put(AvailableSettings.DRIVER, "com.microsoft.sqlserver.jdbc.SQLServerDriver");
//		settings.put(AvailableSettings.DIALECT, "org.hibernate.dialect.SQLServer2008Dialect");
		settings.put(AvailableSettings.DIALECT, SQL2008Dialect.class.getName());
		
//		settings.put(AvailableSettings.DRIVER, "com.mysql.jdbc.Driver");
//		settings.put(AvailableSettings.DIALECT, "org.hibernate.dialect.MySQL5Dialect");
		
		settings.put(AvailableSettings.CURRENT_SESSION_CONTEXT_CLASS, "thread");
//		settings.put(AvailableSettings.HBM2DDL_AUTO, "update");
		settings.put(AvailableSettings.POOL_SIZE, "1");
		settings.put(AvailableSettings.CACHE_REGION_FACTORY, "org.hibernate.cache.ehcache.EhCacheRegionFactory");
		settings.put(AvailableSettings.USE_SECOND_LEVEL_CACHE, "true");
		
//		settings.put(AvailableSettings.PROXOOL_XML, "proxool.xml");//相对目录为classes
		settings.put(AvailableSettings.PROXOOL_XML, ConfigCache.get("proxool_xml" ,"proxool.xml"));//相对目录为classes
		settings.put(AvailableSettings.PROXOOL_EXISTING_POOL, "false");
		settings.put(AvailableSettings.PROXOOL_POOL_ALIAS, "mySqlProxool");
		
//		settings.put("annotated.packages", HouseRent.class.getPackage().getName());
		settings.put("annotated.packages", "com.youwei.leshi");
		SessionFactoryBuilder.applySettings(settings);
//		SimpDaoTool.getGlobalCommonDaoService().getUnique(User.class, 0);
	}
}
