package com.spring.drone.co;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;


public interface CommMapper {
	
	//앨범
		public ArrayList<AlbumVO> getAlbumList(AlbumPaginationVO albumPaginationVO);
		public void saveImage(Map<String, Object> hmap);
		public AlbumVO getAlbum(int num);
		public int getAlbumCount();
		public void insertAlbum(AlbumVO albumVO);
		public int modifyAlbum(AlbumVO albumVO);
		public int deleteAlbum(AlbumVO albumVO);
		public void addReadcount(@Param("num") int num, @Param("readcount") int readcount);
		
	//앨범댓글
	public ArrayList<AlbumReplyVO> getAlbumReplyList(AlbumVO albumVO);
	public int getAlbumReplyCount();
	public void updateStepAndLevel(AlbumReplyVO albumReplyVO);
	public int insertAlbumReply(AlbumReplyVO albumReplyVO);
	public int getAlbumReplyRefCount(AlbumReplyVO albumReplyVO);
	public int deleteAlbumReply(AlbumReplyVO albumReplyVO);
	public int modifyAlbumReply(AlbumReplyVO albumReplyVO);
	
	
	// 옥션
	   public void addReadcountauc(AuctionVO auctionVO);
	   public AuctionVO getAuction(int num);
	   public void insertAuction(AuctionVO auction);
	   public ArrayList<AuctionVO> getAuctionList();
	   public int getAuctionCount();
	   public int deleteAuction(AuctionVO auctionVO);
	   public int modifyAuction(AuctionVO auctionVO);
	   
	    // 옥션댓글
	   public ArrayList<AuctionReplyVO> getAuctionReplyList(AuctionVO auctionVO);
	   public int getAuctionReplyCount();
	   public int insertAuctionReply(AuctionReplyVO auctionReplyVO);
	   public int getAuctionReplyRefCount(AuctionReplyVO auctionReplyVO);
	   public int deleteAuctionReply(AuctionReplyVO auctionReplyVO);
	   public int modifyAuctionReply(AuctionReplyVO auctionReplyVO);
	
	//좋아요
	public ArrayList<LikeVO> getLikeCount(LikeVO likeVO);
	public ArrayList<LikeVO> getLikeData(LikeVO likeVO);
	public void insertLikeData(LikeVO likeVO);
	public void updateLikeData(LikeVO likeVO);
	public void updateTotalLike(LikeVO likeVO);
	
	//사진검색
		public ArrayList<AlbumVO> searchedAlbumList(AlbumVO albumVO);
}
