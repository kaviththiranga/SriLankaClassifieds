package com.slclassifieds.adsonline.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.slclassifieds.adsonline.dao.AdvertisementDao;
import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Image;
import com.slclassifieds.adsonline.service.UserService;

@Controller
public class ImageController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private ServletContext context;
	
	@Autowired	
	private AdvertisementDao adDao;
	
	@RequestMapping(value="/ads/uploadImage", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> upload(@RequestParam("files[]") MultipartFile[] imgs){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Image> uploadedFiles = new ArrayList<Image>();
		
		
		try{
		       
	        File file ;
	        int maxFileSize = 5000 * 1024;
	        int maxMemSize = 5000 * 1024;
	        String filePath = context.getInitParameter("image_root");
	      
	        
	          DiskFileItemFactory factory = new DiskFileItemFactory();
	          factory.setSizeThreshold(maxMemSize);   
	          factory.setRepository(new File(filePath));
	          
	          ServletFileUpload upload = new  ServletFileUpload(factory);
	          upload.setSizeMax(maxFileSize);

	             for (int i=0;i<imgs.length;i++){
	            	 MultipartFile fi =  imgs[i];
	            	 
	            	 String ext = fi.getOriginalFilename().split("\\.")[fi.getOriginalFilename().split("\\.").length-1];
	            	 
	            	 
	            	 String fileName;
	            	 String thumbName;
	            	 String thumbPath = filePath+"thumbs/";
	            	 
	            	 if(UserService.isUserLoggedIn()){
	            		 
	            		 fileName =UserService.getCurrentUser().getUsername()+(new Date()).getTime()+"."+ext;
	            		 thumbName = UserService.getCurrentUser().getUsername()+(new Date()).getTime()+"_thumb."+ext;
	            	 }
	            	 else{
	            		 
	            		 fileName = RandomStringUtils.randomAlphanumeric(4)+fi.getOriginalFilename()+(new Date()).getTime()+"."+ext;
	            		 thumbName = RandomStringUtils.randomAlphanumeric(4)+fi.getOriginalFilename()+(new Date()).getTime()+"_thumb."+ext;
	            	 }
	                                                
                     file = new File( filePath + fileName) ;
                     System.out.println(file.getName()); 
                  
	                  fi.transferTo(file);
	                  
	                  // Create a thumbanail
	                  BufferedImage thumb = new BufferedImage(120, 100, BufferedImage.TYPE_INT_RGB);
	                  thumb.createGraphics().drawImage(ImageIO.read(new File(filePath + fileName)).getScaledInstance(120, 100, java.awt.Image.SCALE_SMOOTH),0,0,null);
	                  ImageIO.write(thumb, ext, new File(thumbPath+thumbName));
	                  
	                  Image img = new Image();
	                  img.setName(fileName);
	                  img.setUrl("/images?img="+fileName);
	                  img.setThumbnail_url("/images?img="+"thumbs/"+thumbName);
	                  uploadedFiles.add(img);
	                  adDao.save(img);
	             }
	       
	    }catch (Exception ex) {logger.info(ex.getMessage());}
		map.put("files", uploadedFiles);
		return map;
	}
	

	@RequestMapping(value="/images", method=RequestMethod.GET)
	public void getFile(
		    @RequestParam("img") String fileUrl, 
		    HttpServletResponse response) {
		    try {
		      
		    File image = new File(context.getInitParameter("image_root")+fileUrl);
		      InputStream is = new FileInputStream(image);
		     
		      IOUtils.copy(is, response.getOutputStream());
		      response.flushBuffer();
		    } catch (IOException ex) {
		      logger.info("Error writing file to output stream. Filename was '" + fileUrl + "'");
		      throw new RuntimeException("IOError writing file to output stream");
		    }

	}

}
