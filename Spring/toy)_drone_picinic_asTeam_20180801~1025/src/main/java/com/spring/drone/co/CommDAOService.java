package com.spring.drone.co;

import java.util.ArrayList;
import java.util.Map;

public interface CommDAOService {
	
	// 앨범
	public ArrayList<AlbumVO> getAlbumList(AlbumPaginationVO albumPaginationVO);
	public AlbumVO getAlbum(int num);
	public int getAlbumCount();
	public void insertAlbum(AlbumVO albumVO);
	public int modifyAlbum(AlbumVO albumVO);
	public int deleteAlbum(AlbumVO albumVO);
	public void addReadcount(int num, int readcount);
	

		
	
	// 앨범 댓글
	public ArrayList<AlbumReplyVO> getAlbumReplyList(AlbumVO albumVO);
	public int getAlbumReplyCount();
	public void updateStepAndLevel(AlbumReplyVO albumReplyVO);
	public int insertAlbumReply(AlbumReplyVO albumReplyVO);
	public int getAlbumReplyRefCount(AlbumReplyVO albumReplyVO);
	public int deleteAlbumReply(AlbumReplyVO albumReplyVO);
	public int modifyAlbumReply(AlbumReplyVO albumReplyVO);
	

	// 옥션
	   public void insertAuction(AuctionVO auctionVO);
	   public ArrayList<AuctionVO> getAuctionList();
	   public int getAuctionCount();
	   public void addReadcountauc(AuctionVO auctionVO);
	   public AuctionVO getAuction(int num);
	   public int deleteAuction(AuctionVO auctionVO);
	   public int modifyAuction(AuctionVO auctionVO);
	   
	   //옥션 댓글
	   public ArrayList<AuctionReplyVO> getAuctionReplyList(AuctionVO auctionVO);
	   public int getAuctionReplyCount();
	   public int insertAuctionReply(AuctionReplyVO auctionReplyVO);
	   public int getAuctionReplyRefCount(AuctionReplyVO auctionReplyVO);
	   public int deleteAuctionReply(AuctionReplyVO auctionReplyVO);
	   public int modifyAuctionReply(AuctionReplyVO auctionReplyVO);
	
	//좋아요
	public String likeCheck(LikeVO likeVO);
	public String likeUpdate(LikeVO likeVO);
	
	//사진검색
		public ArrayList<AlbumVO> searchedAlbumList(AlbumVO albumVO);
}
