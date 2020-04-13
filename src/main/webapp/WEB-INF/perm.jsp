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
<title>权限管理页面</title>
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body>

	<script type="text/html" id="role_bar">
<shiro:hasPermission name="user_list">
<input type="text" id="checktext" placeholder="请输入所要查询的角色名"/>

<button class="layui-btn" lay-event="check"><i class="layui-icon layui-icon-survey" style="font-size: 15px;">查询</i></button>
</shiro:hasPermission>
<shiro:hasPermission name="user_add">
<button class="layui-btn" lay-event="add"><i class="layui-icon">&#xe654;</i>添加</button>
</shiro:hasPermission>
<shiro:hasPermission name="user_set">
<button class="layui-btn" lay-event="update"><i class="layui-icon">&#xe642;</i>修改</button>
</shiro:hasPermission>
<shiro:hasPermission name="user_del">
<button class="layui-btn layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
</shiro:hasPermission>
<button class="layui-btn" lay-event="quanxian">权限管理</button>
</script>
	<script type="text/html" id="barDemo">
<button class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修改</button>
<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
</script>
	<!-- <table class="layui-table" lay-filter="test"
		lay-data="{url:'checkrole',toolbar:'#role_bar',id:'rolelist',page:true,}">
		<thead>
			<tr>
				<th lay-data="{type:'radio'}"></th>
				<th lay-data="{field:'role_id',sort:true}">用户ID</th>
				<th lay-data="{field:'role_code',sort:true}">用户编号</th>
				<th lay-data="{field:'role_name'}">用户名</th>
				<th lay-data="{width:190,toolbar: '#barDemo'}">操作</th>
			</tr>
		</thead>
	</table> -->
	<table class="layui-table" lay-filter="test"
		lay-data="{url:'checkrolename',toolbar:'#role_bar',id:'userlist',page:true,}">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'role_id',sort:true}">ID</th>
				<th lay-data="{field:'role_name'}">角色名</th>
				<th lay-data="{width:190,toolbar:'#barDemo'}">操作</th>
			</tr>
		</thead>
	</table>
	<form class="layui-form">
		<div hidden id="update_user_div">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">角色ID</label>
					<div class="layui-input-inline">
						<input type="text" id="role_id" name="role_id" autocomplete="off"
							class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">角色名</label>
					<div class="layui-input-inline">
						<input type="text" id="role_name" name="role_name"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- 修改弹出框 -->
	<form class="layui-form">
		<div hidden id="update_role_div">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">角色名</label>
					<div class="layui-input-inline">
						<input type="text" id="update_role_name" name="role_name"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</div>
	</form>



	<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="./layui/layui.all.js"></script>
	<script type="text/javascript">
	var table = layui.table;
	var layer = layui.layer;
	var model = layui.model;
	var $ = layui.jquery;
	$.ajaxSettings.async = false;
		table.on('toolbar(test)', function(obj) {
			var checkStatus = table.checkStatus(obj.config.id);
			switch (obj.event) {
			case 'quanxian':
				var checkData = table.checkStatus("userlist").data;
				console.log(checkData);
				if (checkData.length > 0) {
					var role_id = checkData[0].role_id;
					window.location.href = "sys/role_perm_page/" + role_id;
				} else {
					alert("请先选中数据!")
				}
				break;
			case 'check':
				var role_name = $("#checktext").val();
				console.log(role_name);
				/*   layer.alert(username); */
				table.reload("userlist", {
					url : "checkroles",
					where : {
						"role_name" : role_name
					}
				});
				break;
			case 'delete':
				  var checkData = table.checkStatus("userlist").data;
		    	  if(checkData.length>0){
						//已选中
						//获取ID值--传到servlet中--修改数据
						var checkID = "";
						var role_name="";
						for(var i=0;i<checkData.length;i++){
								checkID=checkID+checkData[i].role_id+",";
								role_name=role_name+checkData[i].role_name+",";
								}
						console.log(checkID);
						console.log(name);
						layer.confirm('真的要将角色：“'+role_name+'”进行删除吗？',function(index){
							console.log(checkID);
							$.post("delrole",{
									"role_id":checkID					
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
				$("#role_id").val("");
				$("#role_name").val("");
				layer.open({
					type : 1,
					title : "添加角色",
					content : $("#update_user_div"),
					btn : [ "保存", "关闭" ],
					btn1 : function() {
						$.post("addrole", {
							"role_id" : $("#role_id").val(),
							"role_name" : $("#role_name").val()
						}, function() {
							//关闭窗口，刷新列表
							layer.closeAll();
							layer.msg("添加成功");
							table.reload("userlist");
						});
					}
				})
				break;
			case 'update':
				var checkData = table.checkStatus("userlist").data;
		    	  if(checkData.length==1){
		    		  var role_id=checkData[0].role_id;
		    			console.log(role_id);
						console.log(checkData);
						$("#update_role_name").val(checkData[0].role_name);
		    		  layer.open({
							type : 1,
							title : "修改信息",
							content : $("#update_role_div"),
							btn : [ "保存", "关闭" ],
							btn1 : function() {
								$.post("updaterole", {
									"role_id" : role_id,
									"role_name" : $("#update_role_name").val()
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
		})
		table.on('tool(test)', function(obj) {
	var data = obj.data;
	var role_id = data.role_id;
	console.log(data);
	//console.log(obj)
	var role_name = data.role_name;
	if (obj.event === 'update') {
		$("#update_role_name").val(data.role_name);
		console.log(role_name);
		//弹出对话框
		layer.open({
			type : 1,
			title : "修改信息",
			content : $("#update_role_div"),
			btn : [ "保存", "关闭" ],
			btn1 : function() {
				$.post("updaterole", {
					"role_id" : role_id,
					"role_name" : $("#update_role_name").val()
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
		var role_id = data.role_id;
		console.log(data);
		//console.log(obj)
		var role_name = data.role_name;
		console.log(role_name);
		layer.confirm('真的要将用户：“'+role_name+'”进行删除吗？',function(index){
			console.log(role_id);
			$.post("delrole",{
					"role_id":role_id					
					},function(){
						//关闭窗口,刷新列表
						/* layer.closeAll(); */
						layer.msg("删除成功");
						table.reload("userlist");
						});
				layer.close(index);
			});
	}		
});
	</script>
</body>
</html>