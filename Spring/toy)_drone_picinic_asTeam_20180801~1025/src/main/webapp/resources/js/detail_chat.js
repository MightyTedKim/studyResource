
w = new WebSocket("ws://localhost:8080/drone/broadcasting?nickname=<%=nickname%>");
   w.onopen = function() {
      alert("WebSocket Connected");
   }
   w.onmessage = function(e) {
      log(e.data.toString());
   }
   w.onclose = function(e) {
      log("WebSocket closed");
   }
   w.onerror = function(e) {
      log("WebSocket error");
   }
   window.onload = function() {
      document.getElementById("send_button").onclick = function() {
         if (document.getElementById("input").value == "")      //메세지 입력란이 공백일 경우
            {
            alert("메세지 입력해");
            }
         else{
            var input = document.getElementById("input").value;
            w.send("<%=nickname%>" + "/" + input);
            document.getElementById("input").value = ""; 
         }
      }; document.getElementById("chat").scrollTop = document.getElementById("chat").scrollHeight;

   }

   var log = function(s){
      var m = s.split("/");
      if(m[0] === 'message'){      //메세지일 경우
         if(m[1] == "<%=nickname%>") {      //메세지 보낸 사람이 본인일 경우 출력
            var div1 = document.createElement("div");
            div1.setAttribute("class", "outgoing_msg");
            var div2 = document.createElement("div");
            div2.setAttribute("class", "sent_msg");
            var p = document.createElement("p");
            var span = document.createElement("span");
            span.setAttribute("class", "time_date");
              var date = new Date();
              var hour = date.getHours();
              p.innerText = "내가 말해따 " + "\n" + "\n" + m[2];
              if(hour <= 12) {
                 span.innerText = hour + "시" + date.getMinutes() + "분" + "AM";
              }
              else {
                 span.innerText = hour-12 + "시" + date.getMinutes() + "분" + "PM";
              }
              div1.appendChild(div2);
              div2.appendChild(p);
              p.appendChild(span);
              $('#chat').append(div1);
         }
         else{      //본인이 아닌 사람의 메세지 출력
            var div1 = document.createElement("div");
            div1.setAttribute("class", "incoming_msg");
            var div2 = document.createElement("div");
            div2.setAttribute("class", "incoming_msg_img");
            var div3 = document.createElement("div");
            div3.setAttribute("class", "received_msg");
            var div4 = document.createElement("div");
            div4.setAttribute("class", "received_withd_msg");
            var p = document.createElement("p");
            var span = document.createElement("span");
            span.setAttribute("class", "time_date");
            var date = new Date();
              var hour = date.getHours();
              p.innerText = m[1] + "\n" + "\n" + m[2];
              if(hour <= 12) {
                 span.innerText = hour + "시" + date.getMinutes() + "분" + "AM";
              }
              else {
                 span.innerText = hour-12 + "시" + date.getMinutes() + "분" + "PM";
              }
              div1.appendChild(div2);
              div2.appendChild(div3);
              div3.appendChild(div4);
              div4.appendChild(p);
              p.appendChild(span);
              $('#chat').append(div1);
         } 
      }
      else if(m[0] === 'nicknameList'){      //닉네임리스트일 경우
         $('#inbox_chat').empty();
         for(var i=1; i<m.length; i++){
            if(i == m.length-1){ continue;}
            var div1 = document.createElement("div");
            div1.setAttribute("class", "chat_list");
            var div2 = document.createElement("div");
            div2.setAttribute("class", "chat_people");
            var div3 = document.createElement("div");
            div3.setAttribute("class", "chat_img");
            var div4 = document.createElement("div");
            div4.setAttribute("class", "chat_ib");
            var h5 = document.createElement("h5");
            h5.setAttribute("id", "nicknameList");
            h5.innerText = "@" + m[i];
            
              div1.appendChild(div2);
              div2.appendChild(div3);
              div3.appendChild(div4);
              div4.appendChild(h5);
              
              $('#inbox_chat').append(div1);
              
         }
         
      } document.getElementById("chat").scrollTop = document.getElementById("chat").scrollHeight; 
   }

   function enterkey() {
        if (window.event.keyCode == 13) {
             // 엔터키가 눌렸을 때 실행할 내용
             if (document.getElementById("input").value == "")
            {
            alert("메세지 입력해");
            }
         else{
            var input = document.getElementById("input").value;
            w.send("<%=nickname%>" + "/" + input);
            document.getElementById("input").value = "";
         }
      }
      document.getElementById("chat").scrollTop = document
            .getElementById("chat").scrollHeight;
   }