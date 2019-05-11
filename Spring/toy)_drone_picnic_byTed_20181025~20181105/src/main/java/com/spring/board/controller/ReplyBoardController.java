package com.spring.board.controller;

import com.spring.common.tedMethod;

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

import com.spring.board.ReplyVO;
import com.spring.board.service.ReplyService;
import com.spring.common.pagination.Criteria;
import com.spring.common.pagination.PageMaker;

@RestController
@RequestMapping("/replies")
public class ReplyBoardController {
	private static final Logger logger = LoggerFactory.getLogger(ReplyBoardController.class);
	
	@Inject
	private ReplyService service;

//r
    @RequestMapping(value = "/all/{bno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(
			@PathVariable("bno") int bno
			){
		logger.info("list====/all/{bno}-GET========");
		ResponseEntity< List<ReplyVO>> entity = null;
		try {
			entity = new ResponseEntity<List<ReplyVO>>(service.listReply(bno), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReplyVO>>(HttpStatus.BAD_REQUEST);
		};
		return entity;
	}
   
//r
  	@RequestMapping(value="/", method=RequestMethod.POST)
  	public ResponseEntity<String> registerGET(
  			@RequestBody ReplyVO vo
  			){
  		logger.info("replies-POST================");
  		ResponseEntity<String> entity = null;		
  		try {
  			Boolean validationCheck = tedMethod.hasValues(vo.getReplytext() , vo.getReplyer());	
  			logger.info(Boolean.toString(validationCheck));
  			if (validationCheck) { //hasValues = true
	  			service.addReply(vo);
	  			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);  						
  			}else { //hasValues = false
  				entity = new ResponseEntity<String>("EMPTY", HttpStatus.OK);  		
  			}
  		} catch (Exception e) {
  			e.printStackTrace();
  			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
  		};
  		return entity;
  	}
  	
  //r	  
	  @RequestMapping(value = "/{bno}/{page}", method = {RequestMethod.GET})
	  public ResponseEntity<Map<String, Object>> listPage(
			  @PathVariable("bno") int bno, 
			  @PathVariable("page") int page){
		  logger.info("listPage===/{bno}/{page}=============");
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
//u
	  @RequestMapping(value = "/{rno}",method = {RequestMethod.PUT, RequestMethod.PATCH })
	  public ResponseEntity<String>update(
			  @PathVariable("rno") int rno,
			  @RequestBody ReplyVO vo
			  ){
	  logger.info("update======/{rno}==========");
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
//d 
	  @RequestMapping(value = "/{rno}", method = {RequestMethod.DELETE})
	  public ResponseEntity<String>remove(
			  @PathVariable("rno") int rno
			  ){
		  logger.info("remove===/{rno}=============");
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

	  
}