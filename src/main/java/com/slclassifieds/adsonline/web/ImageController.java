package com.slclassifieds.adsonline.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
	public @ResponseBody List<Image> upload(
			@RequestParam("files") MultipartFile[] files,HttpServletRequest req) {
		
		List<Image> uploadedFiles = new ArrayList<Image>();
		Image u = new Image();
		
		for (MultipartFile f:files) {
		
			logger.info("File '" + f.getOriginalFilename() + "' uploaded successfully");
		}
		return uploadedFiles;
	}
	
}
