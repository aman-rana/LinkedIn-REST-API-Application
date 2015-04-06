/**
 * 
 */
package com.format;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.general.GeneralUtil;

/**
 * This class is used to display the json data in the html table
 * @author Amandeep Rana
 * 
 *
 */
public class FormatJSONUtil {
	
	public static Logger logger = Logger.getLogger("FormatJSONUtil.class");
	
	public static String getHTMLForCompanySearch(String[] values,JSONObject json) throws JSONException
	{
		StringBuilder html = new StringBuilder("");
		JSONObject data = null;
		JSONArray dataValues = null;
		JSONObject dataValuesdata=null;
		int i,j;
		for(i=0;i<values.length;i++)
		{
			if(values[i].equals("name"))
			{
				html.append("<tr><td width='10%'>Name</td><td width='90%'>");
				if(json.has("name"))
					html.append(json.getString("name"));
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("universal-name"))
			{
				html.append("<tr><td width='10%'>Universal Name</td><td width='90%'>");
				if(json.has("universalName"))
					html.append(json.getString("universalName"));
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("email-domains"))
			{
				html.append("<tr><td width='10%'>Email Domains</td><td width='90%'>");
				if(json.has("emailDomains"))
				{
					data = json.getJSONObject("emailDomains");
					dataValues = data.getJSONArray("values");
					
					for(j=0;j<data.getInt("_total");j++)
					{
						html.append(dataValues.getString(j)+",");	
					}
					
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("description"))
			{
				html.append("<tr><td width='10%'>Description</td><td width='90%'>");
				if(json.has("description"))
				{
					html.append(json.getString("description"));
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("company-type"))
			{
				html.append("<tr><td width='10%'>Company Type</td><td width='90%'>");
				if(json.has("companyType"))
				{
					data = json.getJSONObject("companyType");
					html.append(data.getString("name"));
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("ticker"))
			{
				html.append("<tr><td width='10%' >Ticker</td><td width='90%'>");
				if(json.has("ticker"))
				{
					html.append(json.getString("ticker"));
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("website-url"))
			{
				html.append("<tr><td width='10%'>Website Url</td><td width='90%'>");
				if(json.has("websiteUrl"))
				{
					if(json.getString("websiteUrl").indexOf("http")==0)
					{
						html.append("<a href='"+json.getString("websiteUrl")+"' target='_blank'>"+json.getString("websiteUrl")+"</a>");
					}else{
						html.append("<a href='http://"+json.getString("websiteUrl")+"' target='_blank'>"+json.getString("websiteUrl")+"</a>");
					}
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("industries"))
			{
				html.append("<tr><td width='10%'>Industry</td><td width='90%'>");
				if(json.has("industries"))
				{
					data = json.getJSONObject("industries");
					dataValues = data.getJSONArray("values");
					for(j=0;j<dataValues.length();j++)
					{
						dataValuesdata = dataValues.getJSONObject(j);
						html.append(dataValuesdata.getString("name")+",");
					}
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("status"))
			{
				html.append("<tr><td width='10%'>Operating Status</td><td width='90%'>");
				if(json.has("status"))
				{
					data = json.getJSONObject("status");
					html.append(data.getString("name"));
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("logo-url"))
			{
				html.append("<tr><td width='10%'>Logo</td><td width='90%'>");
				if(json.has("logoUrl"))
				{
					html.append("<img src='"+json.getString("logoUrl")+"' />");
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("twitter-id"))
			{
				html.append("<tr><td width='10%'>Twitter Id</td><td width='90%'>");
				if(json.has("twitterId") && !"".equals(json.getString("twitterId")))
				{
					html.append("<a target='_blank' href='https://www.twitter.com/"+json.getString("twitterId")+"'>@"+json.getString("twitterId")+"</a>");
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("employee-count-range"))
			{
				html.append("<tr><td width='10%'>Employee Count</td><td width='90%'>");
				if(json.has("employeeCountRange"))
				{
					data = json.getJSONObject("employeeCountRange");
					html.append(data.getString("name"));
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("locations"))
			{
				html.append("<tr><td width='10%'>Locations</td><td width='90%'>");
				if(json.has("locations"))
				{
					data = json.getJSONObject("locations");
					dataValues = data.getJSONArray("values");
					for(j=0;j<dataValues.length();j++)
					{
						dataValuesdata = dataValues.getJSONObject(j);
						if(dataValuesdata.getBoolean("isHeadquarters"))
						{
							html.append("<table>");
							if(dataValuesdata.has("address"))
							{
								html.append("<tr><td>"+dataValuesdata.getJSONObject("address").getString("street1")+"<br>"+dataValuesdata.getJSONObject("address").getString("city")+"<br>"+dataValuesdata.getJSONObject("address").getInt("postalCode")+"</td></tr>");
							}
							if(dataValuesdata.has("contactInfo"))
							{
								html.append("<tr><td>"+dataValuesdata.getJSONObject("contactInfo").getString("fax")+"<br>"+dataValuesdata.getJSONObject("contactInfo").getString("phone1")+"</td></tr>");
							}
							
							html.append("</table>");
						}
					}
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("founded-year"))
			{
				html.append("<tr><td width='10%'>Foundation Year</td><td width='90%'>");
				if(json.has("foundedYear"))
				{
					html.append(json.getInt("foundedYear"));
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
			else if(values[i].equals("num-followers"))
			{
				html.append("<tr><td width='10%'>No. Of Followers</td><td width='90%'>");
				if(json.has("numFollowers"))
				{
					html.append(json.getLong("numFollowers"));
				}
				else
					html.append("-NA-");
				html.append("</td></tr>");
			}
		}
		return html.toString();
	}
	
	public static String getHTMLForCompanyEmailSearch(JSONObject json)
	{
		StringBuilder html = new StringBuilder("");
		
		try{
			JSONArray jsonArray = json.getJSONArray("values");
			JSONObject jsonArrayJson = null;
			for(int i=0;i<jsonArray.length();i++)
			{
				jsonArrayJson = jsonArray.getJSONObject(i);
			
				html.append("<tr><td width='10%'>ID</td><td width='90%'>");
				if(jsonArrayJson.has("id"))
					html.append(jsonArrayJson.getLong("id"));
				else
					html.append("-NA-");

				html.append("</td></tr>");
				
				
				html.append("<tr><td width='10%'>Name</td><td width='90%'>");
				if(jsonArrayJson.has("name"))
					html.append(jsonArrayJson.getString("name"));
				else
					html.append("-NA-");
				
				html.append("</td></tr>");
			}
		}
		catch(JSONException e)
		{
			logger.error("Exception occurred while parsing json object : ",e);
		}
		return html.toString();
	}

	
	public static String getHTMLForCompanyEmailSearch(String[] values,JSONObject json)
	{
		StringBuilder html = new StringBuilder("");
		try{
			JSONArray jsonArray = json.getJSONArray("values");
			JSONObject jsonArrayJson = null;
			for(int i=0;i<jsonArray.length();i++)
			{	
				jsonArrayJson = jsonArray.getJSONObject(i);
				html.append("<tr><td colspan='2'>---------------------------------------------------</td></tr>");
				html.append(getHTMLForCompanySearch(values,jsonArrayJson));
			}
			
		}catch(JSONException e)
		{
			logger.error("Exception occurred while parsing json object : ",e);
		}
		return html.toString();
	}
	
	
	public static String getHTMLForCompanyUpdates(JSONObject json)
	{
		StringBuilder html = new StringBuilder("");
		try{
			if(json.has("values"))
			{
				JSONArray jArrar =json.getJSONArray("values");
				JSONObject jsonUpdate,jsonUpdateContent;
				for(int i=0;i<jArrar.length();i++)
				{
					html.append("<tr>");
					jsonUpdate = jArrar.getJSONObject(i);
					if(jsonUpdate.has("updateContent"))
					{
						jsonUpdateContent = jsonUpdate.getJSONObject("updateContent");
						if(jsonUpdateContent.has("company"))
						{
							html.append("<td width='15%' style='vertical-align:top;'><strong><a target='_blank' style='text-decoration:none; font-family:Arial; color:#0077B5; font-size:13px;' href='http://linkedin.com/company/"+jsonUpdateContent.getJSONObject("company").getInt("id")+"'>");
							html.append(jsonUpdateContent.getJSONObject("company").getString("name"));
							html.append("</a></strong></td>");
						}
						if(jsonUpdateContent.has("companyStatusUpdate"))
						{
							html.append("<td width='85%'>");
							html.append(getCompanyStatusUpdate(jsonUpdateContent.getJSONObject("companyStatusUpdate")));
							html.append("</td>");
						}
						else if(jsonUpdateContent.has("companyJobUpdate"))
						{
							html.append("<td width='85%'>");
							html.append(getCompanyJobUpdate(jsonUpdateContent.getJSONObject("companyJobUpdate")));
							html.append("</td>");
						}
						else if(jsonUpdateContent.has("companyProductUpdate"))
						{
							html.append("<td width='85%'>");
							html.append(getCompanyProductUpdate(jsonUpdateContent.getJSONObject("companyProductUpdate")));
							html.append("</td>");
						}
						
						if(jsonUpdate.has("timestamp"))
						{
							html.append("<tr><td>&nbsp;</td><td>").append(GeneralUtil.convertDateFromTimeStamp(jsonUpdate.getLong("timestamp"),"EEE, d MMM yyyy HH:mm:ss")).append("</td></tr>");
						}
					}
					
					html.append("</tr>");
				}
			}
			
		}catch(JSONException e)
		{
			logger.error("Exception occurred while parsing json object : ",e);
		}
		
		return html.toString();
		
	}

	private static String getCompanyProductUpdate(JSONObject jsonObject) {
		StringBuilder html= new StringBuilder("<table>");
		html.append("<tr><td><span style='font-style:oblique;'>Product Update</span></td></tr>");
		JSONObject product;
		try
		{
			if(jsonObject.has("product"))
			{
				product = jsonObject.getJSONObject("product");
				if(product.has("name"))
				{
					html.append("<tr><td><span style='font-family:Arial; color:#000; font-weight:bold; text-decoration:none;'>").append(product.getString("name")).append("</span></td></tr>");
				}
			}
			html.append("</table>");
			return html.toString();
		}
		catch(JSONException e)
		{
			logger.error("Exception occurred while parsing json object : ",e);
		}
		return "";
	}

	private static String getCompanyJobUpdate(JSONObject jsonObject) {
		StringBuilder html= new StringBuilder("<table>");
		html.append("<tr><td><span style='font-style:oblique;'>Job Update</span></td></tr>");
		JSONObject jobContent;
		String title="-not specified-",applyUrl="";
		try
		{
			if(jsonObject.has("job"))
			{
				jobContent = jsonObject.getJSONObject("job");
				if(jobContent.has("position"));
				{
					if(jobContent.getJSONObject("position").has("title"))
					{
						title=jobContent.getJSONObject("position").getString("title");
					}
					if(jobContent.has("siteJobRequest"))
					{
						if(jobContent.getJSONObject("siteJobRequest").has("url"))
						{
							applyUrl=jobContent.getJSONObject("siteJobRequest").getString("url");
						}
					}
					html.append("<tr><td><a style='font-family:Arial; color:#000; font-weight:bold; text-decoration:none;' target='_blank' href='"+applyUrl+"'>").append(title).append("</a></td></tr>");
				}
				if(jobContent.has("locationDescription"))
				{
					html.append("<tr><td>&nbsp;&nbsp;(location) -"+jobContent.getString("locationDescription")+"</tr></td>");
				}
				if(jobContent.has("description"))
				{
					html.append("<tr><td>"+jobContent.getString("description")+"</td></tr>");
				}
			}
			html.append("</table>");
			return html.toString();
		}catch(JSONException e)
		{
			logger.error("Exception occurred while parsing json object : ",e);
		}
		return "";
	}

	private static String getCompanyStatusUpdate(JSONObject jsonObject) {
		// TODO Auto-generated method stub
		StringBuilder html= new StringBuilder("<table>");
		html.append("<tr><td colspan='2'><span style='font-style:oblique;'>Status Update</span></td></tr>");
		JSONObject share;
		JSONObject shareContent;
		try
		{
			if(jsonObject.has("share"))
			{
				share = jsonObject.getJSONObject("share");
				if(share.has("comment"));
				{
					html.append("<tr><td colspan='2'>").append(share.getString("comment")).append("</td></tr>");
				}
				if(share.has("content"))
				{
					shareContent = share.getJSONObject("content");
					html.append("<tr><td width='8%'>");

					if(shareContent.has("shortenedUrl"))
					{
						html.append("<a target='_blank' href='"+shareContent.getString("shortenedUrl")+"'>");
					}else if(shareContent.has("submittedUrl"))
					{
						html.append("<a target='_blank' href='"+shareContent.getString("submittedUrl")+"'>");
					}else
					{
						html.append("<a>");
					}
					if(shareContent.has("thumbnailUrl"))
					{
						html.append("<img src='"+shareContent.getString("thumbnailUrl")+"'>");
					}
					html.append("</a></td>");
					html.append("<td width='92%' style='vertical-align:top;'>");
					if(shareContent.has("title"))
					{
						if(shareContent.has("submittedUrl"))
						{
							html.append("<a style='font-family:Arial; color:#000; font-weight:bold; text-decoration:none;' href='"+shareContent.getString("submittedUrl")+"'>"+shareContent.getString("title")+"</a>");
						}
						else
						{
							html.append("<span style='font-family:Arial; color:#000; font-weight:bold;'>"+shareContent.getString("title")+"</span>");
						}
					}
					if(shareContent.has("description"))
					{
						html.append("<br><span>"+shareContent.getString("description")+"</span>");
					}
					html.append("</td></tr>");
				}
			}
			html.append("</table>");
			return html.toString();
		}catch(JSONException e)
		{
			logger.error("Exception occurred while parsing json object : ",e);
		}
		return "";
	}
	
	
	public static String getHTMLForHistoricFollowers(JSONObject json) throws JSONException
	{
		StringBuilder html = new StringBuilder("");
		JSONArray array =null;
		JSONObject jsonDetails=null;
		if(json.length()>0)
		{
			if(json.has("values"))
			{
				array = json.getJSONArray("values");
				for(int i=0;i<array.length();i++)
				{
					jsonDetails = array.getJSONObject(i);
					html.append("<tr><td width='15%'>");
					if(jsonDetails.has("time"))
					{
						html.append(GeneralUtil.convertDateFromTimeStamp(jsonDetails.getLong("time"),"EEE, MMM d, ''yy"));
					}
					html.append("</td><td width='28%'>");
					if(jsonDetails.has("organicFollowerCount"))
					{
						html.append(jsonDetails.getLong("organicFollowerCount"));
					}
					html.append("</td><td width='28%'>");
					if(jsonDetails.has("totalFollowerCount"))
					{
						html.append(jsonDetails.getLong("totalFollowerCount"));
					}
					html.append("</td><td width='28%'>");
					if(jsonDetails.has("paidFollowerCount"))
					{
						html.append(jsonDetails.getLong("paidFollowerCount"));
					}
					html.append("</td></tr>");
				}
			}
		}
		return html.toString();
	}
	
	
	public static String getHTMLForHistoricStatus(JSONObject json) throws JSONException
	{
		StringBuilder html = new StringBuilder("");
		StringBuilder htmlHeader = new StringBuilder();
		JSONArray array =null;
		JSONObject jsonDetails=null;
		if(json.length()>0)
		{
			if(json.has("values"))
			{
				array = json.getJSONArray("values");
				for(int i=0;i<array.length();i++)
				{
					jsonDetails = array.getJSONObject(i);
					htmlHeader.append("<tr>");
					html.append("<tr>");
					if(jsonDetails.has("time"))
					{
						if(i==0)
							htmlHeader.append("<td>Time</td>");
						html.append("<td>");
						html.append(GeneralUtil.convertDateFromTimeStamp(jsonDetails.getLong("time"),"EEE, MMM d, ''yy"));
						html.append("</td>");
					}
					
					if(jsonDetails.has("likeCount"))
					{
						if(i==0)
							htmlHeader.append("<td>Like Count</td>");
						html.append("<td>");
						html.append(jsonDetails.getLong("likeCount"));
						html.append("</td>");
					}
					
					if(jsonDetails.has("impressionCount"))
					{
						if(i==0)
							htmlHeader.append("<td>Impression Count</td>");
						html.append("<td>");
						html.append(jsonDetails.getLong("impressionCount"));
						html.append("</td>");
					}
					
					if(jsonDetails.has("clickCount"))
					{
						if(i==0)
							htmlHeader.append("<td>Click Count</td>");
						html.append("<td>");
						html.append(jsonDetails.getLong("clickCount"));
						html.append("</td>");
					}
					
					if(jsonDetails.has("commentCount"))
					{
						if(i==0)
							htmlHeader.append("<td>Comment Count</td>");
						html.append("<td>");
						html.append(jsonDetails.getLong("commentCount"));
						html.append("</td>");
					}
					
					if(jsonDetails.has("shareCount"))
					{
						if(i==0)
							htmlHeader.append("<td>Share Count</td>");
						html.append("<td>");
						html.append(jsonDetails.getLong("shareCount"));
						html.append("</td>");
					}
					
					if(jsonDetails.has("engagement"))
					{
						if(i==0)
							htmlHeader.append("<td>Engagement</td>");
						html.append("<td>");
						html.append(jsonDetails.getDouble("engagement"));
						html.append("</td>");
					}
					
					if(jsonDetails.has("uniqueCount"))
					{
						if(i==0)
							htmlHeader.append("<td>Unique Count</td>");
						html.append("<td>");
						html.append(jsonDetails.getLong("uniqueCount"));
						html.append("</td>");
					}
					htmlHeader.append("</tr>");
					html.append("</tr>");
				}
			}
		}
		return (htmlHeader.toString()+html.toString());
	}
	
	public static String getHTMLForCompanyStatistics(JSONObject json) throws JSONException
	{
		StringBuilder html = new StringBuilder("");
		JSONArray array =null;
		JSONObject jsonDetails=null,jsonOb1=null,jsonOb2=null,dateJson=null;
		if(json.length()>0)
		{
			if(json.has("statusUpdateStatistics"))
			{
				html.append("<tr><td>");
				html.append("<table style='border-style:dotted; border-width:1px;' width='100%'>"+
						"<tr><td colspan='7' style='text-align:left;'><b>"+
						"Status Update Statistics</b></td></tr>");
				html.append("<tr><td>Date</td><td>Shares</td>");
				html.append("<td>Comments</td><td>Engagement</td>");
				html.append("<td>Clicks</td><td>Impressions</td>");
				html.append("<td>Likes</td></tr>");
				jsonOb1 = json.getJSONObject("statusUpdateStatistics");
				if(jsonOb1.has("viewsByMonth"))
				{
					jsonOb2 = jsonOb1.getJSONObject("viewsByMonth");
					if(jsonOb2.has("values"))
					{
						array = jsonOb2.getJSONArray("values");
						for(int i=0;i<array.length();i++)
						{
							jsonDetails = array.getJSONObject(i);
							dateJson = jsonDetails.getJSONObject("date");
							
							html.append("<tr><td>");
							html.append(dateJson.getInt("month")+","+
									dateJson.getInt("year"));
							html.append("</td><td>");
							html.append(jsonDetails.getLong("shares"));
							html.append("</td><td>");
							html.append(jsonDetails.getLong("comments"));
							html.append("</td><td>");
							html.append(jsonDetails.getDouble("engagement"));
							html.append("</td><td>");
							html.append(jsonDetails.getLong("clicks"));
							html.append("</td><td>");
							html.append(jsonDetails.getLong("impressions"));
							html.append("</td><td>");
							html.append(jsonDetails.getLong("likes"));
							html.append("</td></tr>");
						}
					}
				}
				
				html.append("</table></td></tr>");
			}
			
			if(json.has("followStatistics"))
			{
				html.append("<tr><td>");
				html.append("<table style='border-style:dotted; border-width:1px;' width='100%'>"+
						"<tr><td colspan='3'style='text-align:left;'><b>"+
						"Follow Statistics</b></td></tr>");
				html.append("<tr><td>Date</td><td>New Count</td>");
				html.append("<td>Total Count</td>");
				html.append("</tr>");
				jsonOb1 = json.getJSONObject("followStatistics");
				if(jsonOb1.has("countsByMonth"))
				{
					jsonOb2 = jsonOb1.getJSONObject("countsByMonth");
					if(jsonOb2.has("values"))
					{
						array = jsonOb2.getJSONArray("values");
						for(int i=0;i<array.length();i++)
						{
							jsonDetails = array.getJSONObject(i);
							dateJson = jsonDetails.getJSONObject("date");
							
							html.append("<tr><td>");
							html.append(dateJson.getInt("month")+","+
									dateJson.getInt("year"));
							html.append("</td><td>");
							html.append(jsonDetails.getLong("newCount"));
							html.append("</td><td>");
							html.append(jsonDetails.getLong("totalCount"));
							html.append("</td></tr>");
						}
					}
				}
				
				html.append("</table></td></tr>");
			}
		}
		return html.toString();
	}
}
