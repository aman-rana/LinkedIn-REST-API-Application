<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.mgr.RequestMgr"%>
<%@page import="com.general.GeneralUtil"%>
<%@page import="java.net.URI"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.format.FormatJSONUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Historical Status Update Statistics</title>
</head>
<body>
<%
	System.out.println("Historical Status Update Stats.");
	String companyId = request.getParameter("companyId");
	String timeGranularity,startDate,endDate;
	JSONObject json = null;
	boolean isError=false;
	String parameterNames[] = null;
	String parameterValues[] = null;
	String params[];
	StringBuilder outputFields;
	URI uri = null;
	int count=0,colspan=2;
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

		params = request.getParameterValues("params");
		outputFields = new StringBuilder();
		if(params!=null)
		{
			colspan = params.length;
			for(String value : params)
			{
				outputFields.append(value+",");
			}
		}
		
		if(outputFields.length()>0 && outputFields.charAt(outputFields.length()-1)==',')
			outputFields = outputFields.deleteCharAt(outputFields.length()-1);
		
		if(params!=null && params.length>0)
			uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+companyId+"/historical-status-update-statistics:("+outputFields+")", parameterNames, parameterValues);
		else
			uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+companyId+"/historical-status-update-statistics", parameterNames, parameterValues);
		
		System.out.println("uri : "+uri);
		
		json = RequestMgr.getInstance().getMakeHttpGetRequest().process(uri);
		
		
		System.out.println("json : "+json);
		
		if(json.has("errorCode"))
			isError=true;
	
	}
%>
<%if(companyId==null){ %>
<div style="margin-left: 30px;">
	<h3>Historical Status Update Statistics</h3>
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
						<td><select name="time-granularity" id="time-granularity">
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
						<td colspan="2"><input type="checkbox" id="additionalParams" onclick="return additionalParameters();"><label for="additionalParams">Specify Additional Parameters</label></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="additionalParameters" style="margin-left:20px; display:none;">
								<input type="checkbox" name="params" id="time" value="time"><label for="time">Time</label><br>
								<input type="checkbox" name="params" id="like-count" value="like-count"><label for="like-count">Like Count</label><br>
								<input type="checkbox" name="params" id="impression-count" value="impression-count"><label for="impression-count">Impression Count</label><br>
								<input type="checkbox" name="params" id="click-count" value="click-count"><label for="click-count">Click Count</label><br>
								<input type="checkbox" name="params" id="comment-count" value="comment-count"><label for="comment-count">Comment Count</label><br>
								<input type="checkbox" name="params" id="share-count" value="share-count"><label for="share-count">Share Count</label><br>
								<input type="checkbox" name="params" id="engagement" value="engagement"><label for="engagement">Engagement</label><br>
								<input type="checkbox" name="params" id="unique-count" value="unique-count"><label for="unique-count">Unique Count</label>
							</div>
						</td>
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
		<thead><tr><td width="100%" colspan="<%=colspan %>" style="font-weight: bold; font-family: Arial; font-height:16px; text-align:left;">Historical Status Update Statistics</td></tr></thead>
		<tbody>	
			<%=FormatJSONUtil.getHTMLForHistoricStatus(json)%>
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
	makeRequest('company/analytics/historicalStatusUpdate.jsp',$('#companyForm').serialize());
}
$(document).ready(function (){
	$("#start-timestamp").datepicker();
	$("#end-timestamp").datepicker();
});
function additionalParameters()
{
	if($("#time-granularity").val()=="month")
	{
		$("#unique-count").hide();
		$("#unique-count").next().hide();
	}
	else
	{
		$("#unique-count").show();
		$("#unique-count").next().show();
	}
	
	$("#additionalParameters").toggle("slow");
	
}
</script>
</body>
</html>