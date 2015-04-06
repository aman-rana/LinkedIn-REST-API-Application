<%@page import="com.format.FormatJSONUtil"%>
<%@page import="com.general.GeneralUtil"%>
<%@page import="com.mgr.RequestMgr"%>
<%@page import="java.net.URI"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Historical Follower Statistics</title>
</head>
<body>
<%
	
	String companyId = request.getParameter("companyId");
	String timeGranularity,startDate,endDate;
	JSONObject json = null;
	boolean isError=false;
	String parameterNames[] = null;
	String parameterValues[] = null;
	URI uri = null;
	int count=0;
	if(companyId!=null)
	{
		endDate = request.getParameter("end-timestamp");

		if(endDate!=null && !"".equals(endDate))
		{
			parameterNames = new String[3];
			parameterValues = new String[3];
		}
		else 
		{
			parameterNames = new String[2];
			parameterValues = new String[2];
		}
		
		parameterNames[count] = "time-granularity";
		parameterValues[count++] = request.getParameter("time-granularity");
		parameterNames[count] = "start-timestamp";
		startDate = request.getParameter("start-timestamp");
		parameterValues[count++] = GeneralUtil.getTimeStampInGMT(startDate, "MM/dd/yyyy");

		if(endDate!=null && !"".equals(endDate))
		{
			parameterNames[count] = "end-timestamp";
			parameterValues[count++] = GeneralUtil.getTimeStampInGMT(endDate,"MM/dd/yyyy");
		}
	
		uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+companyId+"/historical-follow-statistics", parameterNames, parameterValues);
		
		json = RequestMgr.getInstance().getMakeHttpGetRequest().process(uri);
		
		System.out.println("uri : "+uri);
		System.out.println("json : "+json);
		
		if(json.has("errorCode"))
			isError=true;
	
	}

%>
<%if(companyId==null){ %>
<div style="margin-left: 30px;">
	<h3>Historical Follower Statistics</h3>
		<div style="margin-left: 20px;">
			<span>Note : Statistics are only available for the companies you admin.</span>
		
			<form action="" method="post" id="companyForm">
				<table class="linkedInApi">
					<tr>
						<td style="text-align: right;"><span><b>Enter Company Id :</b></span></td>
						<td><input type="text" id="companyId" name="companyId" placeholder="Company Id" value=""></td>
					</tr>
					<tr>
						<td style="text-align: right;"><span><b>Time Period :</b></span></td>
						<td><select name="time-granularity">
								<option value="day">Day</option>
								<option value="month">Month</option>
							</select>
						</td>
					</tr>
					<tr>
						<td style="text-align:right;"><span><b>Start Date : </b></span></td>
						<td><input type="text" id="start-timestamp" name="start-timestamp"></td>
					</tr>
					<tr>
						<td style="text-align:right;"><span><b>End Date(optional) : </b></span></td>
						<td><input type="text" id="end-timestamp" name="end-timestamp"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="button" onclick="return validate();" value="Submit"></td>
					</tr>
				</table>
			</form>
		</div>
</div>
<%}else{ %>
	<table width="100%" class="linkedInApi" style="table-layout: fixed; text-align: center;" >
	<%if(isError){%>
		<thead><tr><td width="100%">Request Doesn't Completed Successfully</td></tr></thead>
		<tbody><tr><td width="100%">Message : <%=json.getString("message") %></td></tr></tbody>
	<% }else { %>
		<thead><tr><td width="100%" colspan="4" style="font-weight: bold; font-family: Arial; font-height:16px; text-align:left;">Historical Followers Statistics</td></tr></thead>
		<tbody>	
		<tr>
			<td width="15%"><u>Time</u></td>
			<td width="28%"><u>Organic Follower Count</u></td>
			<td width="28%"><u>Total Follower Count</u></td>
			<td width="28%"><u>Paid Follower Count</u></td>
		</tr>
			<%=FormatJSONUtil.getHTMLForHistoricFollowers(json) %>
		</tbody>	
		<%} %>
	</table>
<%} %>
<script type="text/javascript">
function validate(){
	var currentDate = new Date();
	
	if($('#companyId').val()=="")
	{
		alert("Please enter Company Id.");
		$('#companyId').focus();
		return false;
	}
	else if($("#start-timestamp").val()=="")
	{
		alert("Please enter Start Date.");
		$('#start-timestamp').focus();
		return false;
	}
	else if(new Date($("#start-timestamp").val())>currentDate)
	{
		alert("Start Date cannot be greater than Current Date.");
		$('#start-timestamp').focus();
		return false;
	}
	else if($("#end-timestamp").val()!="")
	{
		var startDate = new Date($("#start-timestamp").val());
		var endDate = new Date($("#end-timestamp").val());
		if(endDate<startDate)
		{
			alert("End Date cannot be less than Start Date.");
			$('#end-timestamp').focus();
			return false;
		}
		if(endDate>currentDate)
		{
			alert("End Date cannot be greater than Current Date.");
			$('#end-timestamp').focus();
			return false;
		}
	}
	makeRequest('company/analytics/historicalFollower.jsp',$('#companyForm').serialize());
}
$(document).ready(function (){
	$("#start-timestamp").datepicker();
	$("#end-timestamp").datepicker();
});

</script>
</body>
</html>