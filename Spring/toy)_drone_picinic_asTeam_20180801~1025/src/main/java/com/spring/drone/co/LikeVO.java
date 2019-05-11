package com.spring.drone.co;

import org.springframework.stereotype.Component;

@Component
public class LikeVO {
   private String id;
   private int num;
   private String likeYn;
   private int likeCheck;
   
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public int getNum() {
      return num;
   }
   public void setNum(int num) {
      this.num = num;
   }
   public String getLikeYn() {
      return likeYn;
   }
   public void setLikeYn(String likeYn) {
      this.likeYn = likeYn;
   }
   public int getLikeCheck() {
      return likeCheck;
   }
   public void setLikeCheck(int likeCheck) {
      this.likeCheck = likeCheck;
   }
}