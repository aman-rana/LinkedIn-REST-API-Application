# LinkedIn-REST-API-Application
A simple J2EE Application demonstrating LinkedIn REST API


This application demonstrates how to integrate the LinkedIn REST API with your java project.
Currently(in this initial commit) the work related to LinkedIn company pages have been done.
Visit : https://developer.linkedin.com/ for information regarding the API

This project was build using Eclipse(Mars Milestone 2) IDE having Java8 and Tomcat8 

External Jars Used : 
1. http-client
2. log4j
3. java-json


Assumption : You have already created an App on LinkedIn developers site with  proper permissions.

Configuration Steps
1. In the "src\com\Constants.java" file, provide the details regarding your linkedin app:
	a. API_KEY --> your app's api key
	b. SECRET_KEY --> your app's secret key
	c. RETURN_URI --> this is the "OAuth 2.0 Redirect URLs" for my app, change "http://localhost:8081/LinkedIn" as per your application, leave the rest as it is
	d. CLASSFILE_PATH --> this is the absolute path for the applications WEB-INF folder
2. In the "WebContent\WEB-INF\xml\log4j-config.xml" file, configure the logger file destinations