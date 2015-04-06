<%@page import="com.format.FormatJSONUtil"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.net.URI"%>
<%@page import="com.mgr.RequestMgr"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Read Company Update</title>
</head>
<body>
<%
	String companyId = request.getParameter("companyId");
	System.out.println("\n\n companyId : "+companyId);
	JSONObject json = null;
	boolean isError=false;
	URI uri = null;
	String filter=null;
	if(companyId!=null)
	{
		filter = request.getParameter("fiterType");
		
		if(filter!=null)
		{
			uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+companyId+"/updates","event-type",filter);
		}
		else
		{
			uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+companyId+"/updates");
		}
		
		json = RequestMgr.getInstance().getMakeHttpGetRequest().process(uri);
		
		System.out.println("CompanyJSP : json : "+json);
		
		if(json.has("errorCode"))
			isError=true;
	}
%>
<%if(companyId==null){ %>
<div style="margin-left: 30px;">
	<h3>Read Company Updates</h3>
		<div style="margin-left: 20px;">
			<form action="" method="post" id="companyForm">
				<font size="3px;"><b>Enter Company Id :</b></font>
				<input type="text" id="companyId" name="companyId" placeholder="Enter Company Id" value="">
				<input type="button" onclick="return validate();" value="Submit">
				<br>
				<input type="checkbox" id="filterFeeds" onclick="showFilters();"><label for="filterFeeds">Filter Updates</label>
				<div id="filters" style="margin-left:50px; display:none;">
					<input type="radio" name="fiterType" value="job-posting" id="companyJobPosting"><label for="companyJobPosting">Job Updates</label><br>
					<input type="radio" name="fiterType" value="new-product" id="companyNewProduct"><label for="companyNewProduct">Product Updates</label><br>					
					<input type="radio" name="fiterType" value="status-update" id="companyStatusUpdate"><label for="companyStatusUpdate">Status Updates</label>
				</div>
			</form>
			
		</div>
</div>
<%}else{ %>
<table width="100%" id="linkedInApi" style="table-layout: fixed; text-align: left;" >
	<%if(isError){
	%>
	<thead><tr><td colspan="2" width='10%'>Request Doesn't Completed Successfully</td></tr></thead>
	<tbody><tr><td width="10%">Message : </td><td width="90%"><%=json.getString("message") %></td></tr></tbody>
	<% }else { %>
	<thead><tr><td width="15%" style="font-weight: bold; font-family: Arial; font-height:16px;">Company Updates</td></tr></thead>
	<tbody>	
	<%=FormatJSONUtil.getHTMLForCompanyUpdates(json) %>
	</tbody>	
	<%} %>
</table>
<%} %>
<script type="text/javascript">
function showFilters(){
	$("#filters").toggle("slow");
}

function validate(){
	if($('#companyId').val()=="")
	{
		alert("Please enter Company Id.");
		$('#companyId').focus();
		return false;
	}
	makeRequest('company/readCompanyUpdates.jsp',$('#companyForm').serialize());
}
</script>
</body>
</html>