package com.slclassifieds.adsonline.web.tags;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang.time.DurationFormatUtils;

import com.slclassifieds.adsonline.service.UserService;


public class PrintAd extends SimpleTagSupport {
    private com.slclassifieds.adsonline.model.Advertisement advertisement;
    private boolean summaryMode;


    /**
     * Called by the container to invoke this tag. The implementation of this
     * method is provided by the tag library developer, and handles all tag
     * processing, body iteration, etc.
     */
    @Override
    public void doTag() throws JspException {
    	
        JspWriter out = getJspContext().getOut();
        HttpServletRequest request = (HttpServletRequest ) ((PageContext) getJspContext()).getRequest();
        String root = request.getContextPath();
        
        String imgOneLink = root+advertisement.getImageOne();
        String profileLink=root+"/viewProfile?userId="+advertisement.getUser().getUserId();
        String userName = advertisement.getUser().getUsername();
        String adLink = root+"/ads/viewAd?adId="+ advertisement.getAdId();
        String datetime = DurationFormatUtils.formatDurationWords((new Date().getTime() -advertisement.getCreatedOn().getTime()), true, true);
        int descEnd = (advertisement.getDesc().length()>100)?100:advertisement.getDesc().length();
        String catLink = root+"/ads/viewAdsByCategory?catId="+advertisement.getCategory().getCatId();
        
        try {
           
           out.println("<div class=\"well\"><div class=\"row\">");
           	
	                  
	           out.println("\t\t <div class=\"span3\">");
	           
		           out.println("\t\t\t <a href=\""+imgOneLink+"\" class=\"thumbnail\">");
		           	out.println("\t\t\t\t <img src=\""+imgOneLink+"\" alt=\"\">");
		           out.println("\t\t\t </a>");
		           
	           out.println("\t\t </div>");
	        
	           
	           out.println("\t <div class=\"span8\" >");
	           
		           out.println("<ul class=\"inline\" >");		           
			           	out.println("<li><a href=\""+adLink+"\"><h4>"+advertisement.getTitle()+"   </h4></a></li>");			           	
			           	out.println("<li style=\"font-size:small;\"> Category : <a href=\""+catLink+"\">"+advertisement.getCategory().getCatName()+"</a></li>");
			           	out.println("<li style=\"font-size:small;\">Posted by : <a href=\""+profileLink+"\">"+userName+",</a></li>");
			           	
			           	out.println("<li style=\"font-size:small;\">"+advertisement.getUser().getDistrict()+", "+datetime+" ago</li>");
			       out.println("</ul>");
			       
			       
			       
		           out.println("<p>"+advertisement.getDesc().substring(0, descEnd)+"..."+"<a href=\""+adLink+"\">read more</a>"+"</p>");
		           out.println("<p><a class=\"btn  btn-success btn\" href=\""+adLink+"\">View</a>");
		           
		           if(UserService.isUserLoggedIn())
		           {
		           	out.println("<a class=\"btn btn-primary btn\" href=\""+adLink+"#bid\">Bid</a>");
		           }
		         
		           out.println("<a class=\"btn btn btn-primary disabled\">Rs. "+String.format("%1$,.2f",advertisement.getPrice())+" /- </a>");
		           out.println("</p>"); 
		           out.println("<div style=\"text-align:right;\">");
		           out.println("<p><a href=\""+adLink+"#comments\">"+advertisement.getAllComments().size()+" comments</a>");
		           out.println("| <a href=\""+adLink+"#bids\">"+advertisement.getAllBids().size()+" bids</a></p>");
		           out.println("</div>");
		           
		           //<a class=\"btn btn-info btn-mini\" href=\""+adLink+"\">View</a>
		           //<a class=\"btn btn-large btn-primary disabled\">Rs. "+advertisement.getPrice()+" /- </a>
	           
	           out.println("\t </div>");
             
           out.println("</div></div>");

        } catch (java.io.IOException ex) {
            throw new JspException("Error in PrintAd tag", ex);
        }
    }

    public void setAdvertisement(com.slclassifieds.adsonline.model.Advertisement advertisement) {
        this.advertisement = advertisement;
    }
    
    public void setSummaryMode(boolean summaryMode) {
        this.summaryMode = summaryMode;
    }
    
    
}
