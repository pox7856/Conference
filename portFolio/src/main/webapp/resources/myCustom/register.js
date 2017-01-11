$(document).ready(function() {
	
	 $(document).on("dragenter dragover", function(event) {
	    event.preventDefault();
	 }); 
	   
    $(document).on("drop", function(event) {
        event.preventDefault();
    });

    $(".fileDrop").on("dragenter dragover", function(event) {
        event.preventDefault();
    });

    var regForm = $("#register-form"); 

    $('#regBtn').on("click", function(event) {
        event.preventDefault();   
        regForm.submit();
    }); 
     
});