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
<title>公海客户管理页面</title>
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body>
<script type="text/html" id="userlist_bar">
<input type="text" id="checktext" placeholder="请输入索要查询的客户名"/>
<button class="layui-btn" lay-event="check"><i class="layui-icon layui-icon-survey"></i>查询</button>
<button class="layui-btn" lay-event="gendan"><i class="layui-icon">&#xe654;</i>跟单</button>
</script>
<script type="text/html" id="barDemo" style="width: 200px">
<button class="layui-btn layui-btn-sm" lay-event="gendan"><i class="layui-icon">&#xe654;</i>跟单</button>
</script>
<table class="layui-table" lay-filter="test"
		lay-data="{url:'checkpubliccus',toolbar:'#userlist_bar',id:'userlist',page:true,}">
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
				<div class="layui-inline">
					<label class="layui-form-label">客户业务员</label>
					<div class="layui-input-inline">
						<input type="text" id="customer_user" name="customer_user"
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
	case 'check':
		var customer_name = $("#checktext").val();
		console.log(customer_name);
		/*   layer.alert(username); */
		table.reload("userlist", {
			url : "checkpubliccus2",
			where : {
				"customer_name" : customer_name
			}
		});
		break;
	case 'gendan':
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
				layer.confirm('确定要对“'+customer_name+'”客户进行跟单吗？',function(index){
					console.log(checkID);
					console.log('${sessionScope.username}'); 
					$.post("gendan",{
							"customer_id":checkID,
							"customer_user":'${sessionScope.username}'			
							},function(){
								//关闭窗口,刷新列表
								/* layer.closeAll(); */
								layer.msg("跟单成功");
								table.reload("userlist");
								});
						layer.close(index);
					});
			
			}else{
				alert("请先选中数据！");
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
	if (obj.event === 'gendan') {
		console.log(customer_name);
		//弹出对话框
		layer.confirm('确定要对“'+customer_name+'”客户进行跟单吗？',function(index){
			console.log('${sessionScope.username}'); 
			$.post("gendan",{
					"customer_id":customer_id,
					"customer_user":'${sessionScope.username}'			
					},function(){
						//关闭窗口,刷新列表
						/* layer.closeAll(); */
						layer.msg("跟单成功");
						table.reload("userlist");
						});
				layer.close(index);
			});
	} 	
});
</script>
</body>
</html>