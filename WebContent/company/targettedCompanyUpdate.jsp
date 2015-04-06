<%@page import="org.json.JSONArray"%>
<%@page import="com.format.HtmlUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.net.URI"%>
<%@page import="com.mgr.RequestMgr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Targetted Post on Company</title>
</head>
<body>
<%! 
/*
This method creates the json object to be send to make the post request for
sharing an update.
*/
public JSONObject createJSONforPost(HttpServletRequest request,boolean linkPost)
{
	JSONObject visibility,outputJson;
	String postVisibility,comment;
	String targets[];
	
	visibility = new JSONObject();
	outputJson = new JSONObject();
	
	
	targets = request.getParameterValues("targetType");
	for(String e : targets)
	System.out.println("==== > "+e);
	
	postVisibility = request.getParameter("postVisibility");
	comment  = request.getParameter("comment");
	if(comment==null)
		comment="";
	
	if(linkPost)
	{
		String submittedUrl,title,description,submittedImageUrl;
		JSONObject content = new JSONObject();
		submittedUrl = request.getParameter("submitted­url");
		title = request.getParameter("title");
		description = request.getParameter("description");
		submittedImageUrl = request.getParameter("submitted-image-url");
		
		try{
			if(submittedUrl!=null)
				content.put("submitted-url", submittedUrl);
			if(description!=null)
				content.put("description", description);
			content.put("title", title);
			content.put("submitted-image-url", submittedImageUrl);
			outputJson.put("content",content);
		}catch(JSONException e){
			System.out.println("Exception in creating content for JSON object");
		}
	}

	try{
		visibility.put("code",postVisibility);
		outputJson.put("visibility",visibility);
		outputJson.put("comment",comment);
		
		if(targets!=null && targets.length>0)
		{
			JSONObject shareTargets = new JSONObject();
			JSONObject shareTargetObj = new JSONObject();
			JSONObject shareTar,tvalue;
			JSONArray shareTarget = new JSONArray();
			String code="",tValue="";
			
			for(int i=0;i<targets.length;i++)
			{
				if(targets[i].equals("geosTarget"))
				{
					code = "geos";
					tValue = request.getParameter("geos");
				}
				else if(targets[i].equals("companySizesTarget"))
				{
					code = "companySizes";
					tValue = request.getParameter("companySizes");
				}
				else if(targets[i].equals("jobFuncTarget"))
				{
					code = "jobFunc";
					tValue = request.getParameter("jobFunc");
				}
				else if(targets[i].equals("industriesTarget"))
				{
					code = "industries";
					tValue = request.getParameter("industries");
				}
				else if(targets[i].equals("senioritiesTarget"))
				{
					code = "seniorities";
					tValue = request.getParameter("seniorities");
				}
				
				shareTar = new JSONObject();
				tvalue = new JSONObject();
				tvalue.put("tvalue",tValue);
				shareTar.put("tvalues", tvalue);
				shareTar.put("code",code);
				shareTarget.put(i, shareTar);
			}
			shareTargetObj.put("share-target",shareTarget);
			shareTargets.put("share-targets",shareTargetObj);
			outputJson.put("share-target-reach",shareTargets);
		}
		
		
	}catch(JSONException e)
	{
		System.out.println("Exception in creating JSON object");
	}
	
	return outputJson;
}
%>
<%
	String companyId = request.getParameter("companyId");
	JSONObject json = null;
	boolean isError=false;
	URI uri = null;
	String filter=null;
	if(companyId!=null)
	{
		String postType;
		postType = request.getParameter("postType");
		if("message".equals(postType))
			json = createJSONforPost(request,false);
		else
			json = createJSONforPost(request,true);
		
		
		uri = RequestMgr.getInstance().getBuildURI().getURI("/v1/companies/"+companyId+"/shares");
		
		System.out.println("json : "+json+"\n\n uri : "+uri);
		
		
		json = RequestMgr.getInstance().getMakeHttpPostRequest().process(uri, json);
		
		System.out.println("\n\n\n final JSON : "+json);
	}
	if(json!=null && json.has("errorCode"))
		isError=true;
%>
<%if(companyId==null){ %>
<div style="margin-left: 30px;">
	<h3>Targetted Company Posts</h3>
		<div style="margin-left: 20px;">
			<span>Note : Posts can only be made to the companies you admin.</span>
			<form action="" method="post" id="companyForm">
				<table class="linkedInApi" width="100%">
					<tr>
						<td width="12%">
							<span><b>Enter Company Id :</b></span>
						</td>
						<td width="88%">
							<input type="text" id="companyId" name="companyId" placeholder="Company Id" value="">
						</td>
					</tr>
					<tr>
						<td>
							<span><b>Post Type :</b></span>
						</td>
						<td>
							<input type="radio" name="postType" id="message" value="message" onclick="showPostType(this);"><label for="message">Message</label>
							<input type="radio" name="postType" id="link" value="link" onclick="showPostType(this);"><label for="link">Link</label>
						</td>
					</tr>
					<tr>
						<td>
						</td>
						<td>
							<div id="msgDiv" style="display:none; width:500px;">
								<div style="float:left;">
									<table class="linkedInApi" width="100%">
									<tr>
										<td>
											<span>Post Visibility : </span>
										</td>
										<td>
											<select id="postVisibility" name="postVisibility">
												<option value="anyone">anyone</option>
												<option value="dark">connections-only</option>
											</select>
										</td>
									</tr>
									<tr>
										<td style="vertical-align:top;">
											<span>Message : </span>
										</td>
										<td>
											<textarea id="comment" name="comment" rows="5" cols="30" placeholder="Message to post"></textarea>
											&nbsp;
											<span>Max. 700 characters.</span>
										</td>
									</tr>
									</table>
								</div>
						
								<div id="linkDiv" style="display:none;">
									<table class="linkedInApi" width="100%">
									<tr>
										<td>
											<span>Title : </span>
										</td>
										<td>
											<input type="text" style="width:260px;" placeholder="Title" name="title" id="title"/>&nbsp;&nbsp;<span>Max. 200 characters.</span>
										</td>
									</tr>
									<tr>
										<td>
											<span>Description : </span>
										</td>
										<td>
											<input type="text" style="width:260px;" placeholder="Description" name="description" id="description"/>&nbsp;&nbsp;<span>Max. 256 characters.</span>
										</td>
									</tr>
									<tr>
										<td>
											<span>Url : </span>
										</td>
										<td>
											<input type="text" style="width:260px;" placeholder="Url" name="submitted­url" id="submitted­url"/>
										</td>
									</tr>
									<tr>
										<td>
											<span>Image <u>Url</u> : </span>
										</td>
										<td>
											<input type="text" style="width:260px;" placeholder="Image Url" name="submitted-image-url" id="submitted-image-url"/>
										</td>
									</tr>
								</table>
							</div>
						</div>
						</td>
					</tr>
					<tr>
						<td style="vertical-align: top;">
							<span><b>Target Post :</b></span>
						</td>
						<td>
							<table class="linkedInApi">
								<tr>
									<td width="10%">
										<input type="checkbox" name="targetType" id="geosTarget" value="geosTarget"><label for="geosTarget">Geographic Locations</label>
									</td>
									&nbsp;
									<td width="50%">
										<%=HtmlUtil.getComboForGeoLoctions() %>
									</td>
								</tr>
								<tr>
									<td>
										<input type="checkbox" name="targetType" id="companySizesTarget" value="companySizesTarget"><label for="companySizesTarget">Company Size</label>
									</td>
									&nbsp;
									<td>
										<select id="companySizes" name="companySizes">
											<option value="self">Self Employed</option>
											<option value="1-10">1-10</option>
											<option value="11-50">11-50</option>
											<option value="51-200">51-200</option>
											<option value="201-500">201-500</option>
											<option value="501-1000">501-1000</option>
											<option value="1001-5000">1001-5000</option>
											<option value="5001-10000">5001-10000</option>
											<option value="10001">10000+Employees</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<input type="checkbox" name="targetType" id="jobFuncTarget" value="jobFuncTarget"><label for="jobFuncTarget">Job Function</label>
									</td>
									&nbsp;
									<td>
										<%=HtmlUtil.getComboForJobFunctions() %>
									</td>
								</tr>
								<tr>
									<td>
										<input type="checkbox" name="targetType" id="industriesTarget" value="industriesTarget"><label for="industriesTarget">Industries</label>
									</td>
									&nbsp;
									<td>
										<%=HtmlUtil.getComboForIndustries() %>
									</td>
								</tr>
								<tr>
									<td>
										<input type="checkbox" name="targetType" id="senioritiesTarget" value="senioritiesTarget"><label for="senioritiesTarget">Seniority</label>
									</td>
									&nbsp;
									<td>
										<%=HtmlUtil.getComboForSeniority() %>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<br><br>
				<input type="button" onclick="return validate();" value="Submit">
			</form>
		</div>
</div>
<%} else {%> 
<table width="100%" class="linkedInApi" style="table-layout: fixed; text-align: left;" >		
		<%if(isError){
%>
	<thead><tr><td width="100%">Request Doesn't Completed Successfully</td></tr></thead>
	<tbody><tr><td width="100%">Message : <%=json.getString("message") %></td></tr></tbody>
<%} else{%>
	<thead><tr><td>Post Created Successfully</td></tr></thead>
<%}
}%>
</table>
<script type="text/javascript">
function showPostType(type){
	if($("input[id=message]:checked").val())
	{
		$('#linkDiv').hide();
		$('#msgDiv').show();
	}
	else
	{
		$('#msgDiv').show();
		$('#linkDiv').show();
	}
}

function validate(){
	if($('#companyId').val()=="")
	{
		alert("Please enter Company Id.");
		$('#companyId').focus();
		return false;
	}
	else if(!$("input[id=message]:checked").val())
	{
		if(!$("input[id=link]:checked").val())
		{
			alert("Please select the Post Type.");
			return false;
		}
	}
	
	makeRequest('company/targettedCompanyUpdate.jsp',$('#companyForm').serialize());
}
</script>
</body>
</html>