/**
 * 
 */
package com.general;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import org.apache.log4j.Logger;

/**
 * @author Amandeep Rana
 *
 */
public class GeneralUtil {
	public static Logger logger = Logger.getLogger(GeneralUtil.class);
	
	public static String convertDateFromTimeStamp(long timeStamp, String dateFormat) {
		Date date = new Date(timeStamp);
		DateFormat format = new SimpleDateFormat(dateFormat);
		return format.format(date);
	}
	
	public static String convertDateToTimeStamp(String date,String dateFormat)
	{
		DateFormat format = new SimpleDateFormat(dateFormat);
		Date result;
		try {
			result = format.parse(date);
		} catch (ParseException e) {
			logger.info("Error occurred while parsing Date "+e.getMessage());
			return "-1";
		}
		return Long.toString(result.getTime());
	}
	
	public static String getTimeStampInGMT(String date,String dateFormat)
	{
		DateFormat format = new SimpleDateFormat(dateFormat);
		format.setTimeZone(TimeZone.getTimeZone("GMT0"));
		Date result;
		try {
			result = format.parse(date);
		} catch (ParseException e) {
			logger.info("Error occurred while parsing Date "+e.getMessage());
			return "-1";
		}
		return Long.toString(result.getTime());
	}
	
	
}
