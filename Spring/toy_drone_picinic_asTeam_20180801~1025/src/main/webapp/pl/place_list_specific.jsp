<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import ="com.spring.drone.pl.PlaceVO" %>
<%@ page import ="java.util.*" %>
   
<%
   ArrayList<PlaceVO> placeList = (ArrayList<PlaceVO>) request.getAttribute("placeList");
%>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em" crossorigin="anonymous"></script>

     
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VZh2P8e3BanI8L1zMwyD&submodules=panorama,geocoder"></script>
     
<script>
/*--------------------------*/
/*    make_pano_map         */
/*--------------------------*/
function make_pano_map(place_Coord_x, place_Coord_y, index) {
   var pano = null;
   console.log("make_pano_map, place_Coord_x: " + place_Coord_x);
   console.log("make_pano_map, place_Coord_y: " + place_Coord_y);
   console.log("make_pano_map, index: " + index);
   
   pano = new naver.maps.Panorama("pano" + index, {
        position: new naver.maps.LatLng(place_Coord_x, place_Coord_y),
        pov: {
            pan: -135,
            tilt: 29,
            fov: 100
        },
        aroundControl: true,
        aroundControlOptions: {
            position: naver.maps.Position.TOP_RIGHT
        }
    });
}

</script> 

	<div class="place_list_search_desc">
		<p><Strong> 이 페이지에서는 드론 나들이 장소를 2가지 방식으로 보실 수 있습니다 :)</Strong></p>
		<div><b>- 카드 방식 :</b> 지도 사진과 함께   &nbsp;"<i class="fas fa-angle-double-down"></i>"&nbsp; 를 누르시면 자세한 내용을 보실 수 있습니다.</b></div>
		<div><b>- 리스트 방식 :</b> 지도 사진과 함께  &nbsp;"<i class="fas fa-list-ul"></i>"&nbsp; 를 도로/항공뷰와 함께 자세한 내용을 보실 수 있습니다.</b></div>
	</div>
   <!-- 장소 -->
   <div class="row place_list_search_header">   
      <div class="col-sm-12" ><!-- 장소추천 header -->
      	<div class="row">
        	<input type="search" class="place_list_search" id="input-search" size="30" placeholder=" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색할 장소를 입력해주세요">
           	<div class="btn-group ">
               	<a href="#" id="grid" class="place_list_search_button btn btn-outline-light text-dark">
               		<i class="fas fa-th-large"></i> Card
            		</a>

                <a href="#" id="list" class="place_list_search_button btn btn-outline-light text-dark">
   	 	           <i class="fas fa-list-ul"></i> List
           		</a>
       		</div>
       </div>
             
      </div>   <!-- 장소추천 header 끝 -->   
   </div>
   
   <div class="row place_list_content">
      <div class="place_products col-sm-12"><!-- 장소추천 content -->
         <div class="row view-group searchable-container" id="products" >   
<%
for(int index = 0; index < placeList.size(); index ++){
   PlaceVO vo = placeList.get(index);
%>

         <!-- JS don't move this, TED-->
         <script type="text/javascript">
           $(document).ready(function($) {
             $('#accordion<%=index %>').find('.accordion-toggle<%=index %>').click(function(){
               $(this).next().slideToggle('easing');
             });
           });
         </script>
         <!-- JS don't move this, TED-->

            <div class="item col-xs-4 col-lg-4"><!-- card -->
               <div class="thumbnail card" style="text-align:center; float: center;">   
                  <div id="accordion<%=index %>">               
                  
                  <!-- 지도 wrap-->                  
                  <div class="thumbnail_map_wrap" 
                        onclick="mapZoom('<%=vo.getPlace_Name() %>', '<%=vo.getPlace_Add() %>',
                                    '<%=vo.getPlace_Desc() %>', '<%=vo.getUser_Id() %>', 
                                    '<%=vo.getPlace_Coord() %>', '<%=vo.getPlace_Cate() %>')">
                     <%                      
                      String coord1 = vo.getPlace_Coord();
                        String[] words = coord1.split(",");
                        String coord2 = words[1] + "," + words[0];

                        String img_src = "https://openapi.naver.com/v1/map/staticmap.bin?";
                      img_src += "clientId=VZh2P8e3BanI8L1zMwyD&url=http://localhost:8080&crs=EPSG:4326";
                      img_src += "&level=10&w=300&h=200&&baselayer=default";
                      img_src += "&center=" + coord2;
                      img_src += "&markers=" + coord2;
                      %>
      
                     <img class="thumbnail_map_image" src="<%=img_src %>" >
                  </div>
                  
                  <!-- 내용 -->
                  <div class="thumbnail_content_wrap" >
                     <div class="row">
                        <div class="place_card_address"> 
                           <div class="accordion-toggle<%=index %>">
                              <div class="nanumgothiccoding" style="font-size:30px; float:center; width:100%">
                                 <%=vo.getPlace_Name() %> <i class="fas fa-angle-double-down"></i>
                              </div>                           
                           </div> 
                            
							<div class="accordion-content place_card_desc" style="width:100%; margin:auto">
								<!-- 파노라마 -->
								<div class="thumb_pano_wrap">      
							  		<div id="pano<%=index %>" class="thumb_pano" style="height: 250px; width: 520px;"></div>
								</div>
								<div class="place_card_desc_content">
									<div style="font-size:10px; width:80%; margin:auto; padding:5px; border:1px solid #F6F6EE;">
										<div class="nanumgothiccoding" style="float:left;"><b> &nbsp;&nbsp;주소:</b> <%=vo.getPlace_Add() %></div>	<br/>								
										<div class="nanumgothiccoding" style="float:left;"><b> &nbsp;&nbsp;분류:</b> <%=vo.getPlace_Cate() %> </div>
										<br/>							
									</div>
									<div class="nanumgothiccoding" style="padding:5px; width:80%; margin:auto; border:1px solid #F6F6EE;">
										<%=vo.getPlace_Desc() %>									
									</div>

								</div>
							</div> <!-- class="accordion-content place_card_desc" -->
                            
                        </div> <!-- class="place_card_address" -->
                     </div>  <!-- class="row" --> 
                  </div>  <!-- class="thumbnail_content_wrap" --> 
                  
                  <!-- JS don't move this, TED-->
                  
                  <script>
                  make_pano_map(<%=vo.getPlace_Coord() %>, <%=index %>);
                  </script>
                  <!-- JS don't move this, TED-->
         
                  </div><!-- "thumbnail_caption card-body" -->
               </div><!-- "thumbnail card" -->
            </div><!-- card -->
<%   } %>
         </div><!-- searchable-container-->
      </div>   <!-- 장소추천 content -->
   </div>


<!-- css -->

<style>

.center{
    margin: auto;
    width: 100%;
    padding: 10px;
 }
.place_list_search_button{
	margin:5px;
    border: 0.5px solid grey;
}

.place_list_search{
    margin-top: 5px;
    margin-bottom: 5px;
    border: 0.5px solid grey;
    border-radius: 15px;
    margin-left: 37px;
}

.place_list_search_desc{
	padding:20px;
	margin:15px;    
	border-radius: 15px;
	background: #D9DCD6;
	width: 60%
}
/*-------------------------------*/
/*        accordian            */
/*-------------------------------*/
  .accordion-toggle {cursor: pointer;}
  .accordion-content {display: none;}
  .accordion-content.list {display: block;}

  .thumbnail_map_image{
     width: 100%;
     height: 250px;  
  }
  
  .thumbnail_map_image.list{
     width: 90%;
     height: 350px;
     padding-top: 30px;
  }
  
  .thumbnail_map_image{
     width: 100%;
     height: 250px;  
  }
 
  .thumb_pano_wrap, .thumb_pano {
     display: none;
   }
   
  .thumb_pano_wrap.list{
     display: block;
     float: center;  
     height: 250px;
     width: 520px;
     }
     
  .thumb_pano.list{
      display: block;
    float: center;  
     height: 100%;
     width: 100%;
  }
   
/*-------------------------------*/
/*        image:hover            */
/*-------------------------------*/
.image {
  opacity: 1;
  display: block;
  width: 100%;
  height: auto;
  transition: .5s ease;
  backface-visibility: hidden;
}

.image:hover {
  opacity: 0.3;
}

/*-------------------------------*/
/*          place_card           */
/*-------------------------------*/

.place_card_address{
    border-bottom-style: inset;
    border-top-style: outset;
    font-size: 10px;
    margin-top: 4px;
    margin:auto;
}

.thumbnail_content_wrap{
   padding:0px;
}

.thumbnail_map_wrap{
    border: 10px solid white;
    border-bottom:0px;
}

.place_card_name{
   font-size: 30px;
} 

.place_card_category{
   font-size: 16px;
}

.place_card_desc{
   font-size: 20px;
   width: 100%;
}

.place_card_desc_content{
   	width: 100%;
	margin:auto;
	border: 1px solid #F6F6EE;
}


/*-------------------------------*/
/*       list, grid CSS          */
/*-------------------------------*/

.view-group {
    display: -ms-flexbox;
    display: flex;
    -ms-flex-direction: row;
    flex-direction: row;
    padding-left: 0;
    margin-bottom: 0;
}
.thumbnail{
    margin-bottom: 30px;
    padding: 10px;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0px;
    width:100%;
}
.item.list-group-item{
    float: none;
    width: 100%;
    margin-bottom: 30px;
    -ms-flex: 0 0 100%;
    flex: 0 0 100%;
    max-width: 100%;
    padding: 0 1rem;
    border: 0;
}
.item.list-group-item .thumbnail_map_wrap {
    float: left;
    width: 49%;
}
.item.list-group-item .list-group-image{
    margin-right: 10px;
}
.item.list-group-item .thumbnail{
    margin-bottom: 0px;
    display: inline-block;
}
.item.list-group-item .thumbnail_caption{
    float: center;
    width: auto;
    margin: 0;
    padding-top:0px;
}
.item.list-group-item:before, .item.list-group-item:after{
    display: table;
    content: " ";
}
.item.list-group-item:after{
    clear: both;
}
</style>

<!-- script -->
<script>
$(document).ready(function() {

    $('#grid').click(function(event){
       console.log("=grid");
        event.preventDefault();
        $('#products .item').removeClass('list-group-item');
        $('#products .item').addClass('grid-group-item');

        $('.thumbnail_content_wrap .accordion-content').removeClass('list');
        $('.thumb_pano_wrap').removeClass('list');
        $('.thumb_pano').removeClass('list');
        
        $(".thumbnail_map_image").removeClass('list');
    });
    
    $('#list').click(function(event){
       console.log("=list");
        event.preventDefault();
        $('#products .item').addClass('list-group-item');
        
        $('.thumbnail_content_wrap .accordion-content').addClass('list');
        $('.thumb_pano_wrap').addClass('list');
        $('.thumb_pano').addClass('list');
        
        $(".thumbnail_map_image").addClass('list');
       
    });
});
/*----------------------------------*/
/*        place_list search         */
/*----------------------------------*/
$(function() {    
    $('#input-search').on('keyup', function() {
       console.log("=input-search");
      var rex = new RegExp($(this).val(), 'i');
        $('.searchable-container .item').hide();
        $('.searchable-container .item').filter(function() {
            return rex.test($(this).text());
        }).show();
    }); 
});
</script>