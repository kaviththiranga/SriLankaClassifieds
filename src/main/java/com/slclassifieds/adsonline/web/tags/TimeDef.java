package com.slclassifieds.adsonline.web.tags;

import java.util.Date;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang.time.DurationFormatUtils;

public class TimeDef extends SimpleTagSupport {
    private Date createdOn;

    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut();
        
        String datetime = DurationFormatUtils.formatDurationWords
        									((new Date().getTime() - createdOn.getTime())
        												, true, true);
        try {
           
            out.write(datetime);

        } catch (java.io.IOException ex) {
            throw new JspException("Error in TimeDef tag", ex);
        }
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }
}
