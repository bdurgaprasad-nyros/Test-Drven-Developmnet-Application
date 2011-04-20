module ApplicationHelper

  def current_asset_folder
    return "sticky2_assets"
  end

  def w3_escape_javascript(javascript)
    (javascript || '').gsub('\\','\0\0').gsub('</','<\/').gsub(/\r\n|\n|\r|\xe2\x80\xa8/, "").gsub(/["']/) { |m| "\\#{m}" }
  end
  
  def render_javascript_block(&block)
    
      output= "<script type=\"text/javascript\">  " <<
            " //<![CDATA[   " <<
            " #{ capture(&block)} " <<
            " //]]> " <<
            "</script>"
      output.html_safe
   
   end


    def render_jquery_new_button(label, path, style=nil)

     output=	"<button onclick=\"location.href='#{path}';\" style=\"#{style}\">#{label}</button>"# \n #{js}"
     output.html_safe
    end
    
    def render_mockup_notice(&block)
        output="<!--begin mockup notes--><div class=\"notice ui-corner-all align_center bold\">" <<
          "#{capture(&block)} " <<
          "</div><!--end mockup notes-->"
          output.html_safe
    end  

    def render_indicator_title_and_sequence(title, sequence)
        # takes title, current place in signup sequence
        # outputs the html for title div/indicator as per mockups
        # refactor to make more elegant as needed
        
        step_1_class= (sequence==1) ? "indicator_current" : "indicator"
        step_2_class= (sequence==2) ? "indicator_current" : "indicator"
        step_3_class= (sequence==3) ? "indicator_current" : "indicator"
        
      output= "<!--begin indicator helper-->" <<
            "<div class=\"span-14\">" <<
                	"<div class=\"span-10 bold_font\" style=\"font-size:14px;margin-top:4px\">"<<
                	"	#{title}"<<
                	"</div>	"
                	
      if ["Email"].include?(session[:signup_type])          	
                output <<  "	<div id=\"sequence_indicator\" class=\"span-4 last\">" <<
                  	"	<div class=\"float_right\" style=\"width:85px\">" <<
                    "       <div id=\"sequence_indicator3\" class=\"#{step_3_class}\" >3</div>" <<          
                  	"				<div id=\"sequence_indicator2\" class=\"#{step_2_class}\">2</div>" <<
                  	"				<div id=\"sequence_indicator1\" class=\"#{step_1_class}\">1</div>" <<
                  	"</div>" <<
                  		"</div>"
       end
       
       output << "</div>" <<
       "<hr class=\"space\" />" <<
       "<!--end indicator helper-->"
       
       
      output.html_safe
      
      
    end  

    
    # Bunchball end


    def render_in_rounded_rectangle(&block)

       output="<div class=\"span-20 clearfix\" " <<
       " style=\"height:12px;background-image:url('/images/sticky2_assets/shared/groups_content_top.gif');background-repeat:no-repeat;\">  " <<
       " &nbsp;</div> " <<
       " <div class=\"span-20 clearfix\" " <<
        " style=\"margin-top:-2px;padding:8px;background-image:url(/images/sticky2_assets/shared/groups_content_middle.gif);background-repeat:repeat-y;\">  " <<
       "#{capture(&block)} " <<
        " </div> " <<
        " <div class=\"span-20 clearfix\" " <<
        " style=\"margin-top:-2px;background-image:url(/images/sticky2_assets/shared/groups_content_bottom.gif);background-repeat:no-repeat\">  " <<
        "&nbsp;</div>"
        

      output.html_safe
    end  

    def render_in_rounded_rectangle_level3(&block)

       output="<div class=\"clear\" style=\"margin-left:95px\"><div class=\"span-15 clearfix\" " <<
       " style=\"width:568;height:12px;background-image:url('/images/sticky2_assets/shared/standard_content_top.gif');background-repeat:no-repeat;\">  " <<
       " &nbsp;</div> " <<
       " <div class=\"span-15 clearfix\" " <<
        " style=\"width:568;margin-top:-2px;background-image:url(/images/sticky2_assets/shared/standard_content_middle.gif);background-repeat:repeat-y;\">  " <<
        "<!-- outer margin-->
      	<div class=\"clear\" style=\"width:525px;margin-left:15px\">"<<
       "#{capture(&block)} " <<
       	"	<!--end middle section-->"<<
        "	</div>		"<<
        "	<!-- end outer margin-->"<<
        " </div> " <<
        " <div class=\"span-15 clearfix\" " <<
        " style=\"width:568;margin-top:-2px;background-image:url(/images/sticky2_assets/shared/standard_content_bottom.gif);background-repeat:no-repeat\">  " <<
        "&nbsp;</div></div>"
        

      output.html_safe
    end  
    
    # helpers for PROFILES ##################################
    
    def render_profile_rounded_rectangle(&block)
        
         

       output="<div id=\"profile\"><div class=\"clear\" style=\"margin-left:95px\"><div class=\"span-17 clearfix\" " <<
       " style=\"width:645;height:12px;background-image:url('/images/sticky2_assets/shared/standard_large_content_top.gif');background-repeat:no-repeat;\">  " <<
       " &nbsp;</div> " <<
       " <div class=\"span-17 clearfix\" " <<
        " style=\"width:646;margin-top:-2px;background-image:url(/images/sticky2_assets/shared/standard_large_content_middle.gif);background-repeat:repeat-y;\">  " <<
        "<!-- outer margin-->
      	<div class=\"clear\" style=\"width:613px;margin-left:15px\">"<<
       "#{capture(&block)} " <<
       	"	<!--end middle section-->"<<
        "	</div>		"<<
        "	<!-- end outer margin-->"<<
        " </div> " <<
        " <div class=\"span-17 clearfix\" " <<
        " style=\"width:646;margin-top:-2px;background-image:url(/images/sticky2_assets/shared/standard_large_content_bottom.gif);background-repeat:no-repeat\">  " <<
        "&nbsp;</div></div></div>"
        

      output.html_safe
    end  

  	def render_profile_box(&block)
  	  output="<!--begin outlined rectangle --><div class=\"span-16 clear\" style=\"border:1px solid #999999;margin-bottom:10px;margin-left:6px; width:600px \"> " <<
  	      "#{capture(&block)} " <<
  	      "</div><!--end outlined rectangle-->"
  	        output.html_safe
    end


end
