package com.spring.drone.me;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.drone.me.MemberVO;
import com.spring.drone.news.NewsDAOService;
import com.spring.drone.news.NewsPaginationVO;
import com.spring.drone.news.NewsVO;
import com.spring.drone.so.SomoimDAOService;
import com.spring.drone.so.SomoimVO;

@Controller
public class MemberController {

   @Autowired
   private MemberDAOService memberDAOService;
   
   @RequestMapping("/login_form.me")
   public String login_form(){      
      System.out.println("=login_form.me ");
      return "login.me";
   }
   
   @RequestMapping("/login.me")
   public ModelAndView userCheck(MemberVO memberVO, HttpSession session, HttpServletResponse response,  HttpServletRequest request, Model model) throws Exception {
      System.out.println("=login.me ");
      ModelAndView result = new ModelAndView();
      response.setCharacterEncoding("utf-8");
      response.setContentType("text/html; utf-8");
      PrintWriter writer = response.getWriter();
      
      String password = memberVO.getPassword();
      int res = memberDAOService.userCheck(memberVO);
      
      if (res == 1){
         memberVO = memberDAOService.selectMember(memberVO);
         if (password.equals(memberVO.getPassword())) {
            session.setAttribute("id", memberVO.getId());
            session.setAttribute("nickname", memberVO.getNickname());
            result.setViewName("login/login_success");
         }else {
         writer.write("<script>alert('login.me, �뜝�룞�삕�뜝�룞�삕�뜝占� �뜝�뙐紐뚯삕�뜝�떦�뙋�삕. �솗�뜝�룞�삕�뜝�룞�삕 �뜝�뙇�눦�삕�뜝�룞�삕.');</script>");
         }
      }else{
         writer.write("<script>alert('login.me, �뜝�룞�삕�뜝�떛�벝�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�떗�룞�삕�뜝�떦�뙋�삕. �솗�뜝�룞�삕�뜝�룞�삕 �뜝�뙇�눦�삕�뜝�룞�삕');location.href='template.templ?page=login_form.me';</script>");
      }
      return result;
   }
   
   @RequestMapping("/logout.me")
   public ModelAndView logout(MemberVO memberVO, HttpSession session, HttpServletResponse response,  HttpServletRequest request, Model model) throws Exception {
      System.out.println("=logout.me ");
      ModelAndView result = new ModelAndView();
      session.removeAttribute("id");
      session.removeAttribute("nickname");
      session.removeAttribute("password");
      result.setViewName("login/logout_success");
      
      return result;
   }
   
   @RequestMapping("/client_chat.me")
   public String selectMember(HttpServletRequest request, HttpSession session) throws Exception {
      System.out.println("=client_chat.me ");
      String nickname = request.getParameter("nickname");
      System.out.println("=client_chat.me, nickname : " + nickname);
      session.setAttribute("nickname", nickname);
      
      return "client_chat";
   }
   
   @RequestMapping("/joinprocess.me")
   public String insertMember(MemberVO memberVO, HttpServletResponse response) throws Exception {
      System.out.println("=joinprocess.me ");
      int res = memberDAOService.insertMember(memberVO);
      
      response.setCharacterEncoding("utf-8");
      response.setContentType("text/html; utf-8");
      PrintWriter writer = response.getWriter();
      if (res != 0){
         writer.write("<script>alert('회원 가입에 성공하셨습니다.');" + 
                  "location.href='/drone/template.templ?page=main.templ';</script>");
      }else{
         writer.write("<script>alert('회원가입에 실패하셨습니다.');" + 
                  "location.href='/drone/template.templ?page=main.templ';</script>");
      }
      return null;
   }
   
   //�냼�꺃濡쒓렇�씤 �썑 DB 議고쉶 �썑 �븘�씠�뵒媛� �뾾�쑝硫� 媛��엯�떆�궎�뒗 �옉�뾽�쓣 �븯怨�
   //�냼�꺃濡쒓렇�씤 �썑 DB 議고쉶 �썑 �븘�씠�뵒媛� �엳�쑝硫� 諛붾줈 �꽭�뀡 ���옣�븯怨� jsp濡� 蹂대궡�뒗 硫붿냼�뱶�씠�떎.
   @RequestMapping("/socialjoinprocess.me")
   public String insertSocialMember(MemberVO memberVO, HttpSession session, HttpServletResponse response) throws Exception {
      System.out.println("=socialjoinprocess.me ");
      PrintWriter writer = response.getWriter();
      response.setCharacterEncoding("utf-8");
      response.setContentType("text/html; utf-8");
      //癒쇱� �냼�꺃濡쒓렇�씤 �썑 DB 議고쉶瑜� �빐�꽌 �븘�씠�뵒媛� ���옣�릺�뼱 �엳�뒗吏� �솗�씤�븳�떎.
      int res = memberDAOService.userCheck(memberVO);
      
      if (res == 0) {
         //�븘�씠�뵒媛� ���옣�릺�뼱 �엳吏� �븡�떎硫� DB�뿉 ���옣�븯�뒗 �옉�뾽�쓣 �븳�떎
         int insert_res = memberDAOService.insertSocialMember(memberVO);
         if (insert_res != 1) {
            writer.write("<script> location.href='template.templ?page=login_form.me';</script>");
         }
         else {
            writer.write("<script>location.href='template.templ?main.templ';</script>");
         }
      }
         //�븘�씠�뵒媛� ���옣�릺�뼱 �엳�떎硫� 洹� �븘�씠�뵒濡� 硫ㅻ쾭瑜� 遺덈윭�삩 �썑 洹� �븘�씠�뵒�� �땳�꽕�엫�쓣
         //�꽭�뀡�뿉 ���옣�빐�꽌 jsp濡� 蹂대궦�떎!!
         memberVO = memberDAOService.selectMember(memberVO);
         session.setAttribute("id", memberVO.getId());
         session.setAttribute("nickname", memberVO.getNickname());
      
      return "login/login_success";
   }
   
/*    @RequestMapping("/idcheck.me")
       @ResponseBody
       public Map<Object, Object> idCheck(@RequestBody String id) {
           
           int count = 0;
           Map<Object, Object> map = new HashMap<Object, Object>();
    
           count = MemberDAOServiceImpl.idCheck(id);
           map.put("cnt", count);
           
           return map;
       }*/

   @Autowired
   private SomoimDAOService somoimDAOService;
   @RequestMapping("/update.me")
   public ModelAndView updateMember(MemberVO memberVO, HttpSession session, HttpServletResponse response) throws Exception {
      memberDAOService.updateMember(memberVO);
      response.setCharacterEncoding("utf-8");
      response.setContentType("text/html; utf-8");
      
      System.out.println("update complete");
      
      
      session.setAttribute("nickname", memberVO.getNickname());
      ModelAndView result = new ModelAndView();

      ArrayList<SomoimVO> soList = somoimDAOService.getSoList();
      result.addObject("soList", soList);
      result.setViewName("manager/manager_admin_main");
      return result;
   }
   
   @RequestMapping("/delete.me")
   public ModelAndView deleteMember(MemberVO memberVO, HttpSession session) {
      String id = memberVO.getId();
      memberDAOService.deleteMember(id);
      ModelAndView result = new ModelAndView();
      session.removeAttribute("id");
      session.removeAttribute("nickname");
      session.removeAttribute("password");
      System.out.println("delete complete");
      
      result.setViewName("login/logout_success");
      
      return result;
   }
}