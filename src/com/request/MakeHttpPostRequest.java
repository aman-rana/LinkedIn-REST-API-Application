/**
 * 
 */
package com.request;

import java.io.IOException;
import java.net.URI;

import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.ParseException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * @author Amandeep Rana
 *
 */
public class MakeHttpPostRequest {

	static Logger logger = Logger.getLogger(MakeHttpGetRequest.class);
	private JSONObject responseJson;
	private CloseableHttpClient httpClient;
	private HttpPost post;
	private CloseableHttpResponse response;
	private HttpEntity entity;
	private int statusCode;
	private StringEntity stringEntity;
	
	public MakeHttpPostRequest()
	{
		if(httpClient==null)
			httpClient = HttpClients.createDefault();
		if(post==null)
			post = new HttpPost();
		else
			post.reset();
	}
	
	public JSONObject process(URI uri,JSONObject json)
	{
		post.setURI(uri);
		RequestUtil.setHeaders(post);
		
		if(json!=null && json.length()>0)
		{
			stringEntity = new StringEntity(json.toString(),ContentType.APPLICATION_JSON);
			post.setEntity(stringEntity);
		}
	    try {
	    	
	    	response = httpClient.execute(post);
			entity = response.getEntity();
			statusCode = response.getStatusLine().getStatusCode();
			System.out.println(statusCode);
			if(statusCode==HttpStatus.SC_CREATED)
			{
				responseJson = new JSONObject(EntityUtils.toString(entity));
			}
			else
			{
				responseJson = new JSONObject();
				responseJson.put("errorCode",0);
				responseJson.put("message", "Error Occurred,Please see Logger file");
				logger.info("\n"+EntityUtils.toString(entity));
			}
		} catch (IOException | ParseException | JSONException  e) {
			logger.info("Error occurred while making the POST request "+e.getMessage());
		}
	    
	    return responseJson;
	}
	
}
