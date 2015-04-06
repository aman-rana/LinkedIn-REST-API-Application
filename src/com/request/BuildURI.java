/**
 * 
 */
package com.request;

import java.net.URI;
import java.net.URISyntaxException;

import org.apache.http.client.utils.URIBuilder;
import org.apache.log4j.Logger;

import com.Constants;

/**
 * @author Amandeep Rana
 *
 */
public class BuildURI {

	static Logger logger = Logger.getLogger(BuildURI.class);
	private URI uri=null;
	
	public URI getURI(String path)
	{
		try {
			uri = new URIBuilder()
					.setScheme(Constants.PROTOCOL_SCHEME)
					.setHost(Constants.API_HOST)
					.setPath(path)
					.setParameter(Constants.OATH_STRING, Constants.ACCESS_TOKEN)
					.build();
			
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			logger.error("Exception while building uri : ",e);
		}
		
		return uri;
	}
	
	public URI getURI(String path,String parameterName,String parameterValue)
	{
		try {
			uri = new URIBuilder()
					.setScheme(Constants.PROTOCOL_SCHEME)
					.setHost(Constants.API_HOST)
					.setPath(path)
					.setParameter(parameterName, parameterValue)
					.setParameter(Constants.OATH_STRING, Constants.ACCESS_TOKEN)
					.build();
			
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			logger.error("Exception while building uri : ",e);
		}
		
		return uri;
	}
	
	
	public URI getURI(String path,String[] parameterNames,String[] parameterValues)
	{
		URIBuilder uriBuilder;
		try {
			uriBuilder = new URIBuilder()
					.setScheme(Constants.PROTOCOL_SCHEME)
					.setHost(Constants.API_HOST)
					.setPath(path);
			if(parameterNames.length>0)
			{
				for(int i=0;i<parameterNames.length;i++)
				{
					uriBuilder.addParameter(parameterNames[i], parameterValues[i]);
				}
			}
			uriBuilder.setParameter(Constants.OATH_STRING, Constants.ACCESS_TOKEN);
			uri = uriBuilder.build();
			
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			logger.error("Exception while building uri : ",e);
		}
		return uri;
	}
	
	
}
