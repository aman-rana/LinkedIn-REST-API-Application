<%@page import="com.mgr.RequestMgr"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.net.URI"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Post on Company</title>
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
	visibility = new JSONObject();
	outputJson = new JSONObject();
	
	
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
	}
	if(json!=null && json.has("errorCode"))
		isError=true;
%>
<%if(companyId==null){ %>
<div style="margin-left: 30px;">
	<h3>Post Company Update</h3>
		<div style="margin-left: 20px;">
			<span>Note : Posts can only be made to the companies you admin.</span>
			<form action="" method="post" id="companyForm">
				<span><b>Enter Company Id :</b></span>
				<input type="text" id="companyId" name="companyId" placeholder="Company Id" value="">
				<br>
				<span><b>Post Type :</b></span>
				<input type="radio" name="postType" id="message" value="message" onclick="showPostType(this);"><label for="message">Message</label>
				<input type="radio" name="postType" id="link" value="link" onclick="showPostType(this);"><label for="link">Link</label>
				<div id="msgDiv" style="margin-left:20px; display:none; width:500px;">
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
						
						<div id="linkDiv" sytle="display:none;">
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
	makeRequest('company/postCompanyUpdate.jsp',$('#companyForm').serialize());
}
</script>
</body>
</html>