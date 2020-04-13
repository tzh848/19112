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
<title>私人客户管理页面</title>
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body>
<script type="text/html" id="userlist_bar">
<input type="text" id="checktext" placeholder="请输入索要查询的客户名"/>
<button class="layui-btn" lay-event="check"><i class="layui-icon layui-icon-survey"></i>查询</button>
<button class="layui-btn layui-btn-danger" lay-event="giveup"><i class="layui-icon">&#xe640;</i>放弃跟单</button>
<button class="layui-btn layui-btn-warm" lay-event="huifang"><i class="layui-icon">&#xe626;</i>回访</button>
<button class="layui-btn layui-btn-normal" lay-event="youjian"><i class="layui-icon">&#xe618;</i>选中发送邮件</button>
<button class="layui-btn layui-btn-normal" lay-event="youjianall"><i class="layui-icon">&#xe609;</i>全部发送邮件</button>
</script>
<script type="text/html" id="barDemo" style="width: 200px">
<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="giveup"><i class="layui-icon">&#xe640;</i>放弃跟单</button>
<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="huifang"><i class="layui-icon">&#xe626;</i>回访</button>
</script>
<table class="layui-table" lay-filter="test"
		lay-data="{url:'checkprivatecus',toolbar:'#userlist_bar',id:'userlist',page:true,}">
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
				<th lay-data="{width:200,toolbar:'#barDemo'}">操作</th>
			</tr>
		</thead>
</table>

	<div hidden id="update_user_div">
		<form class="layui-form">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">客户姓名</label>
					<div class="layui-input-inline">
						<input type="text" id="visit_customer_name" name="visit_customer_name"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">业务员姓名</label>
					<div class="layui-input-inline">
						<input type="text" id="visit_user_name" name="visit_user_name"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">联系人姓名</label>
					<div class="layui-input-inline">
						<input type="text" id="visit_info" name="visit_info"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">回访方式</label>
					<div class="layui-input-inline">
						<select id="visit_pattern" name="visit_pattern" lay-filter="Filter">
						<option value="">请选择回访方式</option>
						<option value="邮箱">邮箱</option>
        				<option value="电话">电话</option>
        				<option value="短信">短信</option>
       					<option value="面谈">面谈</option>
					</select>
						<!-- <input type="text" id="visit_pattern" name="visit_pattern"
							autocomplete="off" class="layui-input"> -->
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">是否付款</label>
					<div class="layui-input-inline">
							<input type="radio" name="visit_pay" value="是" title="是"> 
							<input type="radio" name="visit_pay" value="否" title="否">
						<!-- <input type="text" id="visit_pay" name="visit_pay"
							autocomplete="off" class="layui-input"> -->
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">付款金额</label>
					<div class="layui-input-inline">
						<input type="text" id="visit_money" name="visit_money"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<!-- 发送邮件  -->
	<div hidden id="update_email_div">
		<form class="layui-form form-visit" lay-filter="visit_email">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">标题</label>
					<div class="layui-input-inline">
						<input type="text" id="title" name="title"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">邮件内容</label>
					<div class="layui-input-block">
						<textarea name="info" id="info" placeholder="请输入邮件内容" class="layui-textarea"></textarea>
					</div>
				</div>
		</form>
	</div>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="./layui/layui.all.js"></script>
<script type="text/javascript">
var table = layui.table;
var layer = layui.layer;
var model = layui.model;
var form=layui.form;
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
			url : "checkprivatecus2",
			where : {
				"customer_name" : customer_name,
				"customer_user":'${sessionScope.username}'	
			}
		});
		break;
	case 'giveup':
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
				layer.confirm('确定要对“'+customer_name+'”客户放弃跟单吗？',function(index){
					console.log(checkID);
					console.log('${sessionScope.username}'); 
					$.post("giveup",{
							"customer_id":checkID	
							},function(){
								//关闭窗口,刷新列表
								/* layer.closeAll(); */
								layer.msg("已放弃跟单");
								table.reload("userlist");
								});
						layer.close(index);
					});
			
			}else{
				alert("请先选中数据！");
			}
		break;
	case 'youjian':
		 var checkData = table.checkStatus("userlist").data;
  	  if(checkData.length>0){
  		layer.open({
			type : 1,
			title : "发送邮件",
			area: ['700px', '480px'],
			content : $("#update_email_div"),
			btn : [ "发送", "取消" ],
			btn1 : function() {
				var formdata=form.val("visit_email");
				var customer_email_arr="";
				for(var i=0;i<checkData.length;i++){
						checkID=checkID+checkData[i].customer_id+",";
						customer_email_arr=customer_email_arr+checkData[i].customer_email+",";
						}
				formdata.email_arr=customer_email_arr;
				console.log(formdata);
				$.post("visit_selected_email",formdata, function(d) {
					
					//关闭窗口，刷新列表
					layer.closeAll();
					layer.msg("成功发送邮件",{
						icon:6
						});
					table.reload("userlist");
				});
			}
		})
			
			}else{
				alert("请先选中数据！");
			}
		break;
	case 'youjianall':
		 var checkData = table.checkStatus("userlist").data;
 		layer.open({
			type : 1,
			title : "发送邮件",
			area: ['700px', '480px'],
			content : $("#update_email_div"),
			btn : [ "发送", "取消" ],
			btn1 : function() {
				var formdata=form.val("visit_email");
				$.post("visit_all_email",formdata, function(d) {
					//关闭窗口，刷新列表
					layer.closeAll();
					layer.msg("成功发送邮件",{
						icon:6
						});
					table.reload("userlist");
				});
			}
		})
		break;
	case 'huifang':
		var checkData = table.checkStatus("userlist").data;
		console.log(checkData);
  	  if(checkData.length==1){
  		$("#visit_customer_name").val(checkData[0].customer_name);
		$("#visit_user_name").val(checkData[0].customer_user);
		$("#visit_info").val(checkData[0].customer_man);
		$("#visit_pattern").val("");
		$("#visit_money").val("");
		layer.open({
			type : 1,
			title : "回访信息",
			area: ['660px', '460px'],
			content : $("#update_user_div"),
			btn : [ "保存", "关闭" ],
			btn1 : function() {
				$.post("huifang", {
					"visit_customer_name" : $("#visit_customer_name").val(),
					"visit_user_name" : $("#visit_user_name").val(),
					"visit_info" : $("#visit_info").val(),
					"visit_pattern" : $("#visit_pattern").val(),
					"visit_money" : $("#visit_money").val(),
					"visit_pay" : $("[name='visit_pay']:checked").val()
				}, function() {
					console.log($("[name='visit_pay']:checked").val());
					//关闭窗口，刷新列表
					layer.closeAll();
					layer.msg("成功添加回访信息");
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
	if (obj.event === 'giveup') {
		console.log(customer_name);
		//弹出对话框
		layer.confirm('确定要对“'+customer_name+'”客户放弃跟单吗？',function(index){
			console.log('${sessionScope.username}'); 
			$.post("giveup",{
				"customer_id":customer_id	
				},function(){
					//关闭窗口,刷新列表
					/* layer.closeAll(); */
					layer.msg("已放弃跟单");
					table.reload("userlist");
					});
				layer.close(index);
			});
	}  else if (obj.event === 'huifang') {
		$("#visit_customer_name").val(data.customer_name);
		$("#visit_user_name").val(data.customer_user);
		$("#visit_info").val(data.customer_man);
		$("#visit_pattern").val("");
		$("#visit_money").val("");
		layer.open({
			type : 1,
			title : "回访信息",
			area: ['660px', '460px'],
			content : $("#update_user_div"),
			btn : [ "保存", "关闭" ],
			btn1 : function() {
				$.post("huifang", {
					"visit_customer_name" : $("#visit_customer_name").val(),
					"visit_user_name" : $("#visit_user_name").val(),
					"visit_info" : $("#visit_info").val(),
					"visit_pattern" : $("#visit_pattern").val(),
					"visit_money" : $("#visit_money").val(),
					"visit_pay" : $("[name='visit_pay']:checked").val()
				}, function() {
					console.log($("[name='visit_pay']:checked").val());
					//关闭窗口，刷新列表
					layer.closeAll();
					layer.msg("成功添加回访信息");
					table.reload("userlist");
				});
			}
		})
		}	
});
</script>
</body>
</html>