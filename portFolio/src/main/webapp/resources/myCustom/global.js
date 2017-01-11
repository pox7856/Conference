/**
 *  공톨 자바스크립트 모아논것들..  
 */
$(document).ready(function() { 
	/* 글로벌 설정 */
	
	var header = $('meta[name="_csrf_header"]').attr('content');
	var token = $('meta[name="_csrf"]').attr('content'); 
	$.ajaxSetup({
	    beforeSend: function(xhr) {
	        xhr.setRequestHeader(header, token);
	    }
	});
	
	$('body').bind("ajaxSend", function(elm, xhr, s) {
		if (s.type == "POST") {
			xhr.setRequestHeader(header, token);
		}
	}); 
});