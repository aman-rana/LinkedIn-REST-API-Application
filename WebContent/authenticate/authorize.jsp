<%-- This jsp redirects user to LinkedIn's authorization dialog for getting the authorization code
	see - https://developer.linkedin.com/documents/authentication
--%>
<%@page import="com.Constants"%>
<%@page import="org.apache.http.client.utils.URIBuilder"%>
<%@page import="java.net.URI"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Authorize App</title>
</head>
<body>
<%

	URI uri = new URIBuilder()
				.setScheme(Constants.PROTOCOL_SCHEME)
				.setHost(Constants.HOST)
				.setPath("/uas/oauth2/authorization")
				.setParameter("response_type", "code")
				.setParameter("client_id",Constants.API_KEY)
				.setParameter("state",Constants.STATE)
				.setParameter("redirect_uri", Constants.RETURN_URI)
				.build();

%>

<div align="center">
	<span>Click below button for Access Token</span><br/>
	<input type="button" value="Access Token" onclick="getAccessCode('<%=uri%>');"/>
</div>
</body>
</html>