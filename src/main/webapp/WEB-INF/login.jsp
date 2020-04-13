<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<base href="<%=basePath%>">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>登录</title>
<!-- Bootstrap -->
<link href="lib/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="lib/Validform_v5.3.2/css/style.css" />
<link rel="stylesheet" type="text/css" href="./css/login1.css" />
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body style="background-image:url(./img/login-bg.jpg);">
	<%
		Object msg = request.getAttribute("msg");
		if (msg != null && !"".equals(msg)) {
	%>
	<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="./layui/layui.all.js"></script>
	<script type="text/javascript">
		var layer = layui.layer;
		layer.msg('${msg}');
	</script>
	<%
		}
	%>
	<div class="bg">
		<div class="container-fluid">
			<div class="panel panel-default panel-info">
				<div class="panel-heading login_title">登录</div>
				<div class="panel-body">
					<div class="demoform">
						<div class="form-group">
							<label for="exampleInputEmail1">账户</label> <input type="text"
								nullmsg='请填写用户名' errormsg="用户名错误" class="form-control"
								id="exampleInputEmail1" placeholder="请输入登录用户名" name="username">
							<div class="error-tip"></div>
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1">密码</label> <input
								type="password" nullmsg='请填写密码' errormsg="密码错误"
								class="form-control" id="exampleInputPassword1"
								placeholder="请输入登录密码" name="password">
							<div class="error-tip"></div>
						</div>
						<div>
							<input type="text" class="form-control" value="" placeholder="请输入验证码（区分大小写）"
								style="float:left;width:198px"
								id="text">
							<canvas id="canvas" width="100" height="32" onclick="dj()"
								style="float:left;border: 1px solid #ccc;margin-left:18px; border-radius: 5px;"></canvas>
						</div>
						<button type="submit" onclick="sublim()" class="btn btn-primary login_button"
						style="margin-top:10px">登录</button>
					</div>
					<div class="login_box">
						<div class="login_home">
							<a href="register.html">注册账户</a>
						</div>
						<div class="password_daw">
							<a href="">忘记密码?</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="./layui/layui.all.js"></script>
	<script type="text/javascript">
	var layer = layui.layer;
	var show_num = [];
	 draw(show_num);
	function dj(){
	 draw(show_num);   
	 }
	function sublim(){
	var val=document.getElementById("text").value;  
	            var num = show_num.join("");
	            
	            if(val==''){
	                alert('请输入验证码！');
	            }else if(val == num){
		           var username= $("#exampleInputEmail1").val();
	               var password= $("#exampleInputPassword1").val();
				   var form=$('<form>');//定义一个form表单
				   form.attr('style','display:none');//隐藏form表单
				   form.attr('method','post');//传参方式是post
				   form.attr('action','/login_system');
				   $('body').append(form);//把form表单放到body里
				   var input=$('<input>');
				   input.attr('name',"username");
				   input.attr('value',username);
				   $('form').append(input);
				   var input=$('<input>');
				   input.attr('name',"password");
				   input.attr('value',password);
				   $('form').append(input);
				   form.submit();
	            }else{
	            	layer.msg('验证码错误！\n你输入的是:  '+val+"\n正确的是:  "+num+'\n请重新输入！');
	            	
	                /* alert('验证码错误！\n你输入的是:  '+val+"\n正确的是:  "+num+'\n请重新输入！'); */
	                document.getElementById("text").value='';
	                draw(show_num);
	            }
	        
	       
			
	          }
	function draw(show_num) {
	        var canvas_width=document.getElementById('canvas').clientWidth;
	        var canvas_height=document.getElementById('canvas').clientHeight;
	        var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
	        var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
	        canvas.width = canvas_width;
	        canvas.height = canvas_height;
	        var sCode = "A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m";
	        var aCode = sCode.split(",");
	        var aLength = aCode.length;//获取到数组的长度
				
	        for (var i = 0; i <= 3; i++) {
	            var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
	            var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
	            var txt = aCode[j];//得到随机的一个内容
	            show_num[i] = txt;
	            var x = 10 + i * 20;//文字在canvas上的x坐标
	            var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
	            context.font = "bold 23px 微软雅黑";

	            context.translate(x, y);
	            context.rotate(deg);

	            context.fillStyle = randomColor();
	            context.fillText(txt, 0, 0);

	            context.rotate(-deg);
	            context.translate(-x, -y);
	        }
	        for (var i = 0; i <= 5; i++) { //验证码上显示线条
	            context.strokeStyle = randomColor();
	            context.beginPath();
	            context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
	            context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
	            context.stroke();
	        }
	        for (var i = 0; i <= 30; i++) { //验证码上显示小点
	            context.strokeStyle = randomColor();
	            context.beginPath();
	            var x = Math.random() * canvas_width;
	            var y = Math.random() * canvas_height;
	            context.moveTo(x, y);
	            context.lineTo(x + 1, y + 1);
	            context.stroke();
	        }
	        //$("#text").val(show_num.join(""));
	        console.log(show_num.join(""));
	    }
	function randomColor() {//得到随机的颜色值
	        var r = Math.floor(Math.random() * 256);
	        var g = Math.floor(Math.random() * 256);
	        var b = Math.floor(Math.random() * 256);
	        return "rgb(" + r + "," + g + "," + b + ")";
	    }
    
	</script>
</body>
</html>