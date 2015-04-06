<%@page import="com.format.FormatJSONUtil"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.mgr.RequestMgr"%>
<%@page import="java.net.URI"%>
<%@page errorPage="../defaultErrorPage.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Company</title>
</head>
<body>

<%
	String searchParams = request.getParameter("searchParams");
	JSONObject json = null;
	boolean isError=false;
	StringBuilder parameters = null;
	URI uri = null;
	String[] values = null;
	String criteria;
	if(searchParams!=null)
	{
		criteria = request.getParameter("criteria");
		parameters = new StringBuilder(""); 
		values = request.getParameterValues("company");
		if(values!=null)
		{
			for(String value : values)
			{
				parameters.append(value+",");
			}
		}
		
		if(parameters.length()>0 && parameters.charAt(parameters.length()-1)==',')
			parameters = parameters.deleteCharAt(parameters.length()-1);
		
		if(values!=null && values.length>0)
		{
			if("id".equals(criteria))
				uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+searchParams+":("+parameters+")");
			else if("universalName".equals(criteria))
				uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/universal-name="+searchParams+":("+parameters+")");
			else if("emailDomain".equals(criteria))
				uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies:("+parameters+")","email-domain",searchParams);
			else
				uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies:("+parameters+")","is-company-admin","true");
		}
		else
		{
			if("id".equals(criteria))
				uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+searchParams);
			else if("universalName".equals(criteria))
				uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/universal-name="+searchParams);
			else if("emailDomain".equals(criteria)) 
				uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies","email-domain",searchParams);
			else
				uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies","is-company-admin","true");
		}
		
		System.out.println("uri : "+uri);
		
		json = RequestMgr.getInstance().getMakeHttpGetRequest().process(uri);
		
		
		System.out.println("CompanyJSP : json : "+json);
		if(json.has("errorCode"))
			isError=true;
		
	}
%>
<%if(searchParams==null){ %>
<div style="margin-left: 30px;">
	<h3>Search Company Profile</h3>
	<div style="margin-left: 20px;">
		<form action="" method="post" id="companyForm">
			<font size="3px;"><b>Search By :</b></font> 
			<input type="radio" name="criteria" id="id" value="id" onclick="changeCriteria();" checked><label for="id">Id</label>
			<input type="radio" name="criteria" id="universalName" value="universalName" onclick="changeCriteria();"><label for="universalName">Universal Name</label>
			<input type="radio" name="criteria" id="emailDomain" value="emailDomain" onclick="changeCriteria();"><label for="emailDomain">Email Domain</label>
			<input type="radio" name="criteria" id="iAdmin" value="iAdmin" onclick="changeCriteria();"><label for="iAdmin">Companies I Admin</label>
			<input type="text" placeholder="Enter Company Id" name="searchParams" id="searchParams">
			<input type="button" value="Submit" onclick="return validate();">
			<br>
			<input type="checkbox" id="selectAdditionalParams" onclick="additionalParameters();"><label for="selectAdditionalParams">Specify Additional Parameters</label>
			<div id="additionalParams" style="margin-left:50px; display:none;">
				<input type="checkbox" name="company" id="companyName" value="name"><label for="companyName" >Human Readable Name</label><br>
				<input type="checkbox" name="company" id="companyUniversalName" value="universal-name"><label for="companyUniversalName" >Company's Unique Identifier</label><br>
				<input type="checkbox" name="company" id="companyEmailDomains" value="email-domains"><label for="companyEmailDomains">Email Domain Of Company</label><br>
				<input type="checkbox" name="company" id="companyDescription" value="description"><label for="companyDescription" >Description</label><br>
				<input type="checkbox" name="company" id="companyType" value="company-type"><label for="companyType">Type of Company</label><br>
				<input type="checkbox" name="company" id="companyTicker" value="ticker"><label for="companyTicker">Ticker for Stock Exchange</label><br>
				<input type="checkbox" name="company" id="companyWebsiteUrl" value="website-url"><label for="companyWebsiteUrl">Website</label><br>
				<input type="checkbox" name="company" id="companyIndustryCode" value="industries"><label for="companyIndustryCode">Industry Code</label><br>
				<input type="checkbox" name="company" id="companyStatus" value="status"><label for="companyStatus">Operating Status</label><br>
				<input type="checkbox" name="company" id="companyLogoUrl" value="logo-url"><label for="companyLogoUrl">Logo</label><br>
				<input type="checkbox" name="company" id="companyTwitterId" value="twitter-id"><label for="companyTwitterId">Twitter Id</label><br>
				<input type="checkbox" name="company" id="companyEmployeeCountRange" value="employee-count-range"><label for="companyEmployeeCountRange">Employees Count</label><br>
				<input type="checkbox" name="company" id="companyLocations" value="locations:(is-headquarters,address,contact-info)"><label for="companyLocations">HeadQuaters</label><br>
				<input type="checkbox" name="company" id="companyFoundedYear" value="founded-year"><label for="companyFoundedYear">Year Founded</label><br>
				<input type="checkbox" name="company" id="companyNumFollers" value="num-followers"><label for="companyNumFollers">No. Of Followers</label><br>
			</div>
		</form>
	</div>
</div>
<%} else {%> 
<table width="100%" class="linkedInApi" style="table-layout: fixed; text-align: left;" >		
		<%if(isError){
%>
	<thead><tr><td width="100%">Request Doesn't Completed Successfully</td></tr></thead>
	<tbody><tr><td width="100%">Message : <%=json.getString("message") %></td></tr></tbody>


		<%		}else { %>
	<thead><tr><td width="15%">Company Information</td></tr></thead>
	<tbody>	
	<%if(values!=null && values.length>0){ %>
		<tr><td width="10%">Search Parameter </td><td width="90%"><%=searchParams %></td></tr>
		<%if(json.has("values")){ %>
			<%=FormatJSONUtil.getHTMLForCompanyEmailSearch(values, json) %>
		<%} else { %>
			<%=FormatJSONUtil.getHTMLForCompanySearch(values,json) %>
		<%} %>
	<%} else { %>
		<%if(json.has("values")){ %>
			<%=FormatJSONUtil.getHTMLForCompanyEmailSearch(json) %>	
		<%} else { %>
			<tr><td>Company Id : </td><td><%=json.has("id")?json.getInt("id"):"-NA-" %></td></tr>
			<tr><td>Company Name : </td><td><%=json.has("name")?json.getString("name"):"-NA-" %></td></tr>
		<%} %>
	<%} %>
	</tbody>
		<% } %>
</table>		
	<% } %>
	
<script type="text/javascript">
function changeCriteria(){
	var checked = $("[type='radio']:checked").val();
	if(checked=="id")
	{
		$('#searchParams').show();
		$('#searchParams').val("");
		$('#searchParams').attr("placeholder","Enter Company Id");
	}
	else if(checked=="universalName")
	{
		$('#searchParams').show();
		$('#searchParams').val("");
		$('#searchParams').attr("placeholder","Enter Universal Name");
	}
	else if(checked=="emailDomain")
	{
		$('#searchParams').show();
		$('#searchParams').val("");
		$('#searchParams').attr("placeholder","Enter Email Domain");
	}
	else
	{
		$('#searchParams').hide();
		$('#searchParams').val(" ");
	}
	
}
function additionalParameters()
{
	$("#additionalParams").toggle("slow");
}

function validate(){
	if(document.getElementById("searchParams").value=="")
	{
		alert("Please Enter Search Criteria");
		document.getElementById("searchParams").focus();
		return false;
	}
	
	makeRequest('company/searchCompanyProfile.jsp',$('#companyForm').serialize());
}
</script>
</body>
</html>