/**
 * 
 */
package com.format;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.apache.log4j.Logger;

import com.Constants;

/**
 * @author Amandeep Rana
 *
 */
public class HtmlUtil {

	public static Logger logger = Logger.getLogger("HtmlUtil.class");
	
	public static String getComboForGeoLoctions()
	{
		Properties geos = new Properties();
		HashMap<String,String> geosLocationsMap;
		String keyName;
		StringBuilder combo = new StringBuilder();
		try {
			FileInputStream fis = 
					new FileInputStream(Constants.CLASSFILE_PATH+"/properties/geographicLocations.properties");
			geos.load(fis);
			Enumeration<Object> key = geos.keys();
			geosLocationsMap = new HashMap<String, String>();
			while(key.hasMoreElements())
			{
				keyName =(String)key.nextElement();
				geosLocationsMap.put(keyName,geos.getProperty(keyName));
			}
			
			
			geosLocationsMap = (HashMap<String, String>) sortByValue(geosLocationsMap);
			
			combo.append("<select id='geos' name='geos'>");
			
			
			Set<String> set = geosLocationsMap.keySet();
			
			for(String me : set)
			{
				combo.append("<option value='"+me+"'>"+geosLocationsMap.get(me)+"</option>");
			}
			
			combo.append("</select>");
			
			
		} catch (IOException e) {
			logger.info("Error occurred while making geo combo "+e.getMessage());
			combo = new StringBuilder();
			combo.append("<select id='geos' name='geos'>");
			combo.append("</select>");
			return combo.toString();
		}
		
		return combo.toString();
		
	}
	
	public static <K, V extends Comparable<? super V>> Map<K, V> sortByValue(Map<K, V> map) {
		List<Map.Entry<K, V>> list = new LinkedList<>(map.entrySet());
		Collections.sort(list, new Comparator<Map.Entry<K, V>>() {
			@Override
			public int compare(Map.Entry<K, V> o1, Map.Entry<K, V> o2) {
				return (o1.getValue()).compareTo(o2.getValue());
			}
		});

		Map<K, V> result = new LinkedHashMap<>();
		for (Map.Entry<K, V> entry : list) {
			result.put(entry.getKey(), entry.getValue());
		}
		return result;
	}
	
	public static String getComboForJobFunctions()
	{
		Properties geos = new Properties();
		HashMap<String,String> geosLocationsMap;
		String keyName;
		StringBuilder combo = new StringBuilder();
		try {
			FileInputStream fis = 
					new FileInputStream(Constants.CLASSFILE_PATH+"/properties/jobFunctions.properties");
			geos.load(fis);
			Enumeration<Object> key = geos.keys();
			geosLocationsMap = new HashMap<String, String>();
			while(key.hasMoreElements())
			{
				keyName =(String)key.nextElement();
				geosLocationsMap.put(keyName,geos.getProperty(keyName));
			}
			
			
			geosLocationsMap = (HashMap<String, String>) sortByValue(geosLocationsMap);
			
			combo.append("<select id='jobFunc' name='jobFunc'>");
			
			
			Set<String> set = geosLocationsMap.keySet();
			
			for(String me : set)
			{
				combo.append("<option value='"+me+"'>"+geosLocationsMap.get(me)+"</option>");
			}
			
			combo.append("</select>");
			
			
		} catch (IOException e) {
			logger.info("Error occurred while making geo combo "+e.getMessage());
			combo = new StringBuilder();
			combo.append("<select id='geos' name='geos'>");
			combo.append("</select>");
			return combo.toString();
		}
		
		return combo.toString();
		
	}
	
	public static String getComboForIndustries(){
		Properties indus = new Properties();
		HashMap<String,String> industriesMap;
		String keyName;
		StringBuilder combo = new StringBuilder();
		try {
			FileInputStream fis = 
					new FileInputStream(Constants.CLASSFILE_PATH+"/properties/industryCodeDescriptionMapping.properties");
			indus.load(fis);
			Enumeration<Object> key = indus.keys();
			industriesMap = new HashMap<String, String>();
			while(key.hasMoreElements())
			{
				keyName =(String)key.nextElement();
				industriesMap.put(keyName,indus.getProperty(keyName));
			}
			
			
			industriesMap = (HashMap<String, String>) sortByValue(industriesMap);
			
			combo.append("<select id='industries' name='industries'>");
			
			
			Set<String> set = industriesMap.keySet();
			
			for(String me : set)
			{
				combo.append("<option value='"+me+"'>"+industriesMap.get(me)+"</option>");
			}
			
			combo.append("</select>");
			
			
		} catch (IOException e) {
			logger.info("Error occurred while making geo combo "+e.getMessage());
			combo = new StringBuilder();
			combo.append("<select id='industries' name='industries'>");
			combo.append("</select>");
			return combo.toString();
		}
		
		return combo.toString();
	}
	
	public static String getComboForSeniority()
	{
		Properties seniority = new Properties();
		HashMap<String,String> seniorityMap;
		String keyName;
		StringBuilder combo = new StringBuilder();
		try {
			FileInputStream fis = 
					new FileInputStream(Constants.CLASSFILE_PATH+"/properties/seniority.properties");
			seniority.load(fis);
			Enumeration<Object> key = seniority.keys();
			seniorityMap = new HashMap<String, String>();
			while(key.hasMoreElements())
			{
				keyName =(String)key.nextElement();
				seniorityMap.put(keyName,seniority.getProperty(keyName));
			}
			
			
			seniorityMap = (HashMap<String, String>) sortByValue(seniorityMap);
			
			combo.append("<select id='seniorities' name='seniorities'>");
			
			
			Set<String> set = seniorityMap.keySet();
			
			for(String me : set)
			{
				combo.append("<option value='"+me+"'>"+seniorityMap.get(me)+"</option>");
			}
			
			combo.append("</select>");
			
			
		} catch (IOException e) {
			logger.info("Error occurred while making geo combo "+e.getMessage());
			combo = new StringBuilder();
			combo.append("<select id='seniorities' name='seniorities'>");
			combo.append("</select>");
			return combo.toString();
		}
		
		return combo.toString();
	}
	

}
