package com.spring.drone.co;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommDAOServiceImpl implements CommDAOService {
	
	@Autowired
	private SqlSession sqlSession;
	
	  // 사진검색
    @Override
    public ArrayList<AlbumVO> searchedAlbumList(AlbumVO albumVO) {
    ArrayList<AlbumVO> searchedAlbumList = new ArrayList<AlbumVO>();
    CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
    searchedAlbumList = commMapper.searchedAlbumList(albumVO);
    return searchedAlbumList;
    }
	
	
 // 앨범
 	@Override
 	public ArrayList<AlbumVO> getAlbumList(AlbumPaginationVO albumPaginationVO) {
 		ArrayList<AlbumVO> albumList = new ArrayList<AlbumVO>();
 		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
 		albumList = commMapper.getAlbumList(albumPaginationVO);
 		return albumList;
 	}



	@Override
	public AlbumVO getAlbum(int num) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		AlbumVO albumVO = commMapper.getAlbum(num);
		return albumVO;
	}
	
	@Override
	public int getAlbumCount() {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		int count = commMapper.getAlbumCount();
		return count;
	}
	
	@Override
	public void insertAlbum(AlbumVO albumVO) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		commMapper.insertAlbum(albumVO);
	}

	@Override
	public int modifyAlbum(AlbumVO albumVO) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		int res = commMapper.modifyAlbum(albumVO);
		return res;
	}


	@Override
	public int deleteAlbum(AlbumVO albumVO) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		int res = commMapper.deleteAlbum(albumVO);
		return res;
	}

	@Override
	public void addReadcount(int num, int readcount) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		commMapper.addReadcount(num, readcount);
		
	}
	
	//앨범댓글
	@Override
	public ArrayList<AlbumReplyVO> getAlbumReplyList(AlbumVO albumVO) {
		ArrayList<AlbumReplyVO> replyList = new ArrayList<AlbumReplyVO>();
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		replyList = commMapper.getAlbumReplyList(albumVO);
		return replyList;
	}

	@Override
	public int getAlbumReplyCount() {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		int count = commMapper.getAlbumReplyCount();
		return count;
	}

	@Override
	public void updateStepAndLevel(AlbumReplyVO albumReplyVO) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		commMapper.updateStepAndLevel(albumReplyVO);
		
	}

	@Override
	public int insertAlbumReply(AlbumReplyVO albumReplyVO) {
		System.out.println(albumReplyVO.getRef());
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		int res = commMapper.insertAlbumReply(albumReplyVO);
		return res;
	}

	@Override
	public int getAlbumReplyRefCount(AlbumReplyVO albumReplyVO) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		int ref_count = commMapper.getAlbumReplyRefCount(albumReplyVO);
		System.out.println("ref_count :  " + ref_count);
		return ref_count;
	}

	@Override
	public int deleteAlbumReply(AlbumReplyVO albumReplyVO) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		int res = commMapper.deleteAlbumReply(albumReplyVO);
		return res;
	}

	@Override
	public int modifyAlbumReply(AlbumReplyVO albumReplyVO) {
		CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
		int res = commMapper.modifyAlbumReply(albumReplyVO);
		return res;
	}


	

	// 옥션
	   @Override
	   public void insertAuction(AuctionVO auctionVO) {
	      
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      commMapper.insertAuction(auctionVO);
	      
	   }
	   

	   @Override
	   public ArrayList<AuctionVO> getAuctionList() {
	      System.out.println(">ComDaoService, getAuctionList");
	      ArrayList<AuctionVO> auctionList = new ArrayList<AuctionVO>();
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      
	      auctionList = commMapper.getAuctionList();
	      return auctionList;
	   }
	   
	   @Override
	   public int getAuctionCount() {
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      int count = commMapper.getAuctionCount();
	      return count;
	   }

	   @Override
	   public void addReadcountauc(AuctionVO auctionVO) {
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      commMapper.addReadcountauc(auctionVO);
	      
	   }

	   @Override
	   public AuctionVO getAuction(int num) {      
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      AuctionVO auctionVO = commMapper.getAuction(num);
	      return auctionVO;
	   
	   }
	      
	   @Override
	   public int deleteAuction(AuctionVO auctionVO) {
	      System.out.println(">CommDAOServiceImpl, auction_delete.co : 들어감" + auctionVO.getTitle());
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      int res = commMapper.deleteAuction(auctionVO);
	      return res;
	   }
	   
	   @Override
	   public int modifyAuction(AuctionVO auctionVO) {
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      int res = commMapper.modifyAuction(auctionVO);
	      return res;
	   }
	   
	   
	   // 옥션 댓글
	   @Override
	   public ArrayList<AuctionReplyVO> getAuctionReplyList(AuctionVO auctionVO) {
	      ArrayList<AuctionReplyVO> replyList = new ArrayList<AuctionReplyVO>();
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      replyList = commMapper.getAuctionReplyList(auctionVO);
	      return replyList;
	   }

	   @Override
	   public int getAuctionReplyCount() {
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      int count = commMapper.getAuctionReplyCount();
	      return count;
	   }


	   @Override
	   public int insertAuctionReply(AuctionReplyVO auctionReplyVO) {
	      System.out.println(auctionReplyVO.getRef());
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      int res = commMapper.insertAuctionReply(auctionReplyVO);
	      return res;
	   }

	   @Override
	   public int getAuctionReplyRefCount(AuctionReplyVO auctionReplyVO) {
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      int ref_count = commMapper.getAuctionReplyRefCount(auctionReplyVO);
	      System.out.println("ref_count :  " + ref_count);
	      return ref_count;
	   }

	   @Override
	   public int deleteAuctionReply(AuctionReplyVO auctionReplyVO) {
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      int res = commMapper.deleteAuctionReply(auctionReplyVO);
	      System.out.println("<ComDaoService, deleteAuctionReply: " + auctionReplyVO);
	      System.out.println("<ComDaoService, deleteAuctionReply.getRenum: " + auctionReplyVO.getRenum());
	      
	      return res;
	   }

	   @Override
	   public int modifyAuctionReply(AuctionReplyVO auctionReplyVO) {
	      CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	      int res = commMapper.modifyAuctionReply(auctionReplyVO);
	      return res;
	   }

	//좋아요
	   @Override
	      public String likeCheck(LikeVO likeVO) {
	         
	        CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	         
	         //라이크정보 불러오기
	         ArrayList<LikeVO> likeCount = commMapper.getLikeCount(likeVO);
	        
	         int likeCheck = 0;
	         String likeYn = "";
	         //get(0) : 어레이리스트안으로가서 0번재 인덱스에있는..
	         likeCheck = likeCount.get(0).getLikeCheck();
	         
	         if(likeCheck == 0) {
	            System.out.println("0일때 들어왔다!");
	            return "N";
	         }
	         else {
	            System.out.println("0이 아닌게 들어왔다!");
	            ArrayList<LikeVO> likeList = commMapper.getLikeData(likeVO);
	           
	            likeYn = likeList.get(0).getLikeYn();
	            
	            return likeYn;
	         }
	         
	      }
	   

	        
	      /*getLikeCount == getLikeStatus            getLikeCheck == getLikeStatus      likeCount ==  */
	      //라이크 업데이트
	      @Override
	      public String likeUpdate(LikeVO likeVO) {
	       
	         CommMapper commMapper = sqlSession.getMapper(CommMapper.class);
	       
	         //라이크정보 불러오기
	         ArrayList<LikeVO> likeCount = commMapper.getLikeCount(likeVO);
	    
	         int likeCheck = 0;
	         String likeYn = "";
	         likeCheck = likeCount.get(0).getLikeCheck();
	       
	         if(likeCheck == 0) {
	           /* System.out.println("0일때 들어왔다!");*/
	            likeVO.setLikeYn("Y");
	            commMapper.insertLikeData(likeVO);
	          
	         }
	         else {
	     /*       System.out.println("0이 아닌게 들어왔다!");*/
	            commMapper.updateLikeData(likeVO);
	         }
	         ArrayList<LikeVO> likeList = commMapper.getLikeData(likeVO);
	         likeYn = likeList.get(0).getLikeYn();
	     
	         /*int planTotalCount = searchmapper.selectLikeCount(likeVO);*/
	         
	         commMapper.updateTotalLike(likeVO);
	         
	         return likeYn;
	         
	      }

	
	
	
}
