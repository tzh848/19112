<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<title>业务员管理页面</title>
<link rel="stylesheet" href="lib/Validform_v5.3.2/css/style.css">
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body>

	<script type="text/html" id="userlist_bar">
<shiro:hasPermission name="user_list">
<input type="text" id="checktext" placeholder="请输入索要查询的用户名"/>
<button class="layui-btn" lay-event="check"><i class="layui-icon layui-icon-survey"></i>查询</button>
</shiro:hasPermission>
<shiro:hasPermission name="user_add">
<button class="layui-btn" lay-event="add"><i class="layui-icon">&#xe654;</i>添加</button>
</shiro:hasPermission>

<button class="layui-btn" lay-event="update"><i class="layui-icon">&#xe642;</i>修改</button>
<button class="layui-btn layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
<button class="layui-btn" lay-event="juese">角色管理</button>
</script>

	<!-- <input type="text" id="checktext" /> -->
	<script type="text/html" id="barDemo" style="width: 200px">
<button class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修改</button>
<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
<button class="layui-btn layui-btn-sm" lay-event="juese">角色管理</button>
</script>
	<table class="layui-table" lay-filter="test"
		lay-data="{url:'checkuser',toolbar:'#userlist_bar',id:'userlist',page:true,}">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'userid',sort:true,cellMinWidth: 80}">ID</th>
				<th lay-data="{field:'username',align: 'center',width: 80}">用户名</th>
				<th lay-data="{field:'tel', align: 'center',width: 80}">手机号</th>
				<th lay-data="{field:'sex', align: 'center',width: 60}">性别</th>
				<th lay-data="{field:'city', align: 'center',width: 60}">城市</th>
				<th lay-data="{field:'regDate_text', align: 'center',width: 190}">注册时间</th>
				<th lay-data="{field:'lastLoginDate_text', align: 'center',width: 190}">最后登录时间</th>
				<th lay-data="{width:270,toolbar:'#barDemo',Width: 40}">操作</th>
			</tr>
		</thead>
	</table>
	<!-- 穿梭框 -->
	<div hidden id="test1" class="demo-transfer"></div>
	<!-- 弹出层 -->
	<form class="layui-form">
		<div hidden id="update_user_div">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">用户名</label>
					<div class="layui-input-inline">
						<input type="text" id="update_username" name="username"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">手机号</label>
					<div class="layui-input-inline">
						<input type="text" id="tel" name="tel" autocomplete="off"
							class="layui-input" datatype="m" errormsg="请输入正确的手机号格式">
					</div>
				</div>

				<div class="layui-inline" style="width: 318px">
					<label class="layui-form-label">性别</label>
					<div class="layui-input-block">
						<input type="radio" name="sex" value="男" title="男"> <input
							type="radio" name="sex" value="女" title="女">
					</div>
				</div>
				<!-- <div class="layui-inline">
					<label class="layui-form-label">密码</label>
					<div class="layui-input-inline">
						<input type="password" id="password" name="password"
							autocomplete="off" class="layui-input">
					</div>
				</div> -->
				<div class="layui-inline">
					<label class="layui-form-label">城市</label>
					<div class="layui-input-inline">
						<input type="text" id="update_city" name="city" autocomplete="off"
							class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="lib/Validform_v5.3.2/js/Validform_v5.3.2_min.js"></script>
	<script type="text/javascript" src="./layui/layui.all.js"></script>
	<script type="text/javascript">
		var table = layui.table;
		var layer = layui.layer;
		var model = layui.model;
		var $ = layui.jquery;
		var transfer = layui.transfer;
		$.ajaxSettings.async = false;
		/* 表单验证 */
		$(".layui-form").Validform({
			tiptype:3});
		table.on('toolbar(test)', function(obj) {
			var checkStatus = table.checkStatus(obj.config.id);
			switch (obj.event) {
			case 'check':
				var username = $("#checktext").val();
				console.log(username);
				/*   layer.alert(username); */
				table.reload("userlist", {
					url : "checkusers",
					where : {
						"username" : username
					}
				});
				break;
			case 'delete':
				
				  var checkData = table.checkStatus("userlist").data;
		    	  if(checkData.length>0){
						//已选中
						//获取ID值--传到servlet中--修改数据
						var checkID = "";
						var name="";
						for(var i=0;i<checkData.length;i++){
								checkID=checkID+checkData[i].userid+",";
								name=name+checkData[i].username+",";
								}
						console.log(checkID);
						console.log(name);
						layer.confirm('真的要将用户：“'+name+'”进行删除吗？',function(index){
							console.log(checkID);
							$.post("deluser",{
									"userid":checkID					
									},function(){
										
										//关闭窗口,刷新列表
										/* layer.closeAll(); */
										layer.msg("删除成功");
										table.reload("userlist");
										});
								layer.close(index);
							});
					
					}else{
						alert("请先选中数据！");
					}
				break;
			case 'add':
				$("#update_username").val("");
				$("#tel").val("");
				$("#update_city").val("");
				layer.open({
					type : 1,
					title : "添加用户",
					content : $("#update_user_div"),
					btn : [ "保存", "关闭" ],
					btn1 : function() {
						$.post("adduser", {
							"city" : $("#update_city").val(),
							"username" : $("#update_username").val(),
							/* "password" : $("#password").val(), */
							"tel" : $("#tel").val(),
							"sex" : $("[name='sex']:checked").val()
						}, function() {
							var sex = $("[name='sex']:checked").val();
							console.log(sex);
							//关闭窗口，刷新列表
							layer.closeAll();
							layer.msg("添加成功");
							table.reload("userlist");
						});
					}
				})
				break;
			case 'juese':
				var data1,data2;
				var userid;
				var role_id;
				var checkData = table.checkStatus("userlist").data;
				 if(checkData.length==1){
					 $.ajaxSettings.async = false;
					 //查询出所有的角色
					 $.post("checkrolename3", function(d) {
							data1 = d;
							console.log(d);
						});
					 userid=checkData[0].userid;
					 //查询出该用户当前的角色
					 $.post("checkrolename2",{
						 "userid":userid
						 }, function(d) {
							data2 = d;
							console.log(data2);
						});
						//渲染
						transfer.render({
							elem : "#test1",
							title : [ '所有角色', '已分配角色' ],
							id : "demo1",
							data : data1,
							showSerrch:true,
							value:data2,
							parseData : function(res) {
								return {
									"value" : res.role_id,
									"title" : res.role_name,
									"disabled" : res.disabled,
									"checked" : res.checked
								}
							} 
						});
						layer.open({
							type : 1,
							title : "角色分配",
							content : $("#test1"),
							btn : [ "保存", "关闭" ],
							area : [ '480px', '470px' ],
							btn1 : function() {
								var getData = transfer.getData('demo1');
								/* var role_id = "";
								for (var i = 0; i < getData.length; i++) {
									role_id = role_id + getData[i].value + ",";
								} */
								console.log(getData);
								$.post("add_user_role",{
										"role_id":JSON.stringify(getData),
										"userid":userid
									},function(d) {
										//关闭窗口，刷新列表
										layer.closeAll();
										layer.msg(d);
									});
								
							}
						})
								
				 }else if(checkData.length>0){
						alert("只能选择一条数据！");
				}else{
					alert("请先选择数据！");
					}
				break;
			case 'update':
				var checkData = table.checkStatus("userlist").data;
				var userid=checkData[0].userid;
				console.log(userid);
		    	  if(checkData.length==1){
						 console.log(checkData);
							$("#update_city").val(checkData[0].city);
							$("#update_username").val(checkData[0].username);
							$("#tel").val(checkData[0].tel);
							$("#sex").val(checkData[0].sex);
							$("#password").val(checkData[0].password);
		    		  layer.open({
							type : 1,
							title : "修改信息",
							content : $("#update_user_div"),
							btn : [ "保存", "关闭" ],
							btn1 : function() {
								$.post("updateuserP", {
									"userid" : userid,
									"city" : $("#update_city").val(),
									"username" : $("#update_username").val(),
									"password" : $("#password").val(),
									"tel" : $("#tel").val(),
									"sex" : $("[name='sex']:checked").val()
								}, function() {
									//关闭窗口，刷新列表
									layer.closeAll();
									layer.msg("修改成功");
									table.reload("userlist");
								});
							}
						})
			    	  }else if(checkData.length>0){
							alert("只能选择一条数据！");
						}else{
							alert("请先选择数据！");
							}
				break;
			}
		});
		table.on('tool(test)', function(obj) {
			var data = obj.data;
			var userid = data.userid;
			console.log(data);
			//console.log(obj)
			var username = data.username;
			var county = data.county;
			var city = data.city;
			if (obj.event === 'update') {
				$("#update_username").val(data.username);
				$("#update_city").val(data.city);
				$("#tel").val(data.tel);
				$("#sex").val(data.sex);
				$("#password").val(data.password);
				console.log(username);
				//弹出对话框
				layer.open({
					type : 1,
					title : "修改信息",
					content : $("#update_user_div"),
					btn : [ "保存", "关闭" ],
					btn1 : function() {
						$.post("updateuserP", {
							"userid" : userid,
							"city" : $("#update_city").val(),
							"username" : $("#update_username").val(),
							"password" : $("#password").val(),
							"tel" : $("#tel").val(),
							"sex" : $("[name='sex']:checked").val()
						}, function() {
							//关闭窗口，刷新列表
							layer.closeAll();
							layer.msg("修改成功");
							table.reload("userlist");
						});
					}
				})
			} else if (obj.event === 'delete') {
				var data = obj.data;
				var userid = data.userid;
				console.log(data);
				//console.log(obj)
				var username = data.username;
				console.log(username);
				layer.confirm('真的要将用户：“'+username+'”进行删除吗？',function(index){
					console.log(userid);
					$.post("deluser",{
							"userid":userid					
							},function(){
								
								//关闭窗口,刷新列表
								/* layer.closeAll(); */
								layer.msg("删除成功");
								table.reload("userlist");
								});
						layer.close(index);
					});
			}	
			else if (obj.event === 'juese') {
				var data1,data2;
				var userid;
				var role_id;
				var data = obj.data;
				var userid = data.userid;
				console.log(data);
				console.log(userid);
				 $.ajaxSettings.async = false;
				 //查询出所有的角色
				 $.post("checkrolename", function(d) {
						data1 = d.data;
					});
				//查询出该用户当前的角色
				 $.post("checkrolename2",{
					 "userid":userid
					 }, function(d) {
						data2 = d;
						console.log(data2);
					});
					//渲染
					transfer.render({
						elem : "#test1",
						title : [ '所有角色', '已分配角色' ],
						id : "demo1",
						data : data1,
						showSerrch:true,
						value:data2,
						parseData : function(res) {
							return {
								"value" : res.role_id,
								"title" : res.role_name,
								"disabled" : res.disabled,
								"checked" : res.checked
							}
						}
					});
					layer.open({
						type : 1,
						title : "角色分配",
						content : $("#test1"),
						btn : [ "保存", "关闭" ],
						area : [ '480px', '470px' ],
						btn1 : function() {
							var getData = transfer.getData('demo1');
							/* var role_id = "";
							for (var i = 0; i < getData.length; i++) {
								role_id = role_id + getData[i].value + ",";
							} */
							console.log(getData);
							$.post("add_user_role",{
									"role_id":JSON.stringify(getData),
									"userid":userid
								},function(d) {
									//关闭窗口，刷新列表
									layer.closeAll();
									layer.msg(d);
								});
							
						}
					})
			}		
		});
	</script>
</body>
</html>