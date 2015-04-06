/**
 * 
 */
package com;

/**
 * This class contains the application specific configuration required to run 
 * this project.
 * For knowing how to create apps on <b>LinkedIn</b> visit : <link>
 * https://developer.linkedin.com/ </link>
 * 
 * @author Amandeep Rana
 *
 */
public class Constants {

	/*
	 * Update the  below constants as per your linkedIn App Settings
	 */
	public static final String API_KEY = "YOUR_APPS_API_KEY";															//your apps api key
	public static final String SECRET_KEY = "YOUR_APPS_SECRET_KEY";														//your apps secret key
	public static final String STATE = "aMaNdEEpRaNa";																	//state code to avoid CSRF attack, can be any string
	public static final String RETURN_URI = "http://localhost:8081/LinkedIn/authenticate/getLinkedInResponse.jsp";		//this was the "OAuth 2.0 Redirect URLs" for my app, change "localhost:8081/LinkedIn" as per your application, leave the rest as it is
	public static final String CLASSFILE_PATH = "C:/Aman_Java/Practise/LinkedIn/WebContent/WEB-INF";					//this is the absolute path for the applications WEB-INF folder
	
	
	/*
	 * don't change the values of following constants
	 */
	public static String ACCESS_TOKEN = "";
	public static String EXPIRES_IN = "";
	public static final String OATH_STRING = "oauth2_access_token";
	public static final String PROTOCOL_SCHEME = "https";
	public static final String HOST = "www.linkedin.com";
	public static final String API_HOST = "api.linkedin.com";
	public static final String ERROR_DISPLAY_MESSAGE="Something went wrong. Please try after few minutes.";
	
}
