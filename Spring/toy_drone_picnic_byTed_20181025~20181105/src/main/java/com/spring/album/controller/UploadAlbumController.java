package com.spring.album.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.common.upload.MediaUtils;
import com.spring.common.upload.UploadFileUtils;

@Controller
@RequestMapping("/album/*")
public class UploadAlbumController {
	
	@Resource(name="uploadPath_album")
	private String uploadPath;
	private static final Logger logger = LoggerFactory.getLogger(UploadAlbumController.class);
	public String trim_originalName(String originalName) {
		String originalName_trim = originalName.replaceAll(" " , "_");
		originalName_trim = originalName_trim.replaceAll("\\p{Z}", "");
		return originalName_trim;
	}
/*-------------------------*/			
/*   uploadForm(get/post)  */			
/*-------------------------*/			
	@RequestMapping(value = "/uploadForm", method = RequestMethod.GET)
	public void uploadForm() {		
		logger.info("uploadForm----GET-------");		
	}
	
	@RequestMapping(value = "/uploadForm", method = RequestMethod.POST)
	public ResponseEntity<String> uploadForm(MultipartFile file) throws Exception {		
		logger.info("uploadForm----POST-------");		   
		logger.info("contentType: " + file.getContentType());
		logger.info("size: " + file.getSize());
		logger.info("originalName_trim : " +trim_originalName(file.getOriginalFilename()));
		
		return new ResponseEntity<String>(
				UploadFileUtils.uploadFile(uploadPath,
						trim_originalName(file.getOriginalFilename()), //originalName, 
						file.getBytes() // fileData
				),
				HttpStatus.CREATED);
	}
	
/*-------------------------*/			
/*   uploadAjax(get/post)  */			
/*-------------------------*/	
	@RequestMapping(value = "/uploadAjax", method = RequestMethod.GET)
	public void uploadAjax() {
			logger.info("uploadAjax----GET-------");
	}

	@RequestMapping(value = "/uploadAjax", method = RequestMethod.POST,	produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {		
		logger.info("uploadAjax----POST-------");		
	    return 
    		new ResponseEntity<String>(
    				UploadFileUtils.uploadFile(uploadPath,
    						trim_originalName(file.getOriginalFilename()), //originalName, 
    						file.getBytes() // fileData
    				),HttpStatus.CREATED);
	}
	
/*---------------*/			
/*   displayFile */			
/*---------------*/
	  @ResponseBody
	  @RequestMapping("/displayFile")
	  public ResponseEntity<byte[]>  displayFile(String fileName)throws Exception{
	    
	    InputStream in = null; 
	    ResponseEntity<byte[]> entity = null;
	    
	    logger.info("FILE NAME= " + fileName);
	    
	    try{
	      logger.info("check");
	      String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
	      MediaType mType = MediaUtils.getMediaType(formatName);
	      System.out.println("=mType=" + mType);

	      HttpHeaders headers = new HttpHeaders();
	      in = new FileInputStream(uploadPath+fileName);
	      	      
	      if(mType != null){
	        headers.setContentType(mType);
	      }else{      
	        fileName = fileName.substring(fileName.indexOf("_")+1);       
	        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	        headers.add("Content-Disposition", "attachment; filename=\""+ 
	          new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
	      }
	      entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), 
	    		  headers, 
	    		  HttpStatus.CREATED);
    	}catch(Exception e){
    		e.printStackTrace();
    		entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
	    }finally{
	      in.close();
	    }
	      return entity;    
	  }
	 
	  
/*---------------*/			
/*   deleteFile  */			
/*---------------*/
	  @ResponseBody
	  @RequestMapping(value="/deleteFile", method=RequestMethod.POST)
	  public ResponseEntity<String> deleteFile(String fileName)throws Exception{
		  logger.info("deleteFile, fileName=" + fileName);	  
	      String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
	      MediaType mType = MediaUtils.getMediaType(formatName);
	      if(mType != null){
	        String front = fileName.substring(0,12);
	        String end = fileName.substring(14);
	        new File(uploadPath + (front + end).replace('/',  File.separatorChar)).delete(); //original file
	      }
	      new File(uploadPath + fileName.replace('/', File.separatorChar)).delete(); //thumbnail file	      
    	  return new ResponseEntity<String>("deleted", HttpStatus.OK);		  
	  }
	  
	  @ResponseBody
	  @RequestMapping(value="/deleteAllFiles", method=RequestMethod.POST)
	  public ResponseEntity<String> deleteFile(@RequestParam("files[]") String[] files){		  
		  logger.info("delete All Files" + files);
		  if (files == null || files.length == 0) {
			  return new ResponseEntity<String>("deleted", HttpStatus.OK);		  
		  }
		  for (String fileName : files) {
			  String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			  MediaType mType = MediaUtils.getMediaType(formatName);
			  
		      if(mType != null){
		        String front = fileName.substring(0,12);
		        String end = fileName.substring(14);
		        new File(uploadPath + (front + end).replace('/',  File.separatorChar)).delete(); //original file
		      }
		      new File(uploadPath + fileName.replace('/', File.separatorChar)).delete(); //thumbnail file
		  }
    	  return new ResponseEntity<String>("deleted", HttpStatus.OK);
	  }	  

}
