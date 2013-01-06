package com.slclassifieds.adsonline.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.slclassifieds.adsonline.model.UploadedImage;

@Controller
public class ImageController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value="/ads/uploadImage", method=RequestMethod.POST)
	public @ResponseBody List<UploadedImage> upload(
			@RequestParam("file") MultipartFile file, HttpServletRequest req) {
		
		List<UploadedImage> uploadedFiles = new ArrayList<UploadedImage>();
		UploadedImage u = new UploadedImage();
		u.setName(file.getOriginalFilename());
		u.setUrl("/resources/images/uploaded/"+u.getName());

		uploadedFiles.add(u);
		return uploadedFiles;
	}

}
