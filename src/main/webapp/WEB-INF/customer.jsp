<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>客户管理页面</title>
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body>
<script type="text/html" id="userlist_bar">
<input type="text" id="checktext" placeholder="请输入索要查询的客户名"/>
<button class="layui-btn" lay-event="check"><i class="layui-icon layui-icon-survey"></i>查询</button>
<button class="layui-btn" lay-event="add"><i class="layui-icon">&#xe654;</i>添加</button>
<button class="layui-btn" lay-event="update"><i class="layui-icon">&#xe642;</i>修改</button>
<button class="layui-btn layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script type="text/html" id="barDemo" style="width: 200px">
<button class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修改</button>
<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<table class="layui-table" lay-filter="test"
		lay-data="{url:'checkcustomer',toolbar:'#userlist_bar',id:'userlist',page:true,}">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'customer_id',sort:true}">ID</th>
				<th lay-data="{field:'customer_name'}">客户名</th>
				<th lay-data="{field:'customer_tel'}">客户手机号</th>
				<th lay-data="{field:'customer_email'}">客户邮箱</th>
				<th lay-data="{field:'customer_addr'}">客户地址</th>
				<th lay-data="{field:'create_time_text'}">客户创建时间</th>
				<th lay-data="{field:'customer_man'}">客户联系人</th>
				<th lay-data="{field:'customer_grade'}">客户评级</th>
				<th lay-data="{field:'customer_user'}">客户业务员</th>
				<th lay-data="{field:'customer_public',templet:function(d){
				if(d.customer_public==1){
				return '是';
				}else{
				return '否';
				}
				}}">公海客户</th>
				<th lay-data="{width:190,toolbar:'#barDemo'}">操作</th>
			</tr>
		</thead>
</table>
<form class="layui-form">
		<div hidden id="update_user_div">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">客户名</label>
					<div class="layui-input-inline">
						<input type="text" id="customer_name" name="customer_name"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">客户手机号</label>
					<div class="layui-input-inline">
						<input type="text" id="customer_tel" name="customer_tel"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">客户邮箱</label>
					<div class="layui-input-inline">
						<input type="text" id="customer_email" name="customer_email"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">客户地址</label>
					<div class="layui-input-inline">
						<input type="text" id="customer_addr" name="customer_addr"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">客户联系人</label>
					<div class="layui-input-inline">
						<input type="text" id="customer_man" name="customer_man"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">客户评级</label>
					<div class="layui-input-inline">
						<input type="text" id="customer_grade" name="customer_grade"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<!-- <div class="layui-inline">
					<label class="layui-form-label">客户业务员</label>
					<div class="layui-input-inline">
						<input type="text" id="customer_user" name="customer_user"
							autocomplete="off" class="layui-input">
					</div>
				</div> -->
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
	case 'check':
		var customer_name = $("#checktext").val();
		console.log(customer_name);
		/*   layer.alert(username); */
		table.reload("userlist", {
			url : "checkcustomer2",
			where : {
				"customer_name" : customer_name
			}
		});
		break;
	case 'delete':
		  var checkData = table.checkStatus("userlist").data;
    	  if(checkData.length>0){
				//已选中
				//获取ID值--传到servlet中--修改数据
				var checkID = "";
				var customer_name="";
				for(var i=0;i<checkData.length;i++){
						checkID=checkID+checkData[i].customer_id+",";
						customer_name=customer_name+checkData[i].customer_name+",";
						}
				console.log(checkID);
				console.log(customer_name);
				layer.confirm('真的要将角色：“'+customer_name+'”进行删除吗？',function(index){
					console.log(checkID);
					$.post("delcustomer",{
							"customer_id":checkID					
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
		$("#customer_tel").val("");
		$("#customer_name").val("");
		$("#customer_addr").val("");
		$("#customer_email").val("");
		$("#customer_man").val("");
		$("#customer_grade").val("");
		layer.open({
			type : 1,
			title : "添加客户",
			content : $("#update_user_div"),
			btn : [ "保存", "关闭" ],
			btn1 : function() {
				$.post("addcustomer", {
					"customer_tel" : $("#customer_tel").val(),
					"customer_name" : $("#customer_name").val(),
					"customer_addr" : $("#customer_addr").val(),
					"customer_email" : $("#customer_email").val(),
					"customer_man" : $("#customer_man").val(),
					"customer_grade" : $("#customer_grade").val()
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
    		  var customer_id=checkData[0].customer_id;
    			console.log(customer_id);
				console.log(checkData);
				$("#customer_name").val(checkData[0].customer_name);
				$("#customer_tel").val(checkData[0].customer_tel);
				$("#customer_addr").val(checkData[0].customer_addr);
				$("#customer_email").val(checkData[0].customer_email);
				$("#customer_man").val(checkData[0].customer_man);
				$("#customer_grade").val(checkData[0].customer_grade);
				$("#customer_user").val(checkData[0].customer_user);
    		  layer.open({
					type : 1,
					title : "修改信息",
					content : $("#update_user_div"),
					btn : [ "保存", "关闭" ],
					btn1 : function() {
						$.post("updatecus", {
							"customer_id" : customer_id,
							"customer_tel" : $("#customer_tel").val(),
							"customer_name" : $("#customer_name").val(),
							"customer_addr" : $("#customer_addr").val(),
							"customer_email" : $("#customer_email").val(),
							"customer_man" : $("#customer_man").val(),
							"customer_grade" : $("#customer_grade").val(),
							"customer_user" : $("#customer_user").val()
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
	var customer_id = data.customer_id;
	console.log(data);
	//console.log(obj)
	var customer_name = data.customer_name;
	if (obj.event === 'update') {
		$("#customer_name").val(data.customer_name);
		$("#customer_tel").val(data.customer_tel);
		$("#customer_addr").val(data.customer_addr);
		$("#customer_email").val(data.customer_email);
		$("#customer_man").val(data.customer_man);
		$("#customer_grade").val(data.customer_grade);
		$("#customer_user").val(data.customer_user);
		console.log(customer_name);
		//弹出对话框
		layer.open({
			type : 1,
			title : "修改信息",
			content : $("#update_user_div"),
			btn : [ "保存", "关闭" ],
			btn1 : function() {
				$.post("updatecus", {
					"customer_id" : customer_id,
					"customer_tel" : $("#customer_tel").val(),
					"customer_name" : $("#customer_name").val(),
					"customer_addr" : $("#customer_addr").val(),
					"customer_email" : $("#customer_email").val(),
					"customer_man" : $("#customer_man").val(),
					"customer_grade" : $("#customer_grade").val(),
					"customer_user" : $("#customer_user").val()
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
		var customer_id = data.customer_id;
		console.log(data);
		//console.log(obj)
		var customer_name = data.customer_name;
		console.log(customer_name);
		layer.confirm('真的要将用户：“'+customer_name+'”进行删除吗？',function(index){
			console.log(customer_id);
			$.post("delcustomer",{
					"customer_id":customer_id					
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