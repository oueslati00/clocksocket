<%--
  Created by IntelliJ IDEA.
  User: boues
  Date: 7/2/2021
  Time: 7:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
    <script language="javascript" type="text/javascript">
      var websocket;
      var last_time;

      function init(){
        output = document.getElementById("output");
      }
      function start_clock(){
        var wsUri = "ws://localhost:8080/clock_war_exploded/index";
        websocket = new WebSocket(wsUri);
        console.log(websocket)
        websocket.onmessage = function(evt){
          last_time = evt.data;
          writeToScreen("<span style='color: blue;'>" + last_time + "</span>");
        };
        websocket.onerror = function (evt) {
          writeToScreen('<span style="color: red;">ERROR:</span> ' + evt.data);
          websocket.close();
        }
      }
      function stop_clock(){
        websocket.close();
      }
      function writeToScreen(message){
        var pre =document.createElement("p");
        pre.style.wordWrap = "break-word";
        pre.innerHTML = message;
        oldChild = output.firstChild;
        if(oldChild == null){
          output.removeChild(oldChild);
          output.appendChild(pre);
        }
      }
      window.addEventListener("load", init, false);
    </script>
  </head>
  <body>
  <div style="text-align :center;font-family: Arial; font-size: large ">
    WebSocket Clock
    <br><br>
    <form action="">
      <input
              onclick="start_clock()"
              title="Press to Start the clock on the server"
              value="Start"
              type="button">
      <input
              onclick="stop_clock()"
              title="Press to stop the clock on the server"
              value="Stop"
              type="button"
      >
    </form>
    <div id="output"></div>
  </div>
  </body>
</html>
