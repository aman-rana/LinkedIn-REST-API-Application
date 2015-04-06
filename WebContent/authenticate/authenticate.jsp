<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.Constants"%>
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
String accessToken = request.getParameter("accessToken");
String expiresIn = request.getParameter("expiresIn");
Constants.ACCESS_TOKEN = accessToken;
Constants.EXPIRES_IN = expiresIn;
try{
	byte buf[] = accessToken.getBytes();
	OutputStream fos = new FileOutputStream(Constants.CLASSFILE_PATH+"/properties/AccessToken.txt");

	for(int i=0;i<buf.length;i++)
	{
		fos.write(buf[i]);
	}
	fos.write(10);	//integer value for new line
	
	buf=null;
	buf=expiresIn.getBytes();
	
	for(int i=0;i<buf.length;i++)
	{
		fos.write(buf[i]);
	}
	fos.close();
	
	Constants.ACCESS_TOKEN=accessToken;
	Constants.EXPIRES_IN=expiresIn;
	

}catch(Exception e)
{
	System.out.println("Got the exception");
}
%>
<table>
	<thead>
		<tr>
			<th colspan="2">
			RESPONSE
			</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Access Token</td>
			<td><%=accessToken %></td>
		</tr>
		<tr>
			<td>Expires In</td>
			<td><%=expiresIn%></td>
		</tr>
	</tbody>
</table>
</body>
</html>