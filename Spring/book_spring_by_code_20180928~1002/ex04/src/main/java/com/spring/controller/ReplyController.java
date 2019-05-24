package com.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.domain.Criteria;
import com.spring.domain.PageMaker;
import com.spring.domain.ReplyVO;
import com.spring.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Inject
	private ReplyService service;
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public ResponseEntity<String> registerGET(@RequestBody ReplyVO vo){
		logger.info("registerGET================");
		ResponseEntity<String> entity = null;
		try {
			service.addReply(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		};
		return entity;
	}
	

	  @RequestMapping(value = "/all/{bno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") int bno){
		logger.info("ResponseEntity================");
		ResponseEntity< List<ReplyVO>> entity = null;
		try {

			entity = new ResponseEntity<List<ReplyVO>>(service.listReply(bno), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReplyVO>>(HttpStatus.BAD_REQUEST);
		};
		return entity;
	}

	  @RequestMapping(value = "/{rno}",
			  method = {RequestMethod.PUT, RequestMethod.PATCH })
	  public ResponseEntity<String>update(
			  @PathVariable("rno") int rno,
			  @RequestBody ReplyVO vo){
		  logger.info("update================");
		  ResponseEntity<String> entity = null;
		  try {
			  vo.setRno(rno);
			  service.modifyReply(vo);
			  entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		  } catch (Exception e) {
			  e.printStackTrace();
			  entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		  };
		  return entity;
	  }
	  
	  @RequestMapping(value = "/{rno}",
			  method = {RequestMethod.DELETE})
	  public ResponseEntity<String>remove(
			  @PathVariable("rno") int rno){
		  logger.info("remove================");
		  ResponseEntity<String> entity = null;
		  try {
			  service.removeReply(rno);
			  entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		  } catch (Exception e) {
			  e.printStackTrace();
			  entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		  };
		  return entity;
	  }
	  
	  @RequestMapping(value = "/{bno}/{page}",
			  method = {RequestMethod.GET})
	  public ResponseEntity<Map<String, Object>> listPage(
			  @PathVariable("bno") int bno,
			  @PathVariable("page") int page
			  ){
		  logger.info("listPage================");
		    ResponseEntity<Map<String, Object>> entity = null;
		  
		  try {
			  Criteria cri = new Criteria();
			  logger.info("cri.toString()=" + cri.toString());
			  cri.setPage(page);//page √ ±‚»≠
			  
			  PageMaker pageMaker = new PageMaker();
			  pageMaker.setCri(cri); //page, perPageNum
			  logger.info("pageMaker.toString()=" + pageMaker.toString());
			  
			  Map<String, Object> map = new HashMap<String, Object>();
			  List<ReplyVO> list = service.listReplyPage(bno, cri);
			  map.put("list", list);
			  
			  int replyCount = service.count(bno);
			  pageMaker.setTotalCount(replyCount);
			  map.put("pageMaker",  pageMaker);
			  
			  entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		  } catch (Exception e) {
			  e.printStackTrace();
			  entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		  };
		  return entity;
	  }
	  
}