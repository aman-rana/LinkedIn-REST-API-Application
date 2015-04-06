/**
 * 
 */
package com.mgr;

import com.request.BuildURI;
import com.request.MakeHttpGetRequest;
import com.request.MakeHttpPostRequest;

/**
 * Request Manager Class Follows Singleton Pattern
 * @author Amandeep Rana
 *
 */
public class RequestMgr {

	static RequestMgr _instance = null;
	private MakeHttpGetRequest httpGetRequest;
	private MakeHttpPostRequest httpPostRequest;
	private BuildURI buildURI = null;
	
	private RequestMgr()
	{}
	
	public static RequestMgr getInstance()
	{
		if(_instance==null)
			_instance = new RequestMgr();
		
		return _instance;
	}
	
	public MakeHttpGetRequest getMakeHttpGetRequest()
	{
		if(this.httpGetRequest==null)
			httpGetRequest = new MakeHttpGetRequest();
		
		return this.httpGetRequest;
	}
	
	public MakeHttpPostRequest getMakeHttpPostRequest()
	{
		if(this.httpPostRequest==null)
			httpPostRequest = new MakeHttpPostRequest();
		
		return this.httpPostRequest;
	}
	
	public BuildURI getBuildURI()
	{
		if(this.buildURI==null)
			buildURI = new BuildURI();
		
		return this.buildURI;
	}
}
