/**
 * @author Aman Rana
 */

function display(api){
	console.log("called");
	$('#apiFeatures .info').hide();
	$('#apiFeatures .display').show();
	$('#apiData .info').show();
	$('#apiData .display').hide();
	$(api).find('a').css('background', $(api).css('border-left-color')+'url(./images/arrowRight.png) 97% center no-repeat');
	$(api).siblings().find('a').removeAttr('style');
	$("ul[id*='apiFeatures'] li").css('display','none');
	$("ul[id*='apiFeatures'] li[class='"+$(api).attr('class')+"']").css('display','block');
}

function getJSPContent(url,apiFeature){
	$('#apiData .info').hide();
	$('#apiData .display').show();
	console.log("all set --> "+apiFeature);
	
	$(apiFeature).find('a').css('background', $(apiFeature).css('border-left-color')+'url(./images/arrowDown.png) 97% center no-repeat');
	console.log("1st");
	$(apiFeature).siblings().find('a').removeAttr('style');
	console.log("2nd");
	$("ul[id*='apiFeaturesCompany'] li").css('display','none');
	$("ul[id*='apiFeaturesCompany'] li[class='"+$(apiFeature).attr('class')+"']").css('display','block');
	
	$('#data').css('display','none');
	$('#loader').css('display','block');
	
	$.ajax({
	    type:'POST',
		url: url,
		success: function(data) {
			$('#loader').css('display','none');
			$("#data").html(data);		
			$('#data').css('display','block');
		}
	});
}

function makeRequest(url,dataToSend)
{
	$('#data').css('display','none');
	$('#loader').css('display','block');
	$.ajax({
	    type:'POST',
		url: url,
		data:dataToSend,
		success: function(data) {
			$("#data").html(data);
			$('#loader').css('display','none');
			$('#data').css('display','block');
		}
	});
	
}

function getAccessCode(uri)
{
	window.open(uri, "_blank");
}

function onWindowClose(accessToken,expiresIn)
{
	$('#data').css('display','none');
	$('#loader').css('display','block');
	$.ajax({
	    type:'POST',
		url: 'authenticate/authenticate.jsp',
		data :{ "accessToken" : accessToken,"expiresIn":expiresIn},
		success: function(data) {
			$('#loader').css('display','none');
			$("#data").html(data);		
			$('#data').css('display','block');		
			
		}
	});
}