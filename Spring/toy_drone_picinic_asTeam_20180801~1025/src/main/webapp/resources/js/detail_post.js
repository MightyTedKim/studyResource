$(document).ready( function() {
   /*---------------*/
   /*   무한 스크롤    */
   /*--------------*/
   var startNum = 1;
   var endNum = 20;

   $(window).scroll(function() {
       if ($(window).scrollTop() == $(document).height() - $(window).height()) {   
          startNum += 20;
         endNum += 20;
         $.ajax({
            url : '/drone/getSoPostAfter.somo?somoim_num=' + <%=somoimVO.getNum()%> + '&startNum=' + startNum + '&endNum=' + endNum + "\'" ,
            type : 'GET',
            dataType : "json",
            contentType : 'application/x-www-form-urlencoded; charset=utf-8',
            success : function(data) {
               $.each(data, function(index, item) {
                  if (item == null){
                     var output = "";
                     outout += '<div class="end"></div>';
                     $('div#somoim_post_after_append').append(output);
                  }
                  else{
                  var output = "";
                  output += '<div class="col-lg-12 line_color_blue_b p-4 korean">';
                  output += item.pdate + ' │ ' + item.nickname + ' │ 수정하기  │ 삭제하기 │ 답글달기  <br />';
                  output += item.body + '<br />';
                  output += '</div>';
                  // output += '<input type="hidden" id="ref" value="item.ref" /><input type="hidden" id="re_level" value="item.re_level" /><input type="hidden" id="ref" value="item.re_step" />';
                   console.log("output: "   + output);
                  $('div#somoim_post_after_append').append(output);
                  }
               });
               
            },
            error : function(request, status, error) {
                 console.log("code: " + request.status + "\n" + request.responseText + 
                       "\n" + "error" + error);
            }
         });
       }

   });
   
   /*--------------------*/
   /*   소모임 게시물 가져오기  */
   /*--------------------*/
   function selectData(num, somoim_num) {
      //table내부 내용을 제거(초기화)
      //$('div#somoim_post_newest').empty();
      
      $.ajax({
         url : '/drone/getOnlyOnePost.somo?num=' + num + '&somoim_num=' + somoim_num,
         type : 'GET',
         //data : params,
         dataType : "json",
         contentType : 'application/x-www-form-urlencoded; charset=utf-8',
         success : function(data) {
            $.each(data, function(index, item) {
               var output = '';
               output += '<div class="col-lg-12 line_color_blue_b p-4 korean">';
               output += item.pdate + ' │ ' + item.nickname + ' │ 수정하기  │ 삭제하기 │ 답글달기  <br />';
               output += item.body + '<br />';
               output += '</div>';
               // output += '<input type="hidden" id="ref" value="item.ref" /><input type="hidden" id="re_level" value="item.re_level" /><input type="hidden" id="ref" value="item.re_step" />';
                console.log("output: "   + output);
               $('div#somoim_post_newest').prepend(output);
            });
         },
         error : function(request, status, error) {
              console.log("code: " + request.status + "\n" + request.responseText + 
                    "\n" + "error" + error);
         }
      });
   }
   /*--------------------*/
   /*  소모임 게시글 입력   */
   /*--------------------*/
   $('#write').click( function(event) {
      var params = $("form#form").serialize();
      
      alert('params' + params);
      $.ajax({
         url : '/drone/insertSomoimPost.somo',
         type : 'POST',
         data : params,
         dataType : "json",
         contentType : 'application/x-www-form-urlencoded; charset=utf-8',
         success : function(retVal) {
            if (retVal.res == "OK") {
               var num = retVal.num;
               var somoim_num = retVal.somoim_num;
               selectData(num, somoim_num);
               $('#name').val('');
               $('#body').val('');
            } else {
               alert("게시글 입력 실패");
            }
         },
           error : function(request,status,error){
              console.log('code:'+request.status + "\n" + "message:" + request.responseText+"\n"+"error:"+error);
           }
      });
      //기본 이벤트 제거
      event.preventDefault();
   });
   //selectData();
});

/*--------------------*/
/*   캐러셀갤러리 JS시작  */
/*--------------------*/
function GetUnique(e){var l=[],s=temp_c=[],t=["col-md-1","col-md-2","col-md-3","col-md-4","col-md-6","col-md-12","col-sm-1","col-sm-2","col-sm-3","col-sm-4","col-sm-6","col-sm-12","col-lg-1","col-lg-2","col-lg-3","col-lg-4","col-lg-6","col-lg-12","col-xs-1","col-xs-2","col-xs-3","col-xs-4","col-xs-6","col-xs-12","col-xl-1","col-xl-2","col-xl-3","col-xl-4","col-xl-6","col-xl-12"];$(e).each(function(){for(var l=$(e+" > div").attr("class").split(/\s+/),t=0;t<l.length;t++)s.push(l[t])});for(var c=0;c<s.length;c++)temp_c=s[c].split("-"),2==temp_c.length&&(temp_c.push(""),temp_c[2]=temp_c[1],temp_c[1]="xs",s[c]=temp_c.join("-")),-1==$.inArray(s[c],l)&&$.inArray(s[c],t)&&l.push(s[c]);return l}function setcss(e,l,s){for(var t=["","","","","",""],c=d=f=g=0,r=[1200,992,768,567,0],a="",o=[],a=0;a<e.length;a++){var i=e[a].split("-");if(3==i.length){switch(i[1]){case"xl":d=0;break;case"lg":d=1;break;case"md":d=2;break;case"sm":d=3;break;case"xs":d=4}t[d]=i[2]}}for(var n=0;n<t.length;n++)if(""!=t[n]){if(0==c&&(c=12/t[n]),f=12/t[n],g=100/f,a=s+" > .carousel-item.active.carousel-item-right,"+s+" > .carousel-item.carousel-item-next {-webkit-transform: translate3d("+g+"%, 0, 0);transform: translate3d("+g+", 0, 0);left: 0;}"+s+" > .carousel-item.active.carousel-item-left,"+s+" > .carousel-item.carousel-item-prev {-webkit-transform: translate3d(-"+g+"%, 0, 0);transform: translate3d(-"+g+"%, 0, 0);left: 0;}"+s+" > .carousel-item.carousel-item-left, "+s+" > .carousel-item.carousel-item-prev.carousel-item-right, "+s+" > .carousel-item.active {-webkit-transform: translate3d(0, 0, 0);transform: translate3d(0, 0, 0);left: 0;}",f>1){for(k=0;k<f-1;k++)o.push(l+" .cloneditem-"+k);o.length&&(a=a+o.join(",")+"{display: block;}"),o=[]}0!=r[n]&&(a="@media all and (min-width: "+r[n]+"px) and (transform-3d), all and (min-width:"+r[n]+"px) and (-webkit-transform-3d) {"+a+"}"),$("#slider-css").prepend(a)}$(l).each(function(){for(var e=$(this),l=0;l<c-1;l++)(e=e.next()).length||(e=$(this).siblings(":first")),e.children(":first-child").clone().addClass("cloneditem-"+l).appendTo($(this))})};

//Use Different Slider IDs for multiple slider
$(document).ready(function() {
  var item = '#slider-1 .carousel-item';
  var item_inner = "#slider-1 .carousel-inner";
  classes = GetUnique(item);
  setcss(classes, item, item_inner);
  
  
  var item_1 = '#slider-2 .carousel-item';
  var item_inner_1 = "#slider-2 .carousel-inner";
  classes = GetUnique(item_1);
  setcss(classes, item_1, item_inner_1);
}); 
