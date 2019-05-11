<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">

        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLongTitle">드론 통계</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>

        <div class="modal-body">
          <div class="row mt-4 ml-2 mr-2">

<!-- chart 1 -->
<div class="row">
	<div class="col-md-6">
		<div class="chart-container" style="position: relative; height:auto; width:100%; padding-top:18px">
			<canvas id="myChart"></canvas>
		</div>
	</div>
	<div class="col-md-6" style="position: relative; height:auto; width:60%">
  		<h4> 세계 드론 시장 규모 </h4>
		<hr/>
  	 	<p> 세계 드론 시장은 매년 급성장하고 있습니다.</p> 
  	 	<p> 2018년 현재는 67.3억 달러로, 2015년에 비해 168% 커졌고, 2024년까지는 218% 커진 146.9억 달러를 기록 할 것으로 관측 됩니다.</p> 
  	  	<hr/>    	
  	</div>
</div>

<br/><br/>

<!-- chart 2 -->
<div class="row">
	<div class="col-md-7" style="position: relative; height:auto; width:60%">
  		<h4> 드론 자격 취득 현황 </h4>
		<hr/>
  	 	<p> 드론 자격증에 대한 관심이 높아지고 있습니다.   2015년 205명이었던 취득자는 2018년 8월4504명으로 2100%이상 증가했습니다.</p>
  	 	<p>육군 드론 부사관, 방제 드론, 방송 등에 대한 수요가 높아지고 있는 만큼 드론의 미래는 밝다고 볼 수 있습니다.</p>
  	  	<hr/>   	
  	</div>
	<div class="col-md-5">
		<div class="chart-container" style="position: relative; height:auto; width:100%; padding-top:50px">
			<canvas id="myChart1"></canvas>
		</div>
	</div>
</div>

<br/><br/>

<!-- chart 3 -->
<div class="row">
	<div class="col-md-5">
		<div class="chart-container" style="position: relative; height:auto; width:100%;">
			<canvas id="myChart2"></canvas>
		</div>
	</div>
	<div class="col-md-7" style="position: relative; height:auto; width:60%">
  		<br/>
  		<h4> 상위 판매 드론 </h4>
		<hr/>
		<br/>
  	 	<p> 2017년 가장 많이 팔린 드론은 "치어슨 CX-10A(12.9%)" "DJI 매빅 프로(9.7%)", "시마 X5 쿼드 콥터(7.4%)"로 집게 되었습니다.</p>
  	 	<p> 아직 독점에 가까운 브랜드는 없지만 중국 브랜드, 그 중에서 전통의 강자 DJI가 강세를 보이고 있습니다.</p> 
	   	<br/>
  	  	<hr/>   	
  	</div>
</div>

<br/><br/>
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>



<script>
var ctx = document.getElementById("myChart");
var myChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
        labels: ["2015", "2016", "2018", "2020","2022","2024"],
        datasets: [{
            label: '세계 드론 시장 규모',
            data: [39.9, 47.3, 67.3, 97.9, 127.1, 146.9],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>
<script>
var ctx = document.getElementById("myChart1");
var myChart1 = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["2015", "2016", "2017", "2018"],
        datasets: [{
            label: '드론 자격 취득 현황',
            data: [205, 454, 2872, 4504],
            backgroundColor: [
              /*   'rgba(255, 99, 132, 0.2)', */
                'rgba(54, 162, 235, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(54, 162, 235, 0.2)'
              /*   'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)' */
            ],
            borderColor: [
                /* 'rgba(255,99,132,1)', */
                   'rgba(54, 162, 235, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(54, 162, 235, 1)'
            /*     'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)', */
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>
<script>
var ctx = document.getElementById("myChart2");
var myChart2 = new Chart(ctx, {
    type: 'doughnut',
    data : { 
       datasets:[{ 
           data: [12.9, 9.7, 7.4, 5.1, 4.9, 60],
         backgroundColor: [
             'rgba(255, 99, 132, 0.2)', 
             'rgba(153, 102, 255, 0.2)',
             'rgba(54, 162, 235, 0.2)',
             'rgba(255, 206, 86, 0.2)',
             'rgba(255, 159, 64, 0.2)',
             'rgba(153, 153, 153, 0.2)'
                 ]
       }],
       // These labels appear in the legend and in the tooltips when hovering different arcs
       labels: [
           '치어슨 CX-10A',
           'DJI 매빅프로',
           '시마 X5 쿼드콥터',
           '치어슨 CX-10D',
           '시마 X5C 쿼트콥터',
           '기타'
       ]
    }
});
</script>