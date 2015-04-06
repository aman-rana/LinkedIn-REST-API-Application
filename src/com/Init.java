package com;


/**
 * This Servlet class initializes the logger and reads the properties file for
 * the already saved access token.
 * @author Amandeep Rana
 */
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;

@SuppressWarnings("serial")
public class Init extends HttpServlet {
	static Logger logger = Logger.getLogger(Init.class);
	
	public void init()
	{
		
		//initialize logger
		DOMConfigurator.configureAndWatch(Constants.CLASSFILE_PATH+"/xml/log4j-config.xml", 10000);
		logger.info("initialized logers");
				
		BufferedReader br = null;
		try {
			FileReader fr = new FileReader(Constants.CLASSFILE_PATH+"/properties/AccessToken.txt");
			br = new BufferedReader(fr);
			Constants.ACCESS_TOKEN = br.readLine();
			Constants.EXPIRES_IN = br.readLine();
			logger.info("Constants Initialized with values \naccessToken "+Constants.ACCESS_TOKEN+"\nexpiresIn "+Constants.EXPIRES_IN);
			br.close();
			
		} catch (IOException e) {
			System.out.println("Exception in reading file containing Access Token");
		}
		finally{
			try {
				if(br!=null)
					br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}