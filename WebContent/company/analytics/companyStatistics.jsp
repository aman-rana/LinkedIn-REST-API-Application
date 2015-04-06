<%@page import="com.format.FormatJSONUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.mgr.RequestMgr"%>
<%@page import="java.net.URI"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Statistics</title>
</head>
<body>
<%
	String companyId = request.getParameter("companyId");
	JSONObject json = null;
	boolean isError=false;
	URI uri;
	
	if(companyId!=null)
	{
		uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+companyId+"/company-statistics");
		
		System.out.println("uri : "+uri);
		
		json = RequestMgr.getInstance().getMakeHttpGetRequest().process(uri);
		//json = new JSONObject("{\"followStatistics\":{\"countsByMonth\":{\"_total\":12,\"values\":[{\"date\":{\"month\":1,\"year\":2015},\"newCount\":11,\"totalCount\":220},{\"date\":{\"month\":12,\"year\":2014},\"newCount\":4,\"totalCount\":209},{\"date\":{\"month\":11,\"year\":2014},\"newCount\":15,\"totalCount\":205},{\"date\":{\"month\":10,\"year\":2014},\"newCount\":22,\"totalCount\":190},{\"date\":{\"month\":9,\"year\":2014},\"newCount\":15,\"totalCount\":168},{\"date\":{\"month\":8,\"year\":2014},\"newCount\":16,\"totalCount\":153},{\"date\":{\"month\":7,\"year\":2014},\"newCount\":10,\"totalCount\":137},{\"date\":{\"month\":6,\"year\":2014},\"newCount\":17,\"totalCount\":127},{\"date\":{\"month\":5,\"year\":2014},\"newCount\":12,\"totalCount\":110},{\"date\":{\"month\":4,\"year\":2014},\"newCount\":5,\"totalCount\":98},{\"date\":{\"month\":3,\"year\":2014},\"newCount\":13,\"totalCount\":93},{\"date\":{\"month\":2,\"year\":2014},\"newCount\":12,\"totalCount\":80}]},\"regions\":{\"_total\":25,\"values\":[{\"entryKey\":\"us-84\",\"entryValue\":\"15\"},{\"entryKey\":\"us-70\",\"entryValue\":\"8\"},{\"entryKey\":\"in-7151\",\"entryValue\":\"8\"},{\"entryKey\":\"cn-8911\",\"entryValue\":\"8\"},{\"entryKey\":\"id\",\"entryValue\":\"7\"},{\"entryKey\":\"in-7127\",\"entryValue\":\"7\"},{\"entryKey\":\"pk\",\"entryValue\":\"6\"},{\"entryKey\":\"in-6891\",\"entryValue\":\"6\"},{\"entryKey\":\"ae\",\"entryValue\":\"5\"},{\"entryKey\":\"tr\",\"entryValue\":\"4\"},{\"entryKey\":\"in-6508\",\"entryValue\":\"4\"},{\"entryKey\":\"sa\",\"entryValue\":\"4\"},{\"entryKey\":\"br-6368\",\"entryValue\":\"4\"},{\"entryKey\":\"us\",\"entryValue\":\"3\"},{\"entryKey\":\"fr-5211\",\"entryValue\":\"3\"},{\"entryKey\":\"eg\",\"entryValue\":\"3\"},{\"entryKey\":\"pt-7397\",\"entryValue\":\"3\"},{\"entryKey\":\"au-4910\",\"entryValue\":\"3\"},{\"entryKey\":\"np\",\"entryValue\":\"3\"},{\"entryKey\":\"in-6879\",\"entryValue\":\"3\"},{\"entryKey\":\"us-49\",\"entryValue\":\"2\"},{\"entryKey\":\"by\",\"entryValue\":\"2\"},{\"entryKey\":\"us-512\",\"entryValue\":\"2\"},{\"entryKey\":\"in-7292\",\"entryValue\":\"2\"},{\"entryKey\":\"dk-5038\",\"entryValue\":\"2\"}]},\"functions\":{\"_total\":25,\"values\":[{\"entryKey\":\"13\",\"entryValue\":\"28\"},{\"entryKey\":\"8\",\"entryValue\":\"27\"},{\"entryKey\":\"22\",\"entryValue\":\"14\"},{\"entryKey\":\"12\",\"entryValue\":\"12\"},{\"entryKey\":\"15\",\"entryValue\":\"11\"},{\"entryKey\":\"18\",\"entryValue\":\"11\"},{\"entryKey\":\"25\",\"entryValue\":\"10\"},{\"entryKey\":\"6\",\"entryValue\":\"10\"},{\"entryKey\":\"9\",\"entryValue\":\"10\"},{\"entryKey\":\"10\",\"entryValue\":\"8\"},{\"entryKey\":\"19\",\"entryValue\":\"5\"},{\"entryKey\":\"1\",\"entryValue\":\"5\"},{\"entryKey\":\"3\",\"entryValue\":\"5\"},{\"entryKey\":\"24\",\"entryValue\":\"5\"},{\"entryKey\":\"2\",\"entryValue\":\"4\"},{\"entryKey\":\"26\",\"entryValue\":\"4\"},{\"entryKey\":\"16\",\"entryValue\":\"3\"},{\"entryKey\":\"4\",\"entryValue\":\"3\"},{\"entryKey\":\"7\",\"entryValue\":\"3\"},{\"entryKey\":\"17\",\"entryValue\":\"2\"},{\"entryKey\":\"20\",\"entryValue\":\"2\"},{\"entryKey\":\"23\",\"entryValue\":\"2\"},{\"entryKey\":\"11\",\"entryValue\":\"1\"},{\"entryKey\":\"14\",\"entryValue\":\"1\"},{\"entryKey\":\"5\",\"entryValue\":\"0\"}]},\"industries\":{\"_total\":71,\"values\":[{\"entryKey\":\"96\",\"entryValue\":\"40\"},{\"entryKey\":\"6\",\"entryValue\":\"22\"},{\"entryKey\":\"4\",\"entryValue\":\"18\"},{\"entryKey\":\"116\",\"entryValue\":\"5\"},{\"entryKey\":\"80\",\"entryValue\":\"5\"},{\"entryKey\":\"104\",\"entryValue\":\"5\"},{\"entryKey\":\"137\",\"entryValue\":\"4\"},{\"entryKey\":\"47\",\"entryValue\":\"4\"},{\"entryKey\":\"43\",\"entryValue\":\"4\"},{\"entryKey\":\"11\",\"entryValue\":\"3\"},{\"entryKey\":\"48\",\"entryValue\":\"3\"},{\"entryKey\":\"8\",\"entryValue\":\"3\"},{\"entryKey\":\"51\",\"entryValue\":\"3\"},{\"entryKey\":\"68\",\"entryValue\":\"3\"},{\"entryKey\":\"70\",\"entryValue\":\"3\"},{\"entryKey\":\"135\",\"entryValue\":\"2\"},{\"entryKey\":\"57\",\"entryValue\":\"2\"},{\"entryKey\":\"134\",\"entryValue\":\"2\"},{\"entryKey\":\"15\",\"entryValue\":\"2\"},{\"entryKey\":\"44\",\"entryValue\":\"2\"},{\"entryKey\":\"121\",\"entryValue\":\"2\"},{\"entryKey\":\"52\",\"entryValue\":\"2\"},{\"entryKey\":\"34\",\"entryValue\":\"2\"},{\"entryKey\":\"112\",\"entryValue\":\"2\"},{\"entryKey\":\"27\",\"entryValue\":\"2\"},{\"entryKey\":\"28\",\"entryValue\":\"2\"},{\"entryKey\":\"109\",\"entryValue\":\"2\"},{\"entryKey\":\"31\",\"entryValue\":\"2\"},{\"entryKey\":\"12\",\"entryValue\":\"1\"},{\"entryKey\":\"55\",\"entryValue\":\"1\"},{\"entryKey\":\"17\",\"entryValue\":\"1\"},{\"entryKey\":\"138\",\"entryValue\":\"1\"},{\"entryKey\":\"60\",\"entryValue\":\"1\"},{\"entryKey\":\"122\",\"entryValue\":\"1\"},{\"entryKey\":\"3\",\"entryValue\":\"1\"},{\"entryKey\":\"46\",\"entryValue\":\"1\"},{\"entryKey\":\"123\",\"entryValue\":\"1\"},{\"entryKey\":\"49\",\"entryValue\":\"1\"},{\"entryKey\":\"7\",\"entryValue\":\"1\"},{\"entryKey\":\"128\",\"entryValue\":\"1\"},{\"entryKey\":\"127\",\"entryValue\":\"1\"},{\"entryKey\":\"129\",\"entryValue\":\"1\"},{\"entryKey\":\"91\",\"entryValue\":\"1\"},{\"entryKey\":\"94\",\"entryValue\":\"1\"},{\"entryKey\":\"93\",\"entryValue\":\"1\"},{\"entryKey\":\"10\",\"entryValue\":\"1\"},{\"entryKey\":\"98\",\"entryValue\":\"1\"},{\"entryKey\":\"53\",\"entryValue\":\"1\"},{\"entryKey\":\"78\",\"entryValue\":\"1\"},{\"entryKey\":\"33\",\"entryValue\":\"1\"},{\"entryKey\":\"115\",\"entryValue\":\"1\"},{\"entryKey\":\"84\",\"entryValue\":\"1\"},{\"entryKey\":\"42\",\"entryValue\":\"1\"},{\"entryKey\":\"102\",\"entryValue\":\"1\"},{\"entryKey\":\"25\",\"entryValue\":\"1\"},{\"entryKey\":\"145\",\"entryValue\":\"1\"},{\"entryKey\":\"26\",\"entryValue\":\"1\"},{\"entryKey\":\"147\",\"entryValue\":\"1\"},{\"entryKey\":\"106\",\"entryValue\":\"1\"},{\"entryKey\":\"105\",\"entryValue\":\"1\"},{\"entryKey\":\"30\",\"entryValue\":\"1\"},{\"entryKey\":\"132\",\"entryValue\":\"0\"},{\"entryKey\":\"19\",\"entryValue\":\"0\"},{\"entryKey\":\"45\",\"entryValue\":\"0\"},{\"entryKey\":\"89\",\"entryValue\":\"0\"},{\"entryKey\":\"50\",\"entryValue\":\"0\"},{\"entryKey\":\"95\",\"entryValue\":\"0\"},{\"entryKey\":\"41\",\"entryValue\":\"0\"},{\"entryKey\":\"23\",\"entryValue\":\"0\"},{\"entryKey\":\"146\",\"entryValue\":\"0\"},{\"entryKey\":\"75\",\"entryValue\":\"0\"}]},\"count\":221,\"companySizes\":{\"_total\":9,\"values\":[{\"entryKey\":\"I\",\"entryValue\":\"30\"},{\"entryKey\":\"D\",\"entryValue\":\"21\"},{\"entryKey\":\"C\",\"entryValue\":\"17\"},{\"entryKey\":\"B\",\"entryValue\":\"13\"},{\"entryKey\":\"G\",\"entryValue\":\"12\"},{\"entryKey\":\"F\",\"entryValue\":\"9\"},{\"entryKey\":\"A\",\"entryValue\":\"6\"},{\"entryKey\":\"E\",\"entryValue\":\"6\"},{\"entryKey\":\"H\",\"entryValue\":\"5\"}]},\"countries\":{\"_total\":25,\"values\":[{\"entryKey\":\"in\",\"entryValue\":\"50\"},{\"entryKey\":\"us\",\"entryValue\":\"45\"},{\"entryKey\":\"cn\",\"entryValue\":\"14\"},{\"entryKey\":\"id\",\"entryValue\":\"8\"},{\"entryKey\":\"tr\",\"entryValue\":\"6\"},{\"entryKey\":\"br\",\"entryValue\":\"6\"},{\"entryKey\":\"pk\",\"entryValue\":\"6\"},{\"entryKey\":\"de\",\"entryValue\":\"5\"},{\"entryKey\":\"ae\",\"entryValue\":\"5\"},{\"entryKey\":\"it\",\"entryValue\":\"4\"},{\"entryKey\":\"sa\",\"entryValue\":\"4\"},{\"entryKey\":\"eg\",\"entryValue\":\"3\"},{\"entryKey\":\"es\",\"entryValue\":\"3\"},{\"entryKey\":\"fr\",\"entryValue\":\"3\"},{\"entryKey\":\"nl\",\"entryValue\":\"3\"},{\"entryKey\":\"np\",\"entryValue\":\"3\"},{\"entryKey\":\"au\",\"entryValue\":\"3\"},{\"entryKey\":\"pt\",\"entryValue\":\"3\"},{\"entryKey\":\"ph\",\"entryValue\":\"3\"},{\"entryKey\":\"mx\",\"entryValue\":\"2\"},{\"entryKey\":\"dk\",\"entryValue\":\"2\"},{\"entryKey\":\"gb\",\"entryValue\":\"2\"},{\"entryKey\":\"ng\",\"entryValue\":\"2\"},{\"entryKey\":\"ge\",\"entryValue\":\"2\"},{\"entryKey\":\"hk\",\"entryValue\":\"2\"}]},\"nonEmployeeCount\":220,\"employeeCount\":1,\"seniorities\":{\"_total\":10,\"values\":[{\"entryKey\":\"3\",\"entryValue\":\"79\"},{\"entryKey\":\"4\",\"entryValue\":\"53\"},{\"entryKey\":\"5\",\"entryValue\":\"16\"},{\"entryKey\":\"8\",\"entryValue\":\"11\"},{\"entryKey\":\"10\",\"entryValue\":\"10\"},{\"entryKey\":\"6\",\"entryValue\":\"8\"},{\"entryKey\":\"9\",\"entryValue\":\"7\"},{\"entryKey\":\"2\",\"entryValue\":\"3\"},{\"entryKey\":\"7\",\"entryValue\":\"3\"},{\"entryKey\":\"1\",\"entryValue\":\"0\"}]}},\"statusUpdateStatistics\":{\"viewsByMonth\":{\"_total\":12,\"values\":[{\"date\":{\"month\":1,\"year\":2015},\"shares\":1,\"comments\":3,\"engagement\":0.0034961591491038013,\"clicks\":62,\"impressions\":20308,\"likes\":5},{\"date\":{\"month\":12,\"year\":2014},\"shares\":2,\"comments\":5,\"engagement\":0.005178663904712584,\"clicks\":58,\"impressions\":15448,\"likes\":15},{\"date\":{\"month\":11,\"year\":2014},\"shares\":0,\"comments\":8,\"engagement\":0.0037084127993218903,\"clicks\":60,\"impressions\":18876,\"likes\":2},{\"date\":{\"month\":10,\"year\":2014},\"shares\":4,\"comments\":22,\"engagement\":0.006791083462934163,\"clicks\":81,\"impressions\":19290,\"likes\":24},{\"date\":{\"month\":9,\"year\":2014},\"shares\":1,\"comments\":38,\"engagement\":0.009034051424600417,\"clicks\":46,\"impressions\":14390,\"likes\":45},{\"date\":{\"month\":8,\"year\":2014},\"shares\":9,\"comments\":21,\"engagement\":0.007820011537721942,\"clicks\":81,\"impressions\":15601,\"likes\":11},{\"date\":{\"month\":7,\"year\":2014},\"shares\":4,\"comments\":18,\"engagement\":0.004957507082152974,\"clicks\":57,\"impressions\":16944,\"likes\":5},{\"date\":{\"month\":6,\"year\":2014},\"shares\":4,\"comments\":28,\"engagement\":0.007974228981833545,\"clicks\":103,\"impressions\":18936,\"likes\":16},{\"date\":{\"month\":5,\"year\":2014},\"shares\":0,\"comments\":3,\"engagement\":0.0030544986871014414,\"clicks\":50,\"impressions\":18661,\"likes\":4},{\"date\":{\"month\":4,\"year\":2014},\"shares\":1,\"comments\":58,\"engagement\":0.005777879912018647,\"clicks\":93,\"impressions\":30461,\"likes\":24},{\"date\":{\"month\":3,\"year\":2014},\"shares\":5,\"comments\":82,\"engagement\":0.00729641329568645,\"clicks\":154,\"impressions\":35771,\"likes\":20},{\"date\":{\"month\":2,\"year\":2014},\"shares\":1,\"comments\":24,\"engagement\":0.004312653268314683,\"clicks\":110,\"impressions\":35477,\"likes\":18}]}}}");
		System.out.println("json : "+json);
		
		if(json.has("errorCode"))
			isError=true;
	}


%>
<%if(companyId==null){ %>
<div style="margin-left: 30px;">
	<h3>Company Statistics</h3>
		<div style="margin-left: 20px;">
			<span>Note : Statistics are only available for the companies you admin.</span>
		
			<form action="" method="post" id="companyForm">
				<table class="linkedInApi">
					<tr>
						<td style="text-align: right;"><span><b>Enter Company Id :</b></span></td>
						<td><input type="text" id="companyId" name="companyId" placeholder="Company Id" value=""></td>
					</tr>
					<tr>
						<td colspan="2"><input type="button" onclick="return validate();" value="Submit"></td>
					</tr>
				</table>
			</form>
		</div>
</div>
<%} else{ %>
	<table width="100%" class="linkedInApi" style="table-layout: fixed; text-align: center;" >
	<%if(isError){%>
		<thead><tr><td width="100%">Request Doesn't Completed Successfully</td></tr></thead>
		<tbody><tr><td width="100%">Message : <%=json.getString("message") %></td></tr></tbody>
	<% }else { %>
		<thead><tr><td width="100%" style="font-weight: bold; font-family: Arial; font-height:16px; text-align:left;">Company Statistics</td></tr></thead>
		<tbody>	
			<%=FormatJSONUtil.getHTMLForCompanyStatistics(json)%>
		</tbody>	
		<%} %>
	</table>

<%} %>
<script type="text/javascript">
function validate(){
	
	if($('#companyId').val()=="")
	{
		alert("Please enter Company Id.");
		$('#companyId').focus();
		return false;
	}
	
	makeRequest('company/analytics/companyStatistics.jsp',$('#companyForm').serialize());
}

</script>
</body>
</html>