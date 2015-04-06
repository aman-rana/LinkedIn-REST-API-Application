/**
 * 
 */
package com.request;

import org.apache.http.HttpRequest;
import org.apache.log4j.Logger;

/**
 * @author Amandeep Rana
 *
 */
public class RequestUtil {
	
	static Logger logger = Logger.getLogger(RequestUtil.class);
	
	public static void setHeaders(HttpRequest request) {
		request.setHeader("x-li-format", "json");
	}

}
