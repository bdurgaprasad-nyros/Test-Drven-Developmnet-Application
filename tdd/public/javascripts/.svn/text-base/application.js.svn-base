// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//==========================================
//validate registration	
//==========================================

function validateFirstName(){
	var elementToValidate=$j('input#user_first_name');
	return validateNotEmpty(elementToValidate);
	
}	

function validateLastName(){
	var elementToValidate=$j('input#user_last_name');
	return validateNotEmpty(elementToValidate);
	
}

function validatePassword(){
	var elementToValidate=$j('#signup1_container input#user_password');
	var valueToValidate=elementToValidate.val();
	
	// rules for password here - blank, length less than 13, greater than 5
	if ( (isBlank(valueToValidate)) ||  (valueToValidate.length < 6) ||  (valueToValidate.length > 13) ){
		 handleInvalidValueFor(elementToValidate, "Please enter a password of 6-12 characters");
		return false;	   
	}else{
		handleValidValueFor(elementToValidate);
		return true;
	}
}

function validateConfirmPassword(){
	var elementToValidate=$j('#signup1_container input#user_password_confirmation');
	if ( !isBlank(elementToValidate) && ($j('#signup1_container input#user_password').val() == elementToValidate.val()) ){
		handleValidValueFor(elementToValidate);
		return true;
	}else{
		 handleInvalidValueFor(elementToValidate, "Please ensure your password and confirmation match.");
		return false;	   
	}
}



function validateSignupEmail(){
	var elementToValidate=$j('#signup1_container input#user_email');
   	return validateIsEmail(elementToValidate);
}

function validateFormSignUpStep1(){
	shouldSubmit=true;
	if (validateFirstName()==false){shouldSubmit=false;}
	if (validateLastName()==false){shouldSubmit=false;}
	if (validateSignupEmail()==false){shouldSubmit=false;}
	if (validatePassword()==false) {shouldSubmit=false;}
	if (validateConfirmPassword()==false) {shouldSubmit=false;}
	

    return shouldSubmit;
}

//==========================================
//validate group creation form	
//==========================================
function validateGroupName(){
	var elementToValidate=$j('input#group_name');	
	var valueToValidate=elementToValidate.val();
	
	// rules for groupname here - blank, length less than 50, greater than 2
	if ( (isBlank(valueToValidate)) ||  (valueToValidate.length < 2) ||  (valueToValidate.length > 50) ){
		 handleInvalidValueFor(elementToValidate, "Please enter a name between 2-50 characters");
		return false;	   
	}else{
		handleValidValueFor(elementToValidate);
		return true;
	}
}	

function validateGroupDescription(){	
	var elementToValidate1=$j('textarea#group_description');	
	return validateNotEmpty(elementToValidate1);	
}


function validateGroupCreate(){
	shouldSubmit=true;
	if (validateGroupName()==false){shouldSubmit=false;}	
	if (validateGroupDescription()==false){shouldSubmit=false;}
	
	
	  
	if (shouldSubmit==true){
		$j('#group_form').submit();
	}
}

/// This scripts call groups/new  "?" click
function handleClickNotificationsHelpShow(){	
	$j('#notifications_container').dialog({ 
	            width:425, 
	            height:135,
	            dialogClass: 'noTitleStuff',
	            show: 'fade', 
	            hide: 'puff'});
   }
  
function handleClickNotificationsHelpHide(){
	$j('#notifications_container').dialog('close');
   }
   
   
//==========================================
//validation utilities	
//==========================================

function addValidationMessageToElement(elementToValidate, message, isValid){
	// accept a jquery element, text message, and boolean as to whether it is valid
	// THIS IS WHERE YOU CAN CUSTOMIZE WHAT WE DO WHEN MESSAGING DURING VALIDATION
	var messageID=elementToValidate.attr('id') + "_validation_message";
	var newElementString;
	// if we have an element already, just remove it
	if ($j('#'+messageID).length > 0){
			$j('#'+messageID).remove();
	}

	if (isValid==1){
		// we are valid - customize message here
			newElementString='<span id='+messageID+' class="directions bold_font" style="color:green"> :)</span>';
		// maybe we will do something more about this later
	}else{
		//we are invalid - customize here
			newElementString ='<span id='+messageID+' class="directions bold_font" style="color:red"> :( '+message+'</span>';
		// maybe we will do something about this later		
	}
	


	$j(newElementString).insertAfter(elementToValidate);




}

function validateNotEmpty(elementToValidate){

	if (isBlank(elementToValidate.val()) ){
		 handleInvalidValueFor(elementToValidate, "Please enter something here");
		return false;	   
	}else{
		handleValidValueFor(elementToValidate, "");
		return true;
	}	
}	

function validateIsEmail(elementToValidate){
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

	
	if( isBlank(elementToValidate.val()) ||  !emailReg.test(elementToValidate.val())  ){
		
		 handleInvalidValueFor(elementToValidate, "That does not look like an email");
		return false;
	   
	}else{
		 handleValidValueFor(elementToValidate, "");
		return true;
	}	
}	

function handleInvalidValueFor(elementToValidate, message){
	// message is tramp data, refactor


	if (elementToValidate.hasClass('success')){
		elementToValidate.removeClass('success');
	}
	elementToValidate.addClass('error');
	addValidationMessageToElement(elementToValidate, message, 0);
		
}
function handleValidValueFor(elementToValidate){
	var messageID=elementToValidate.attr('id') + "_validation_message";
	
	// if we have an element already, just remove it
	if ($j('#'+messageID).length > 0){
			$j('#'+messageID).remove();
	}

		if (elementToValidate.hasClass('error')){
			elementToValidate.removeClass('error');
		}
		elementToValidate.addClass('success');
	addValidationMessageToElement(elementToValidate, "", 1);		
}

function isBlank(valueToValidate){
	//alert(valueToValidate)
	if ( (valueToValidate==" ") || (valueToValidate=="") || (valueToValidate==undefined) ){
		return true;
	}else{
		return false;
	}
}


//==========================================
/*group deletion*/	
//==========================================

function showDeleteGroupDialog(){	
	$j('#group_edit_delete_dialog').dialog({
	            width:320, 
	            height:95,
	            modal: true, 
	            resizeable:false,
	            dialogClass: 'noTitleStuff',
	            show: 'fade', 
	            hide: 'puff'});
}	

function handleClickGroupDeleteCancelNo(){
	$j('#group_edit_cancel_dialog').dialog('close');

}
function handleClickGroupDeleteCancelYes(group_id){
	location.href='/groups/destroy/'+group_id;
}

/*group edit cancel*/
function showCancelGroupEditDialog(){
	$j('#group_edit_cancel_dialog').dialog({
	            width:320, 
	            height:110,
	            modal: true, 
	            resizeable:false,
	            dialogClass: 'noTitleStuff',
	            show: 'fade', 
	            hide: 'puff'});
	
}	

function handleClickGroupEditCancelNo(){
	$j('#group_edit_cancel_dialog').dialog('close');
	
}
function handleClickGroupEditCancelYes(){
	history.back(1);
	//location.href="/groups/";
}



//==========================================
//signup scripts
//==========================================

function validateVanity(){
    var tag_to_check;
    
	if ($j("#profile").length>0){

		tag_to_check=$j('#user_vanity_tag');
	}else{
		tag_to_check=$j('#group_vanity_attributes_tag');
	}		


	$j.get('/vanities/check_availability.js?value_to_check='+tag_to_check.val());
		
	
}

	
/*signup*/	
function handleVanityValidationResult(is_valid){
	
	var validateNotEmpty;
	if ($j("#profile")){
		inputElement=$j('#user_vanity_attributes_tag');
	}else{
		inputElement=$j('#group_vanity_tag');
	}	
	var validationMessage=$j('#validation_vanity');
	
	if (is_valid){
		// check for error class name and remove
		if (inputElement.hasClass('validation_error')){
			inputElement.removeClass('validation_error');
		}
		// add success classs
		inputElement.addClass('validation_success');
		
		
			if (validationMessage.hasClass('validation_error')){
				validationMessage.removeClass('validation_error');
			}
		
		validationMessage.html("Hey, that is a good one!");
		validationMessage.addClass('validation_success');
		
	}else{
		
		//check for valid classname and remove
		if (inputElement.hasClass('validation_success')){
			inputElement.removeClass('validation_success');
		}

		//add error class
		$j('#group_vanity_tag').addClass('validation_error');
		
		
			
				if (validationMessage.hasClass('validation_success')){
					validationMessage.removeClass('validation_success');
				}

			validationMessage.html("someone is using that url, keep trying.");
			validationMessage.addClass('validation_error');
		
		
		
	}
	
}


function handleClickCancelSignUp(){
	
	$j('#signup_container').dialog('close');
}

	//$j('.ui-dialog .signup_content').html(the_partial);

function handleSubmitTopLogin(){
	$j('#user_signin').submit();
}

function pullUpRegistrationDialog(){
	// this needs to open dialog
	// next steps wil replace content
	
		$j.get('/users/sign_up.js');
	
	
}

function goToSignupStep2() {
    $j.post('/registrations/step_2.js');
}


function handleClickSignUpFacebook(){
	// hide everyting else
	hideAllSignUpDivs();

	makeVisible('signup_container');

}

function handleClickSignUpEmail(){
		//hideAllSignUpDivs();

		$j.get('/users/sign_up.js');

}


	function handleClickSignUpTwitter(){

		//popup a window here with a function call

		hideAllSignUpDivs();
		makeVisible('twitter_signup_container_1');
	}



	function hideAllSignUpDivs(){

		// hide default
		if ($j('#default_container').length > 0){
			makeInvisible('default_container');
		}

		// hide facebook
		makeInvisible('signup_container');


	}
//==========================================
// end signup scripts
//==========================================