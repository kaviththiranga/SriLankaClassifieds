package com.slclassifieds.adsonline.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Image;

@Controller
public class ImageController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value="/ads/uploadImage", method=RequestMethod.POST)
	public @ResponseBody List<Image> upload(@RequestParam("files[]") MultipartFile[] imgs){
		
		List<Image> uploadedFiles = new ArrayList<Image>();
		Image u = new Image();
		u.setName("dfdfdf");
		u.setThumbnail_url("sdffdfdfdfdfd");
		uploadedFiles.add(u);
		logger.info(imgs[0].getOriginalFilename());
		try{
		       
	        File file ;
	        int maxFileSize = 5000 * 1024;
	        int maxMemSize = 5000 * 1024;
	        String filePath = "d:\\temp\\";
	      
	        
	          DiskFileItemFactory factory = new DiskFileItemFactory();
	          factory.setSizeThreshold(maxMemSize);   
	          factory.setRepository(new File(filePath));
	          
	          ServletFileUpload upload = new  ServletFileUpload(factory);
	          upload.setSizeMax(maxFileSize);

	             for (int i=0;i<imgs.length;i++){
	            	 MultipartFile fi =  imgs[i];
	                                                
                     file = new File( filePath + fi.getOriginalFilename()) ;
                     System.out.println(file.getName()); 
                  
	                  fi.transferTo(file);
	             }
	       
	    }catch (Exception ex) {logger.info(ex.getMessage());}
		return uploadedFiles;
	}
	

	@RequestMapping(value="/ads/uploadImage", method=RequestMethod.GET)
	public @ResponseBody List<Image> upload2(HttpServletRequest request) {
		
		List<Image> uploadedFiles = new ArrayList<Image>();
		Image u = new Image();
		/*	
		logger.info(files[0].getOriginalFilename());
		logger.info(files[1].getOriginalFilename());*/
		return uploadedFiles;
	}

}
