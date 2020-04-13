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
<title>部门管理页面</title>
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body>
<script type="text/html" id="userlist_bar">
<input type="text" id="checktext" placeholder="请输入索要查询的部门名"/>
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
		lay-data="{url:'checkbumen',toolbar:'#userlist_bar',id:'userlist',page:true,}">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'bmid',sort:true}">ID</th>
				<th lay-data="{field:'bmname'}">部门名称</th>
				<th lay-data="{field:'manager'}">经理</th>
				<th lay-data="{width:190,toolbar:'#barDemo'}">操作</th>
			</tr>
		</thead>
</table>
		<div hidden id="update_user_div">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">部门名称</label>
					<div class="layui-input-inline">
						<input type="text" id="bmname" name="bmname"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<form class="layui-form">
				<div class="layui-inline">
					<label class="layui-form-label">经理</label>
					<div class="layui-input-inline">
					<select id="manager" name="manager" lay-filter="Filter">
						<option value="">请选择经理</option>
					</select>
						<!-- <input type="text" id="manager" name="manager"
							autocomplete="off" class="layui-input"> -->
					</div>
				</div>
				</form>
			</div>
		</div>
		<!-- 添加弹出层 -->
		<div hidden id="update_bumen_div">
			<div class="layui-form-item">
			<div class="layui-inline">
					<label class="layui-form-label">部门ID</label>
					<div class="layui-input-inline">
						<input type="text" id="add_bmid" name="bmid"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">部门名称</label>
					<div class="layui-input-inline">
						<input type="text" id="add_bmname" name="bmname"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<form class="layui-form">
				<div class="layui-inline">
					<label class="layui-form-label">经理</label>
					<div class="layui-input-inline">
					<select id="add_manager" name="manager" lay-filter="Filter">
						<option value="">请选择经理</option>
					</select>
						<!-- <input type="text" id="manager" name="manager"
							autocomplete="off" class="layui-input"> -->
					</div>
				</div>
				</form>
			</div>
		</div>
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
		var bmname = $("#checktext").val();
		console.log(bmname);
		/*   layer.alert(username); */
		table.reload("userlist", {
			url : "checkbumen2",
			where : {
				"bmname" : bmname
			}
		});
		break;
	case 'delete':
		  var checkData = table.checkStatus("userlist").data;
    	  if(checkData.length>0){
				//已选中
				//获取ID值--传到servlet中--修改数据
				var checkID = "";
				var bmname="";
				for(var i=0;i<checkData.length;i++){
						checkID=checkID+checkData[i].bmid+",";
						bmname=bmname+checkData[i].bmname+",";
						}
				console.log(checkID);
				console.log(bmname);
				layer.confirm('真的要将角色：“'+bmname+'”进行删除吗？',function(index){
					console.log(checkID);
					$.post("delbumen",{
							"bmid":checkID					
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
		$("#bmname").val("");
		$("#manager").val("");
		layer.open({
			type : 1,
			title : "添加部门",
			content : $("#update_bumen_div"),
			btn : [ "保存", "关闭" ],
			area: ['560px', '460px'],
			btn1 : function() {
				$.post("addbumen", {
					"bmid":$("#add_bmid").val(),
					"bmname" : $("#add_bmname").val(),
					"manager" : $("#add_manager").val()
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
    		  var bmid=checkData[0].bmid;
    			console.log(bmid);
				console.log(checkData);
				$("#bmname").val(checkData[0].bmname);
				$("#manager").val("");
    		  layer.open({
					type : 1,
					title : "修改信息",
					content : $("#update_user_div"),
					btn : [ "保存", "关闭" ],
					area: ['560px', '460px'],
					btn1 : function() {
						$.post("updatebumen", {
							"bmid" : bmid,
							"bmname" : $("#bmname").val(),
							"manager" : $("#manager").val()
						}, function() {
							console.log($("#manager").val());
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
	var bmid = data.bmid;
	console.log(data);
	//console.log(obj)
	var bmname = data.bmname;
	if (obj.event === 'update') {
		$("#bmname").val(data.bmname);
		$("#manager").val("");
		console.log(bmname);
		//弹出对话框
		layer.open({
			type : 1,
			title : "修改信息",
			content : $("#update_user_div"),
			btn : [ "保存", "关闭" ],
			area: ['560px', '460px'],
			btn1 : function() {
				$.post("updatebumen", {
					"bmid" : bmid,
					"bmname" : $("#bmname").val(),
					"manager" : $("#manager").val()
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
		var bmid = data.bmid;
		console.log(data);
		//console.log(obj)
		var bmname = data.bmname;
		console.log(bmname);
		layer.confirm('真的要将用户：“'+bmname+'”进行删除吗？',function(index){
			console.log(bmid);
			$.post("delbumen",{
					"bmid":bmid					
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
layui.use([ 'form', 'upload', 'layer' ], function() {

	var form = layui.form;
	//检查项目添加到下拉框中
	$.ajaxSettings.async = false;
	$.ajax({
		url : 'checkusername',
		dataType : 'json',
		type : 'post',
		success : function(d) {
			console.log(d);
			for (var i = 0; i < d.data.length; i++) {
				
				//console.log(123)
				$('select').append(
						"<option  value='" + d.data[i].username + "'>"
								+ d.data[i].username + "</option>");
				layui.form.render();
			}
		/* 	$.each(d.data, function(index, item) {
				console.log(d.data);
				
				 $('#manager').append(
						new Option(item)); // 下拉菜单里添加元素
			}); */
			layui.form.render();
			//重新渲染 固定写法
		}
	})
});
</script>
</body>
</html>