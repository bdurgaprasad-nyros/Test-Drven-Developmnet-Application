// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function navigateTo(goTo){
	//If inside an Iframe, navigate by changing the iframe's src attribute
	//Works around a safari 2 bug
	/*if (window.frameElement){
		
		var errorOnFrame = "";
		try{
			window.frameElement.src=goTo;
			return;
		}	catch(ex) {
				errorOnFrame = "Error on 	window.frameElement.src= in  navigateTo w3mg standard utilities " + ex.message;
		}
	} 
	*/
	// if the above blew up try the next
	try{
		location.href=goTo;
	}	catch(ex) {
			throw new Error("Error on  location.href= in  navigateTo w3mg standard utilities " + ex.message + "\nError on frameElement: " + errorOnFrame);
	}

}

//form validaton
function removeValidationHighlight(selector){
	 if ($j(selector).hasClass("error")){
       $j(selector).removeClass("error");

     }
	
}


//=====================================================================================
// -----HIDE SHOW REPLACEMENTS
//=====================================================================================


function toggleVisibility(dom_element) {
	
	dom_element = $(dom_element);
	dom_element.toggleClassName("visible");
	dom_element.toggleClassName("invisible");
	
	if (dom_element.hasClassName("visible")) {
		dom_element.setStyle({display: ""});
	}
	
}

function makeVisible(dom_element) {

	original_param = dom_element;
	
	if (typeof(dom_element) == "string") {
		dom_element = $(dom_element);
	}
	
	if (!dom_element) {

		if (typeof(original_param) == "string") {
			element_name = original_element;		
		} else {
			element_name = "unknown";		
		}
		
		throw new Error("Called make visible on element: " + element_name + " but the element is not on page.");
		
	}
	

	if (dom_element.hasClassName("invisible")){
		dom_element.removeClassName("invisible");
	}else if (dom_element.hasClassName("invisible_but_displayed")){
			dom_element.removeClassName("invisible_but_displayed");
	}
	
	dom_element.addClassName("visible");
	

	
}

function makeInvisible(dom_element) {
	
	original_parameter = dom_element;
	dom_element = $(dom_element);
	if (!dom_element)  {
		throw new Error("Called makeInvisible with dom_element that doesn't exist: " + original_parameter);
	}

	dom_element.removeClassName("visible");
	dom_element.addClassName("invisible");
	
	
}

function makeHiddenOnly(dom_element) {
	
	original_parameter = dom_element;
	dom_element = $(dom_element);
	if (!dom_element)  {
		throw new Error("Called makeHidden with dom_element that doesn't exist: " + original_parameter);
	}

	dom_element.removeClassName("visible");
	dom_element.addClassName("invisible_but_displayed");	
	
}

// END HIDE/SHOW REPLACEMENTS ====================================





function util_form_value(element_id){
	
	var elementDom = $(element_id);
			
	if(!elementDom) {
		throw new Error("Can't find the form element in snippit_form_value with element_id=" + element_id);
	}


	try {
		form_element_value = $F(elementDom);
	} catch(ex) {
		throw new Error("Retrieving the value of element=" + element_id + " via $F doesn't work.  Last time this was due to missing <form> tag");		
	}
	
	return form_element_value;
}

// This function was adapted from FCKEditor to clean out Microsoft Word formatting
// Output: the cleaned string
function UtilCleanWord( html ) {

	var re = /\.MsoNormal/i ;
	if ( !(re.test( html )) ) {
		return html;
	}


	html = html.replace(/<o:p>\s*<\/o:p>/g, '') ;
	html = html.replace(/<o:p>[\s\S]*?<\/o:p>/g, '&nbsp;') ;

	// Remove mso-xxx styles.
	html = html.replace( /\s*mso-[^:]+:[^;"]+;?/gi, '' ) ;

	// Remove margin styles.
	html = html.replace( /\s*MARGIN: 0cm 0cm 0pt\s*;/gi, '' ) ;
	html = html.replace( /\s*MARGIN: 0cm 0cm 0pt\s*"/gi, "\"" ) ;

	html = html.replace( /\s*TEXT-INDENT: 0cm\s*;/gi, '' ) ;
	html = html.replace( /\s*TEXT-INDENT: 0cm\s*"/gi, "\"" ) ;

	html = html.replace( /\s*TEXT-ALIGN: [^\s;]+;?"/gi, "\"" ) ;

	html = html.replace( /\s*PAGE-BREAK-BEFORE: [^\s;]+;?"/gi, "\"" ) ;

	html = html.replace( /\s*FONT-VARIANT: [^\s;]+;?"/gi, "\"" ) ;

	html = html.replace( /\s*tab-stops:[^;"]*;?/gi, '' ) ;
	html = html.replace( /\s*tab-stops:[^"]*/gi, '' ) ;

	// Remove FONT face attributes.
	html = html.replace( /\s*face="[^"]*"/gi, '' ) ;
	html = html.replace( /\s*face=[^ >]*/gi, '' ) ;

	html = html.replace( /\s*FONT-FAMILY:[^;"]*;?/gi, '' ) ;

	// Remove Class attributes
	html = html.replace(/<(\w[^>]*) class=([^ |>]*)([^>]*)/gi, "<$1$3") ;

	// Remove styles.
	html = html.replace( /<(\w[^>]*) style="([^\"]*)"([^>]*)/gi, "<$1$3" ) ;

	// Remove style, meta and link tags
	html = html.replace( /<STYLE[^>]*>[\s\S]*?<\/STYLE[^>]*>/gi, '' ) ;
	html = html.replace( /<(?:META|LINK)[^>]*>\s*/gi, '' ) ;

	// Remove empty styles.
	html =  html.replace( /\s*style="\s*"/gi, '' ) ;

	html = html.replace( /<SPAN\s*[^>]*>\s*&nbsp;\s*<\/SPAN>/gi, '&nbsp;' ) ;

	html = html.replace( /<SPAN\s*[^>]*><\/SPAN>/gi, '' ) ;

	// Remove Lang attributes
	html = html.replace(/<(\w[^>]*) lang=([^ |>]*)([^>]*)/gi, "<$1$3") ;

	html = html.replace( /<SPAN\s*>([\s\S]*?)<\/SPAN>/gi, '$1' ) ;

	html = html.replace( /<FONT\s*>([\s\S]*?)<\/FONT>/gi, '$1' ) ;

	// Remove XML elements and declarations
	html = html.replace(/<\\?\?xml[^>]*>/gi, '' ) ;

	// Remove w: tags with contents.
	html = html.replace( /<w:[^>]*>[\s\S]*?<\/w:[^>]*>/gi, '' ) ;

	// Remove Tags with XML namespace declarations: <o:p><\/o:p>
	html = html.replace(/<\/?\w+:[^>]*>/gi, '' ) ;

	// Remove comments [SF BUG-1481861].
	html = html.replace(/<\!--[\s\S]*?-->/g, '' ) ;

	html = html.replace( /<(U|I|STRIKE)>&nbsp;<\/\1>/g, '&nbsp;' ) ;

	html = html.replace( /<H\d>\s*<\/H\d>/gi, '' ) ;

	// Remove "display:none" tags.
	html = html.replace( /<(\w+)[^>]*\sstyle="[^"]*DISPLAY\s?:\s?none[\s\S]*?<\/\1>/ig, '' ) ;

	// Remove language tags
	html = html.replace( /<(\w[^>]*) language=([^ |>]*)([^>]*)/gi, "<$1$3") ;

	// Remove onmouseover and onmouseout events (from MS Word comments effect)
	html = html.replace( /<(\w[^>]*) onmouseover="([^\"]*)"([^>]*)/gi, "<$1$3") ;
	html = html.replace( /<(\w[^>]*) onmouseout="([^\"]*)"([^>]*)/gi, "<$1$3") ;

	// The original <Hn> tag send from Word is something like this: <Hn style="margin-top:0px;margin-bottom:0px">
	html = html.replace( /<H(\d)([^>]*)>/gi, '<h$1>' ) ;

	// Word likes to insert extra <font> tags, when using MSIE. (Wierd).
	html = html.replace( /<(H\d)><FONT[^>]*>([\s\S]*?)<\/FONT><\/\1>/gi, '<$1>$2<\/$1>' );
	html = html.replace( /<(H\d)><EM>([\s\S]*?)<\/EM><\/\1>/gi, '<$1>$2<\/$1>' );

	return html ;
}
// COMMUNICATING WITH USER




function hideStatusUpdate(){
	$j('#status_update_container').text("")
	setTimeout ( function(){makeInvisible('status_update_container');},500 );
	//setTimeout ( function(){makeInvisible('status_update_container');},500 );
}


//updates the flash container in the main page, hides the update div (and maybe modalbox)
function reportActionResult(msg,polarity){
	
		//hideStatusUpdate();
	
		flash_container_dom = $('flash_notice_container');
		if (!flash_container_dom) {
			throw new Error("Called reportActionResult and the 'flash_notice_container' was not found on page. Line 249 in standard utilities.js");
		}
		//resets
		if (flash_container_dom.hasClassName('success') && ((polarity !='success') )|| (polarity !='positive')  ){
			flash_container_dom.removeClassName('success');
		}
		if (flash_container_dom.hasClassName('error') && (polarity != 'error')){

			flash_container_dom.removeClassName('error');
		}
		if (flash_container_dom.hasClassName('notice') && (polarity != 'neutral')){
	
			flash_container_dom.removeClassName('notice');
		}
		
	   // set msg
		flash_container_dom.innerHTML=msg;
		
		// color it	
		switch(polarity){
			case 'positive':
				if (!flash_container_dom.hasClassName('success')){
						flash_container_dom.addClassName('success');
				}
				break;
				case 'success':
					if (!flash_container_dom.hasClassName('success')){
							flash_container_dom.addClassName('success');
					}
					break;	
			case 'negative':
				if (!flash_container_dom.hasClassName('error')){
						flash_container_dom.addClassName('error');
				}
				break;
			default:	
				if (!flash_container_dom.hasClassName('notice')){
						flash_container_dom.addClassName('notice');
				}
				break;
		}
		// visibility
		if (flash_container_dom.hasClassName('invisible')){
  
			makeVisible('flash_notice_container');

		}
		//hide conditions -don't fade if this is an indicator of saving
		if ((polarity=="neutral") ||(polarity=="notice")){ 
			return; 
			
		}else{
		    
			setTimeout(fadeFlash, 3000);		
 		}
}


fadeFlash = function(){

	new Effect.Opacity($('flash_notice_container'), {
				from: 1.0,
				to: 0.0,
				duration: 1.0,
					afterFinish: function(){
						resetFlash();
						
					}
			});

};


resetFlash = function(){
	
	var flash_container_dom=$('flash_notice_container')
	
	flash_container_dom.innerHTML="";
	
	if (flash_container_dom.hasClassName('success')){
		flash_container_dom.removeClassName('success');
	}
	
	if (flash_container_dom.hasClassName('error')){		
		flash_container_dom.removeClassName('error');
	}
	
	
	if (flash_container_dom.hasClassName('notice')){		
		flash_container_dom.removeClassName('notice');
	}
	
	
	makeInvisible('flash_notice_container');

	
};


function showDebug(text){	
	$('debugger').innerHTML=text;	
			}

function showActionIndicator(msg){reportActionResult(msg, 'notice');}
