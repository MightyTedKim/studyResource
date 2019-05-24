package com.spring.drone.co;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class AuctionVO {
   private int num;
   private String id;
   private   String nickname;
   private String title;
   private String body;
   private String pname;
   private String price;
   private Date pdate; 
   private int readcount;
   private String ph;
   private String sales;
   private int likecount;
   private String uploadPath;
   private String storedFileName;
   private String originalName;
   private String fileSize;
   private String deleteFileSize;
   private String deleteStoredFileName;
   private String deleteOriginalName;
   
   public int getNum() {
      return num;
   }
   public void setNum(int num) {
      this.num = num;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getNickname() {
      return nickname;
   }
   public void setNickname(String nickname) {
      this.nickname = nickname;
   }
   public String getTitle() {
      return title;
   }
   public void setTitle(String title) {
      this.title = title;
   }
   public String getBody() {
      return body;
   }
   public void setBody(String body) {
      this.body = body;
   }
   public String getPname() {
      return pname;
   }
   public void setPname(String pname) {
      this.pname = pname;
   }
   public String getPrice() {
      return price;
   }
   public void setPrice(String price) {
      this.price = price;
   }
   public Date getPdate() {
      return pdate;
   }
   public void setPdate(Date pdate) {
      this.pdate = pdate;
   }
   public int getReadcount() {
      return readcount;
   }
   public void setReadcount(int readcount) {
      this.readcount = readcount;
   }
   public int getLikecount() {
      return likecount;
   }
   public void setLikecount(int likecount) {
      this.likecount = likecount;
   }
   public String getUploadPath() {
      return uploadPath;
   }
   public void setUploadPath(String uploadPath) {
      this.uploadPath = uploadPath;
   }
   public String getStoredFileName() {
      return storedFileName;
   }
   public void setStoredFileName(String storedFileName) {
      this.storedFileName = storedFileName;
   }
   public String getOriginalName() {
      return originalName;
   }
   public void setOriginalName(String originalName) {
      this.originalName = originalName;
   }
   public String getFileSize() {
      return fileSize;
   }
   public void setFileSize(String fileSize) {
      this.fileSize = fileSize;
   }
   public String getPh() {
      return ph;
   }
   public void setPh(String ph) {
      this.ph = ph;
   }
   public String getSales() {
      return sales;
   }
   public void setSales(String sales) {
      this.sales = sales;
   }
   public String getDeleteStoredFileName() {
      return deleteStoredFileName;
   }
   public void setDeleteStoredFileName(String deleteStoredFileName) {
      this.deleteStoredFileName = deleteStoredFileName;
   }
   public String getDeleteOriginalName() {
      return deleteOriginalName;
   }
   public void setDeleteOriginalName(String deleteOriginalName) {
      this.deleteOriginalName = deleteOriginalName;
   }
   public String getDeleteFileSize() {
      return deleteFileSize;
   }
   public void setDeleteFileSize(String deleteFileSize) {
      this.deleteFileSize = deleteFileSize;
   }


   

   
   
}   
   
   