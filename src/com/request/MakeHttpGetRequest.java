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
import org.apache.http.client.methods.HttpGet;
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
public class MakeHttpGetRequest {

	static Logger logger = Logger.getLogger(MakeHttpGetRequest.class);
	private JSONObject json;
	private CloseableHttpClient httpClient;
	private HttpGet get;
	private CloseableHttpResponse response;
	private HttpEntity entity;
	private int statusCode;
	
	public MakeHttpGetRequest()
	{
		if(httpClient==null)
			httpClient = HttpClients.createDefault();
		if(get==null)
			get = new HttpGet();
		else
			get.reset();
	}
	
	public JSONObject process(URI uri)
	{
		get.setURI(uri);
		RequestUtil.setHeaders(get);
		
	    try {
	    	response = httpClient.execute(get);
			entity = response.getEntity();
			statusCode = response.getStatusLine().getStatusCode();
			
			if(statusCode==HttpStatus.SC_OK || statusCode==HttpStatus.SC_NOT_FOUND)
			{
				json = new JSONObject(EntityUtils.toString(entity));
			}
			else
			{
				json = new JSONObject();
				json.put("errorCode",0);
				json.put("message", "Error Occurred,Please see Logger file");
				logger.info("\n"+EntityUtils.toString(entity));
			}
		} catch (IOException | ParseException | JSONException  e) {
			logger.info("Error occurred while making the GET request "+e.getMessage());
		}
	    return json;
	}
}
