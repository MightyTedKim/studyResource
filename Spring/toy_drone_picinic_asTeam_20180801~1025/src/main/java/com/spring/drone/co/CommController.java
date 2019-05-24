package com.spring.drone.co;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.drone.so.SomoimDAOService;
import com.spring.drone.so.SomoimVO;

@Controller
public class CommController {
	
	@Autowired
	private CommDAOService commDAOService;
	
	@Autowired
	private SomoimDAOService somoimDAOService;
	
	@RequestMapping("/main.co")
	public ModelAndView manager_main(SomoimVO somoimVO, AlbumPaginationVO albumPaginationVO) {
		ModelAndView result = new ModelAndView();
		ArrayList<SomoimVO> sixSoList = somoimDAOService.getSixSoList();
		result.addObject("sixSoList", sixSoList);
		
		ArrayList<AlbumVO> albumList = new ArrayList<AlbumVO>();
		albumList = commDAOService.getAlbumList(albumPaginationVO);
		result.addObject("albumList", albumList);
		
		ArrayList<AuctionVO> auctionList = new ArrayList<AuctionVO>();
		auctionList = commDAOService.getAuctionList();
		result.addObject("auctionList", auctionList);
		
		result.setViewName("comm/main");
		System.out.println("albumList = " + albumList);
		return result;

	}
	
	@ResponseBody
    @RequestMapping(value="/album_upload.co", method=RequestMethod.POST, produces = "application/json; charset=UTF-8")
    public Map<String, Object> album_upload(
    		AlbumVO albumVO,  
    		@RequestParam(value = "title", required = false) String title, 
    		@RequestParam(value = "id", required = false) String id, 
    		@RequestParam(value = "nickname", required = false) String nickname, 
    		@RequestParam(value = "body", required = false) String body, 
    		@RequestParam(value = "category", required = false) String category,
    		@RequestParam(value = "coor", required = false) String coor,
    		@RequestParam(value = "tag", required = false) String tag, 
    		@RequestParam("files")List<MultipartFile> images) throws IllegalStateException, IOException {
        Map<String, Object> retVal = new HashMap<String, Object>();
        System.out.println("카테고리 : " + albumVO.getCategory());
        String uploadPath = "C:\\BigDeep\\upload\\album\\";
        
    	long sizeSum = 0;
    	
    	String storedFileNameCollection = "";
    	String originalNameCollection = "";
    	String fileSizeCollection = "";
    	
    	System.out.println("제목 : " + albumVO.getTitle());
    	System.out.println("바디 : " + albumVO.getBody());
        
        for(MultipartFile image : images) {
            String originalName = image.getOriginalFilename();
            System.out.println("originalName : " + originalName);
            
            if(!isValidExtension(originalName)){
            	System.out.println(isValidExtension(originalName));
                retVal.put("res", -1);
            	return retVal;
            }
            
            sizeSum += image.getSize();
            if(sizeSum >= 10048576) {
            	retVal.put("res", -2);
            	return retVal;
            }

            String originalFileExtension = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf("."));
            String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") +
    				originalFileExtension;
            
            String StringFileSize = null;
            
            if(image.getSize() != 0) {
            	System.out.println(uploadPath+storedFileName);
            	image.transferTo(new File(uploadPath+storedFileName));
    			storedFileNameCollection += storedFileName + "///";
    			originalNameCollection += originalName +"///";
    			StringFileSize = String.valueOf(image.getSize());
    			fileSizeCollection += StringFileSize + "///";
    			System.out.println(fileSizeCollection);
    		}
        }
        int count = commDAOService.getAlbumCount() + 1;
        albumVO.setNum(count);
        albumVO.setPname("팬텀4");
        albumVO.setReadcount(0);
        albumVO.setLikecount(0);
        albumVO.setUploadPath(uploadPath);
        albumVO.setStoredFileName(storedFileNameCollection);
        albumVO.setOriginalName(originalNameCollection);
        albumVO.setFilesize(fileSizeCollection);
        commDAOService.insertAlbum(albumVO);
        
        retVal.put("res", count);
    	return retVal;
    }
	
	 //앨범 리스트
		@RequestMapping("/co_p.co")
		public ModelAndView count(Locale locale, Model model, HttpServletRequest request) {
		//public ModelAndView co_p(){
			
			ArrayList<AlbumVO> albumList = new ArrayList<AlbumVO>();
			AlbumPaginationVO albumPaginationVO = new AlbumPaginationVO();
			
			ModelAndView result = new ModelAndView();
			
			int pageSize = 9;
			albumPaginationVO.setPageSize(pageSize);

			String pageNum1 = request.getParameter("pageNum");

			if (pageNum1 == null)
				pageNum1 = "1";

			int pageNum = Integer.parseInt(pageNum1);
			albumPaginationVO.setPageNum(pageNum);

			int currentPage = pageNum;
			albumPaginationVO.setCurrentPage(currentPage);

			int startRow = (currentPage - 1) * pageSize + 1;
			albumPaginationVO.setStartRow(startRow);

			int endRow = startRow + pageSize - 1;
			albumPaginationVO.setEndRow(endRow);

			int count = commDAOService.getAlbumCount();
			albumPaginationVO.setCount(count);

			int number = count - (currentPage - 1) * pageSize;
			
			albumPaginationVO.setNumber(number);

			if (count < startRow) {
				currentPage = currentPage - 1;
				startRow = (currentPage - 1) * pageSize + 1;
				endRow = startRow + pageSize - 1;
			}
			if (count > 0) {
				albumList = commDAOService.getAlbumList(albumPaginationVO);
			}
			
			
			result.addObject("albumPaginationVO", albumPaginationVO);
			result.addObject("albumList", albumList);
			result.setViewName("comm/co_p");
			
			return result;
		}

		//앨범디테일	
		@RequestMapping("/co_p_view.co")
		public ModelAndView co_p_view(Model model, AlbumVO albumVO, AlbumPaginationVO albumPaginationVO){
			ModelAndView result = new ModelAndView();
			
			int num = albumVO.getNum();
			int readcount = albumVO.getReadcount() + 1;
			
			int pageNum = albumPaginationVO.getPageNum();
			int number = albumPaginationVO.getNumber();
			
			albumVO.setReadcount(readcount);
			albumPaginationVO.setPageNum(pageNum);
			albumPaginationVO.setNumber(number);
			
			commDAOService.addReadcount(num, readcount);
			//commDAOService.addReadcount(albumVO);
			albumVO = commDAOService.getAlbum(num);
			
			result.addObject("albumVO", albumVO);
			result.addObject("albumPaginationVO", albumPaginationVO);
			
			result.setViewName("comm/co_p_view");
			
			return result;
		}
		
	
	
	@RequestMapping("/co_p_write.co")
	public ModelAndView co_p_write(HttpSession session){
		ModelAndView result = new ModelAndView();
		//ArrayList<AlbumVO> albumList = new ArrayList<AlbumVO>();
		//albumList = albumDAOService.getAlbumList();
		
		//result.addObject("albumList", albumList);
		result.setViewName("comm/co_p_write");
		
		return result;
	}
	
	//사진 검색
    @RequestMapping("/search_Album.co")
    public ModelAndView search_Album(AlbumVO albumVO, HttpServletRequest request){
	     ModelAndView result = new ModelAndView();
	     System.out.println("searchAlbum Controller success1");
	     ArrayList<AlbumVO> searchedAlbumList = new ArrayList<AlbumVO>();
	     searchedAlbumList = commDAOService.searchedAlbumList(albumVO);
	     System.out.println("searchAlbum Controller success2");
	     AlbumPaginationVO albumPaginationVO = new AlbumPaginationVO();
	     ArrayList<AlbumVO> albumList = new ArrayList<AlbumVO>();
	     
     int pageSize = 9;
     albumPaginationVO.setPageSize(pageSize);

     String pageNum1 = request.getParameter("pageNum");

     if (pageNum1 == null)
        pageNum1 = "1";

     int pageNum = Integer.parseInt(pageNum1);
     albumPaginationVO.setPageNum(pageNum);

     int currentPage = pageNum;
     albumPaginationVO.setCurrentPage(currentPage);

     int startRow = (currentPage - 1) * pageSize + 1;
     albumPaginationVO.setStartRow(startRow);

     int endRow = startRow + pageSize - 1;
     albumPaginationVO.setEndRow(endRow);

     int count = commDAOService.getAlbumCount();
     albumPaginationVO.setCount(count);

     int number = count - (currentPage - 1) * pageSize;
     
     albumPaginationVO.setNumber(number);

     if (count < startRow) {
        currentPage = currentPage - 1;
        startRow = (currentPage - 1) * pageSize + 1;
        endRow = startRow + pageSize - 1;
     }
     if (count > 0) {
        albumList = commDAOService.getAlbumList(albumPaginationVO);
     }
     
     
     result.addObject("albumPaginationVO", albumPaginationVO);
     result.addObject("albumList", searchedAlbumList);
     result.setViewName("comm/co_p");
      
      return result;
    }
	
	
	
	@RequestMapping("/co_p_modify_form.co")
	public ModelAndView co_p_modify_form(AlbumVO albumVO){
		ModelAndView result = new ModelAndView();
		int num = albumVO.getNum();
		albumVO = commDAOService.getAlbum(num);
			
		result.addObject("albumVO", albumVO);
		result.setViewName("comm/co_p_modify_form");
		
		return result;
	}
	
	
	@ResponseBody
    @RequestMapping(value="/co_p_modify.co", method=RequestMethod.POST, produces = "application/json; charset=UTF-8")
    public Map<String, Object> co_p_modify(AlbumVO albumVO,  @RequestParam(value = "num", required = false) int num, @RequestParam(value = "title", required = false) String title, @RequestParam(value = "id", required = false) String id, @RequestParam(value = "nickname", required = false) String nickname, @RequestParam(value = "body", required = false) String body, @RequestParam(value = "category", required = false) String category, @RequestParam(value = "storedFileName", required = false) String storedFileName, @RequestParam(value = "originalName", required = false) String originalName, @RequestParam(value = "filesize", required = false) String filesize, @RequestParam(value = "deleteStoredFileName", required = false) String deleteStoredFileName, @RequestParam(value = "deleteOriginalName", required = false) String deleteOriginalName, @RequestParam(value = "deleteFilesize", required = false) String deleteFilesize, @RequestParam("files")List<MultipartFile> images) throws IllegalStateException, IOException {
        Map<String, Object> retVal = new HashMap<String, Object>();
        
        String uploadPath = "C:\\BigDeep\\upload\\album\\";
        String beforeParsing = albumVO.getDeleteStoredFileName();
        String[] fileNames = beforeParsing.split("///");
        for (String x : fileNames) {
        	File file = new File(uploadPath + x);
        	if(file.exists() ){
                if(file.delete()){
                    System.out.println("파일삭제 성공");
                }else{
                    System.out.println("파일삭제 실패");
                }
            }else{
                System.out.println("파일이 존재하지 않습니다.");
            }
        }
                
    	long sizeSum = 0;
    	
    	String pastStoredFileName = albumVO.getStoredFileName();
    	String pastOriginalName = albumVO.getOriginalName();
    	String pastFilesize = albumVO.getFilesize();
    	
    	String storedFileNameCollection = pastStoredFileName;
    	String originalNameCollection = pastOriginalName;
    	String fileSizeCollection = pastFilesize;
    	
    	System.out.println("제목 : " + albumVO.getTitle());
    	System.out.println("바디 : " + albumVO.getBody());
        
        for(MultipartFile image : images) {
            originalName = image.getOriginalFilename();
            System.out.println("originalName : " + originalName);
            
            if(!isValidExtension(originalName)){
            	System.out.println(isValidExtension(originalName));
                retVal.put("res", -1);
            	return retVal;
            }
            
            sizeSum += image.getSize();
            if(sizeSum >= 10048576) {
            	retVal.put("res", -2);
            	return retVal;
            }

            String originalFileExtension = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf("."));
            storedFileName = UUID.randomUUID().toString().replaceAll("-", "") +
    				originalFileExtension;
            
            String StringFileSize = null;
            
            if(image.getSize() != 0) {
            	System.out.println(uploadPath+storedFileName);
            	image.transferTo(new File(uploadPath+storedFileName));
    			storedFileNameCollection += storedFileName + "///";
    			originalNameCollection += originalName +"///";
    			StringFileSize = String.valueOf(image.getSize());
    			fileSizeCollection += StringFileSize + "///";
    			System.out.println(fileSizeCollection);
    		}
        }
        
        albumVO.setStoredFileName(storedFileNameCollection);
        albumVO.setOriginalName(originalNameCollection);
        albumVO.setFilesize(fileSizeCollection);
        int count = commDAOService.modifyAlbum(albumVO);
        if (count != 0) {
        	retVal.put("res", albumVO.getNum());
        }
        else {
        	retVal.put("res", -3);
        }
        
    	return retVal;
    }
	
	
	//앨범삭제
			@RequestMapping("/co_p_delete.co")
			public ModelAndView co_p_delete(AlbumVO albumVO, AlbumPaginationVO albumPaginationVO){
				ModelAndView result = new ModelAndView();

				int num = albumVO.getNum();
				albumVO = commDAOService.getAlbum(num);
				
				int pageNum = albumPaginationVO.getPageNum();
				int number = albumPaginationVO.getNumber();
				albumPaginationVO.setPageNum(pageNum);
				albumPaginationVO.setNumber(number);
				albumVO = commDAOService.getAlbum(num);
				
				String beforeParsing = albumVO.getStoredFileName();
				String uploadPath = albumVO.getUploadPath();
		        String[] fileNames = beforeParsing.split("///");
		        for (String x : fileNames) {
		        	File file = new File(uploadPath + x);
		        	if(file.exists() ){
		                if(file.delete()){
		                    System.out.println("파일삭제 성공");
		                }else{
		                    System.out.println("파일삭제 실패");
		                }
		            }else{
		                System.out.println("파일이 존재하지 않습니다.");
		            }
		        }
		        
		        int res = commDAOService.deleteAlbum(albumVO);
		        if (res == 1) {
		        	ArrayList<AlbumVO> albumList = new ArrayList<AlbumVO>();
		    		albumList = commDAOService.getAlbumList(albumPaginationVO);
		    		
		    		result.addObject("albumList", albumList);
		    		result.addObject("albumPagination, albumPagination");
		    		result.setViewName("comm/co_p");
		        }
		        return result;
		        
			}
	
	
	
	@RequestMapping(value = "/insertAlbumReply.co", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> insertAlbumReply(AlbumVO albumVO, AlbumReplyVO albumReplyVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		albumReplyVO.setRef_num(albumVO.getNum());
		int re_step = albumReplyVO.getRe_step();
		int re_level = albumReplyVO.getRe_level();
		int ref = albumReplyVO.getRef();
		int renum = albumReplyVO.getRenum();
		int count = commDAOService.getAlbumReplyCount() + 1;
		albumReplyVO.setRenum(count);
		if (ref == 0) {
			albumReplyVO.setRef(count);
			albumReplyVO.setRe_step(0);
			albumReplyVO.setRe_level(0);
		}
		else {
			System.out.println("ref : " + ref);
			albumReplyVO.setRef(ref);
			
			int ref_count = commDAOService.getAlbumReplyRefCount(albumReplyVO);
			
			System.out.println("ref_count + 1 : " + (ref_count));
			//commDAOService.updateStepAndLevel(albumReplyVO);
			albumReplyVO.setRe_step(ref_count + 1);
			albumReplyVO.setRe_level(re_level + 1);
		}
		
		try {
		int res = commDAOService.insertAlbumReply(albumReplyVO);
		System.out.println("insert res: " + res);
		retVal.put("res", "OK");
			
			
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	
	@RequestMapping(value = "/deleteAlbumReply.co", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> deleteAlbumReply(AlbumReplyVO albumReplyVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		System.out.println("albumReplyVO.getRenum() : " + albumReplyVO.getRenum());
		try {
			int res = commDAOService.deleteAlbumReply(albumReplyVO);
			if (res != 0) {
				System.out.println("insert res: " + res);
				retVal.put("res", "OK");
			}
			else {
				retVal.put("res", "FAIL");
			}
			
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	
	
	@RequestMapping(value = "/modifyAlbumReply.co", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> modifyAlbumReply(AlbumReplyVO albumReplyVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		System.out.println("albumReplyVO.getRenum() : " + albumReplyVO.getRenum());
		try {
			int res = commDAOService.modifyAlbumReply(albumReplyVO);
			if (res != 0) {
				System.out.println("insert res: " + res);
				retVal.put("res", "OK");
			}
			else {
				retVal.put("res", "FAIL");
			}
			
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	
	@RequestMapping(value = "/getAlbumReplyList.co", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getAlbumReplyList(AlbumReplyVO albumReplyVO, AlbumVO albumVO) {
		List<AlbumReplyVO> list = commDAOService.getAlbumReplyList(albumVO);
		
		String str = "";
		ObjectMapper mapper = new ObjectMapper(); 
		try {
			str = mapper.writeValueAsString(list);
		}

		catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		
		return str;
	}
	
	
	// 옥션
	   
	   // 옥션 글 쓰기
	   @RequestMapping("/auction_write.co")   
	   public ModelAndView auction_write(){
	      ModelAndView result = new ModelAndView();
	      result.setViewName("comm/auction_write");      
	      return result;
	   }
	   
	   // 옥션 리스트
	   @RequestMapping("/auction_list.co")
	   public ModelAndView auction_list(){
	      ModelAndView result = new ModelAndView();
	      ArrayList<AuctionVO> auctionList = new ArrayList<AuctionVO>();
	      auctionList = commDAOService.getAuctionList();
	   
	      result.addObject("auctionList", auctionList);
	      result.setViewName("comm/auction_list");
	      
	      return result;
	   }
	   
	   // 옥션 디테일
	   @RequestMapping("/auction_detail.co")
	   public ModelAndView auction_detail(AuctionVO auctionVO){
	      ModelAndView result = new ModelAndView();
	      int readcount = auctionVO.getReadcount() + 1;
	      auctionVO.setReadcount(readcount);
	      commDAOService.addReadcountauc(auctionVO);
	            
	      int num = auctionVO.getNum();
	      auctionVO = commDAOService.getAuction(num);
	      
	      result.addObject("auctionVO", auctionVO);
	      result.setViewName("comm/auction_detail");
	      
	      return result;
	   }
	   
	   
	   // 옥션이미지 업로드
	   @ResponseBody
	    @RequestMapping(value="/imageupload.co", method=RequestMethod.POST, produces = "application/json; charset=UTF-8")
	    public Map<String, Object> imageupload(AuctionVO auctionVO, @RequestParam(value = "id", required = false) String id, @RequestParam(value = "nickname", required = false) String nickname, @RequestParam(value = "title", required = false) String title, @RequestParam(value = "pname", required = false) String pname, @RequestParam(value = "price", required = false) String price, @RequestParam(value="ph", required = false) String ph, @RequestParam(value="sales", required = false) String sales, @RequestParam(value = "body", required = false) String body, @RequestParam("files")List<MultipartFile> images) throws IllegalStateException, IOException {
	        Map<String, Object> retVal = new HashMap<String, Object>();
	        String uploadPath = "C:\\BigDeep\\upload\\auction\\";
	        
	       long sizeSum = 0;
	       
	       String storedFileNameCollection = "";
	       String originalNameCollection = "";
	       String fileSizeCollection = "";
	       
	       System.out.println("제목 : " + auctionVO.getTitle());
	       System.out.println("바디 : " + auctionVO.getBody());
	        
	        for(MultipartFile image : images) {
	            String originalName = image.getOriginalFilename();
	            System.out.println(originalName);

	            if(!isValidExtension(originalName)){
	               System.out.println(isValidExtension(originalName));
	                retVal.put("res", -1);
	               return retVal;
	            }
	            
	            sizeSum += image.getSize();
	            if(sizeSum >= 10048576) {
	               retVal.put("res", -2);
	               return retVal;
	            }

	            String originalFileExtension = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf("."));
	            String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") +
	                originalFileExtension;
	            
	            String StringfileSize = null;
	            
	            if(image.getSize() != 0) {
	               System.out.println(uploadPath+storedFileName);
	             image.transferTo(new File(uploadPath+storedFileName));
	             storedFileNameCollection += storedFileName + "///";
	             originalNameCollection += originalName +"///";
	             StringfileSize = String.valueOf(image.getSize());
	             fileSizeCollection += StringfileSize + "///";
	             System.out.println(fileSizeCollection);
	          }

	        }
	        int count = commDAOService.getAuctionCount() + 1;
	        System.out.println(count);
	        
	        auctionVO.setNum(count);
	        auctionVO.setReadcount(0);
	        auctionVO.setLikecount(0);
	        auctionVO.setUploadPath(uploadPath);
	        auctionVO.setStoredFileName(storedFileNameCollection);
	        auctionVO.setOriginalName(originalNameCollection);
	        auctionVO.setFileSize(fileSizeCollection);
	        commDAOService.insertAuction(auctionVO);

	        retVal.put("res", count);
	       return retVal;
	    }
	      
	   
	   /*@RequestMapping("/")
	    public String main() {
	        return "index";
	    }*/
	 
	     
	    //required above jdk 1.7 - switch(String)
	    private boolean isValidExtension(String originalName) { 
	        String originalNameExtension = originalName.substring(originalName.lastIndexOf(".")+1);
	        System.out.println(originalNameExtension);
	        if (originalNameExtension.equals("jpg") ||originalNameExtension.equals("png") ||originalNameExtension.equals("gif")||originalNameExtension.equals("jpeg")) {
	            return true;
	        }
	        return false;
	    }
	    
	    
	 // auction 글 수정 폼으로 이동
	    @RequestMapping("/auction_list_modify_form.co")
	    public ModelAndView auction_list_modify_form(AuctionVO auctionVO){
	       ModelAndView result = new ModelAndView();
	       int num = auctionVO.getNum();
	       auctionVO = commDAOService.getAuction(num);
	       
	       result.addObject("auctionVO", auctionVO);
	       result.setViewName("comm/auction_list_modify_form");
	       
	       return result;
	    }
	    
	//@RequestParam(value = "id", required = false) String id, @RequestParam(value = "nickname", required = false) String nickname, @RequestParam(value = "title", required = false) String title, @RequestParam(value = "pname", required = false) String pname, @RequestParam(value = "price", required = false) String price, @RequestParam(value = "body", required = false) String body, @RequestParam(value = "ph", required = false) String ph, @RequestParam(value = "sales", required = false) String sales, @RequestParam(value = "storedFileName", required = false) String storedFileName, @RequestParam(value = "originalName", required = false) String originalName, @RequestParam(value = "filesize", required = false) String filesize, @RequestParam(value = "deleteStoredFileName", required = false) String deleteStoredFileName, @RequestParam(value = "deleteOriginalName", required = false) String deleteOriginalName, @RequestParam(value = "deleteFilesize", required = false) String deleteFilesize, @RequestParam("files")List<MultipartFile> images)    

	 // auction modify
	    @ResponseBody
	    @RequestMapping(value="/auction_list_modify.co", method=RequestMethod.POST, produces = "application/json; charset=UTF-8")
	    public Map<String, Object> auction_list_modify(AuctionVO auctionVO,  @RequestParam(value = "id", required = false) String id, @RequestParam(value = "nickname", required = false) String nickname, @RequestParam(value = "title", required = false) 
	    String title, @RequestParam(value = "pname", required = false) String pname, 
	    @RequestParam(value = "price", required = false) String price, 
	    @RequestParam(value = "body", required = false) String body, 
	    @RequestParam(value = "ph", required = false) String ph, 
	    @RequestParam(value = "sales", required = false) String sales, 
	    @RequestParam(value = "storedFileName", required = false) String storedFileName, 
	    @RequestParam(value = "originalName", required = false) String originalName, 
	    @RequestParam(value = "fileSize", required = false) String fileSize, 
	    @RequestParam(value="deleteFileSize", required = false)String deleteFileSize, 
	    @RequestParam(value = "deleteStoredFileName", required = false) String deleteStoredFileName, 
	    @RequestParam(value = "deleteOriginalName", required = false) String deleteOriginalName, 
	    @RequestParam("files")List<MultipartFile> images) throws IllegalStateException, IOException {
	        Map<String, Object> retVal = new HashMap<String, Object>();
	        
	        String uploadPath = "C:\\BigDeep\\upload\\auction\\";
	        String beforeParsing = auctionVO.getDeleteStoredFileName();
	        String[] fileNames = beforeParsing.split("///");
	        for (String x : fileNames) {
	           File file = new File(uploadPath + x);
	           if(file.exists() ){
	                if(file.delete()){
	                    System.out.println("파일삭제 성공");
	                }else{
	                    System.out.println("파일삭제 실패");
	                }
	            }else{
	                System.out.println("파일이 존재하지 않습니다.");
	            }
	        }
	                
	       long sizeSum = 0;
	       
	       String pastStoredFileName = auctionVO.getStoredFileName();
	       String pastOriginalName = auctionVO.getOriginalName();
	       String pastFilesize = auctionVO.getFileSize();
	       
	       String storedFileNameCollection = pastStoredFileName;
	       String originalNameCollection = pastOriginalName;
	       String fileSizeCollection = pastFilesize;
	       
	       System.out.println("제목 : " + auctionVO.getTitle());
	       System.out.println("바디 : " + auctionVO.getBody());
	        
	        for(MultipartFile image : images) {
	            originalName = image.getOriginalFilename();
	            System.out.println("originalName : " + originalName);
	            
	            if(!isValidExtension(originalName)){
	               System.out.println(isValidExtension(originalName));
	                retVal.put("res", -1);
	               return retVal;
	            }
	            
	            sizeSum += image.getSize();
	            if(sizeSum >= 10048576) {
	               retVal.put("res", -2);
	               return retVal;
	            }

	            String originalFileExtension = image.getOriginalFilename().substring(image.getOriginalFilename().lastIndexOf("."));
	            storedFileName = UUID.randomUUID().toString().replaceAll("-", "") +
	                originalFileExtension;
	            
	            String StringFileSize = null;
	            
	            if(image.getSize() != 0) {
	               System.out.println(uploadPath+storedFileName);
	               image.transferTo(new File(uploadPath+storedFileName));
	             storedFileNameCollection += storedFileName + "///";
	             originalNameCollection += originalName +"///";
	             StringFileSize = String.valueOf(image.getSize());
	             fileSizeCollection += StringFileSize + "///";
	             System.out.println(fileSizeCollection);
	          }
	        }
	        
	        auctionVO.setStoredFileName(storedFileNameCollection);
	        auctionVO.setOriginalName(originalNameCollection);
	        auctionVO.setFileSize(fileSizeCollection);
	        int count = commDAOService.modifyAuction(auctionVO);
	        if (count != 0) {
	           retVal.put("res", auctionVO.getNum());
	        }
	        else {
	           retVal.put("res", -3);
	        }
	        
	       return retVal;
	    }
	    
	    //옥션삭제
	        @RequestMapping("/auction_delete.co")
	        public ModelAndView auction_delete(AuctionVO auctionVO){
	          ModelAndView result = new ModelAndView();

	          int num = auctionVO.getNum();
	          auctionVO = commDAOService.getAuction(num);
	          
	          String beforeParsing = auctionVO.getStoredFileName();
	          String uploadPath = auctionVO.getUploadPath();
	            String[] fileNames = beforeParsing.split("///");
	            for (String x : fileNames) {
	               File file = new File(uploadPath + x);
	               if(file.exists() ){
	                    if(file.delete()){
	                        System.out.println("파일삭제 성공");
	                    }else{
	                        System.out.println("파일삭제 실패");
	                    }
	                }else{
	                    System.out.println("파일이 존재하지 않습니다.");
	                }
	            }
	            
	            int res = commDAOService.deleteAuction(auctionVO);
	            if (res == 1) {
	               ArrayList<AuctionVO> auctionList = new ArrayList<AuctionVO>();
	               auctionList = commDAOService.getAuctionList();
	              
	              result.addObject("auctionList", auctionList);
	              result.setViewName("comm/auction_list");
	            }
	            return result;
	            
	       }
	    
	    
	    // 옥션 댓글 입력
	    @RequestMapping(value = "/insertAuctionReply.co", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	    @ResponseBody
	    public Map<String, Object> insertAuctionReply(AuctionVO auctionVO, AuctionReplyVO auctionReplyVO) {
	       Map<String, Object> retVal = new HashMap<String, Object>();
	       auctionReplyVO.setRef_num(auctionVO.getNum());
	       int re_step = auctionReplyVO.getRe_step();
	       int re_level = auctionReplyVO.getRe_level();
	       int ref = auctionReplyVO.getRef();
	       int renum = auctionReplyVO.getRenum();
	       int count = commDAOService.getAuctionReplyCount() + 1;
	       auctionReplyVO.setRenum(count);
	       if (ref == 0) {
	          auctionReplyVO.setRef(count);
	          auctionReplyVO.setRe_step(0);
	          auctionReplyVO.setRe_level(0);
	       }
	       else {
	          System.out.println("ref : " + ref);
	          auctionReplyVO.setRef(ref);
	          
	          int ref_count = commDAOService.getAuctionReplyRefCount(auctionReplyVO);
	          
	          System.out.println("ref_count + 1 : " + (ref_count));
	          //commDAOService.updateStepAndLevel(albumReplyVO);
	          auctionReplyVO.setRe_step(ref_count + 1);
	          auctionReplyVO.setRe_level(re_level + 1);
	       }
	       
	       
	 /*      우선 글을 쓴다. 1번이다. 1번의 글의 ref는 자기 자신이다. 
	       ref번호를 가진 글이 하나도 없다면 스텝과 레벨은 가만히 둔다. 
	       만약 ref번호를 가진 글이 하나 이상이라면 그 글의 스텝을 하나 올려야 한다.*/
	             
	       
	       try {
	       int res = commDAOService.insertAuctionReply(auctionReplyVO);
	       System.out.println("insert res: " + res);
	       retVal.put("res", "OK");
	          
	          
	       } catch (Exception e) {
	          retVal.put("res", "FAIL");
	          retVal.put("message", "Failure");
	       }
	       return retVal;
	    }
	    
	    // 옥션 댓글 삭제
	    @RequestMapping(value = "/deleteAuctionReply.co", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	    @ResponseBody
	    public Map<String, Object> deleteAuctionReply(AuctionReplyVO auctionReplyVO) {
	       Map<String, Object> retVal = new HashMap<String, Object>();
	       System.out.println("auctionReplyVO.getRenum() : " + auctionReplyVO.getRenum());      
	       try {
	          int res = commDAOService.deleteAuctionReply(auctionReplyVO);
	          if (res != 0) {
	             System.out.println("insert res: " + res);
	             retVal.put("res", "OK");
	          }
	          else {
	             retVal.put("res", "FAIL");
	          }
	          
	       } catch (Exception e) {
	          retVal.put("res", "FAIL");
	          retVal.put("message", "Failure");
	       }
	       return retVal;
	    }
	    
	    // 옥션 댓글 수정
	    @RequestMapping(value = "/modifyAuctionReply.co", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	    @ResponseBody
	    public Map<String, Object> modifyAuctionReply(AuctionReplyVO auctionReplyVO) {
	       Map<String, Object> retVal = new HashMap<String, Object>();
	       System.out.println("auctionReplyVO.getRenum() : " + auctionReplyVO.getRenum());
	       try {
	          int res = commDAOService.modifyAuctionReply(auctionReplyVO);
	          if (res != 0) {
	             System.out.println("insert res: " + res);
	             retVal.put("res", "OK");
	          }
	          else {
	             retVal.put("res", "FAIL");
	          }
	          
	       } catch (Exception e) {
	          retVal.put("res", "FAIL");
	          retVal.put("message", "Failure");
	       }
	       return retVal;
	    }
	    
	    // 옥션 댓글 리스트
	    @RequestMapping(value = "/getAuctionReplyList.co", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	    @ResponseBody
	    public String getAuctionReplyList(AuctionReplyVO auctionReplyVO, AuctionVO auctionVO) {
	       List<AuctionReplyVO> list = commDAOService.getAuctionReplyList(auctionVO);
	       
	       String str = "";
	       ObjectMapper mapper = new ObjectMapper(); 
	       try {
	          str = mapper.writeValueAsString(list);
	       }

	       catch (Exception e) {
	          System.out.println("first() mapper : " + e.getMessage());
	       }
	       
	       return str;
	    }
    
	    
    //좋아요
 	 @RequestMapping(value = "heartCheck.search", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
     @ResponseBody 
     public Map<String, Object> likeCheck(LikeVO likeVO) {
       
        Map<String, Object> retVal = new HashMap<String, Object>();
        
        String likeYn ="";
        likeYn =  commDAOService.likeCheck(likeVO);
        
        retVal.put("likeYn", likeYn);
        return retVal; 
     }
     
     
   
     
     
     //like Update
     @RequestMapping(value = "likeUpdate.search", method = RequestMethod.POST, produces="application/json;charset=UTF-8")
     @ResponseBody 
     public Map<String, Object> likeUpdate(LikeVO likeVO) {
        Map<String, Object> retVal = new HashMap<String, Object>();

        String likeYn ="";

        commDAOService.likeUpdate(likeVO);

        likeYn =  commDAOService.likeCheck(likeVO);
        /*
        System.out.println("updatelikeYn  =  " +likeYn); */
        retVal.put("likeYn", likeYn);
       /* System.out.println("likeYn값" + likeYn);
        System.out.println("retVal값" + retVal);
       */
        return retVal; 
     
     }
     
    
}
