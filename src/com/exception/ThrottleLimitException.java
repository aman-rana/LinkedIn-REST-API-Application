/**
 * 
 */
package com.exception;

import org.json.JSONObject;

/**
 * @author Amandeep Rana
 *
 */
public class ThrottleLimitException extends Exception {

	public static StringBuilder message;
	/**
	 * 
	 */
	private static final long serialVersionUID = 8920088243625986898L;
	
	public ThrottleLimitException(String message)
	{
		super(message);
	}
	
	public ThrottleLimitException(String message,JSONObject json)
	{
		super(message);
		setJSONMessage(json);
	}

	private void setJSONMessage(JSONObject json) {
		// TODO Auto-generated method stub
		message = new StringBuilder(json.toString());
		
		//System.out.println(">>>>>>>>>>>>>> "+message);
		
	}
	
	public String getJSONMessage()
	{
		return message.toString();
	}

	

	
}
