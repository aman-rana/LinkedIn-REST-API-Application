<%-- this jsp is the return location after the user signIn to the app on LinkdeIn 
https://developer.linkedin.com/documents/authentication - Step 2b

--%>

<%@page import="com.mgr.RequestMgr"%>
<%@page import="com.Constants"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.http.client.utils.URIBuilder"%>
<%@page import="java.net.URI"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
<%
try{

	String access_code,state,error,error_description;
	boolean error_message=false;
	JSONObject json = null;
	String accessToken=null;
	long expiresIn=0;
	

	access_code = request.getParameter("code");
	state = request.getParameter("state");
	error = request.getParameter("error");
	error_description = request.getParameter("error_description");
	
	
	if(error!=null && !"".equals(error))
	{
		error_message = true;
	}
	else if(!Constants.STATE.equals(state))
	{
		//csrfAttack
		error_message = true;
	}
	else
	{
		
		URI uri = new URIBuilder()
					.setScheme(Constants.PROTOCOL_SCHEME)
					.setHost(Constants.HOST)
					.setPath("/uas/oauth2/accessToken")
					.setParameter("grant_type","authorization_code")
					.setParameter("code", access_code)
					.setParameter("redirect_uri",Constants.RETURN_URI)
					.setParameter("client_id", Constants.API_KEY)
					.setParameter("client_secret", Constants.SECRET_KEY)
					.build();
		
		//System.out.println("uri : "+uri);
		
		json = RequestMgr.getInstance().getMakeHttpGetRequest().process(uri);
		
		if(json!=null)
		{
			if(json.has("access_token"))
			{
				accessToken=json.getString("access_token");
			}
			if(json.has("expires_in"))
			{
				expiresIn=json.getLong("expires_in");
			}
		}
		
	}
	
%>
<script>
window.opener.onWindowClose("<%=accessToken%>","<%=expiresIn%>");
window.close();
</script>

<%}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</body>
</html>