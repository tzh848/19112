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
<title>回访记录页面</title>
<link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body>
<script type="text/html" id="userlist_bar">
<input type="text" id="checktext" placeholder="请输入索要查询的客户名或业务员名"/>
<button class="layui-btn" lay-event="check"><i class="layui-icon layui-icon-survey"></i>查询</button>
<button class="layui-btn layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
</script>
<script type="text/html" id="barDemo" style="width: 200px">
<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete"><i class="layui-icon">&#xe640;</i>删除</button>
<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="huifangxq"><i class="layui-icon">&#xe63a;</i>回访详情</button>
</script>
<table class="layui-table" lay-filter="test"
		lay-data="{url:'checkvisit',toolbar:'#userlist_bar',id:'userlist',page:true,}">
		<thead>
			<tr>
				<th lay-data="{type:'checkbox'}"></th>
				<th lay-data="{field:'visit_id',sort:true}">ID</th>
				<th lay-data="{field:'visit_customer_name'}">客户名</th>
				<th lay-data="{field:'visit_user_name'}">业务员名</th>
				<th lay-data="{field:'visit_time_text'}">回访时间</th>
				<th lay-data="{field:'visit_info'}">联系人</th>
				<th lay-data="{field:'visit_pattern'}">回访方式</th>
				<th lay-data="{field:'visit_pay'}">是否付款</th>
				<th lay-data="{field:'visit_money'}">付款金额</th>
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
	<!-- 回访详情弹出层 -->
	<div hidden id="visit_user_div">
	<form class="layui-form layui-form-pane">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">客户姓名</label>
					<div class="layui-input-inline">
						<input type="text" id="visit_customer_name1" disabled="disabled" name="visit_customer_name"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">业务员姓名</label>
					<div class="layui-input-inline">
						<input type="text" id="visit_user_name1" disabled="disabled" name="visit_user_name"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">联系人姓名</label>
					<div class="layui-input-inline">
						<input type="text" id="visit_info1" disabled="disabled" name="visit_info"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">回访方式</label>
					<div class="layui-input-inline">
					<input type="text" id="visit_pattern1" disabled="disabled" name="visit_pattern"
							autocomplete="off" class="layui-input">
						<!-- <select id="visit_pattern1" name="visit_pattern" lay-filter="Filter">
					</select> -->
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">是否付款</label>
					<div class="layui-input-inline">
					<input type="text" id="visit_pay1" disabled="disabled" name="visit_pay"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">付款金额</label>
					<div class="layui-input-inline">
						<input type="text" id="visit_money1" disabled="disabled" name="visit_money"
							autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
				<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">批注</label>
					<div class="layui-input-block">
						<textarea placeholder="请输入批注" class="layui-textarea"></textarea>
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
var $ = layui.jquery;
$.ajaxSettings.async = false;
table.on('toolbar(test)', function(obj) {
	var checkStatus = table.checkStatus(obj.config.id);
	switch (obj.event) {
	case 'check':
		var name = $("#checktext").val();
		console.log(name);
		/*   layer.alert(username); */
		table.reload("userlist", {
			url : "checkvisit2",
			where : {
				"name" : name	
			}
		});
		break;
	case 'delete':
		  var checkData = table.checkStatus("userlist").data;
    	  if(checkData.length>0){
    			//已选中
				//获取ID值--传到servlet中--修改数据
				var checkID = "";
				var visit_customer_name="";
				for(var i=0;i<checkData.length;i++){
						checkID=checkID+checkData[i].visit_id+",";
						visit_customer_name=visit_customer_name+checkData[i].visit_customer_name+",";
						}
				console.log(checkID);
				console.log(visit_customer_name);
				layer.confirm('真的要将客户：“'+visit_customer_name+'”的回访信息进行删除吗？',function(index){
					console.log(checkID);
					$.post("delvisit",{
							"visit_id":checkID					
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
	}
});
table.on('tool(test)', function(obj) {
	var data = obj.data;
	var visit_id = data.visit_id;
	console.log(data);
	//console.log(obj)
	var visit_customer_name = data.visit_customer_name;
	if (obj.event === 'delete') {
		console.log(visit_customer_name);
		//弹出对话框
		layer.confirm('真的要将客户：“'+visit_customer_name+'”的回访信息进行删除吗？',function(index){
			console.log(visit_id);
			$.post("delvisit",{
					"visit_id":visit_id					
					},function(){
						//关闭窗口,刷新列表
						/* layer.closeAll(); */
						layer.msg("删除成功");
						table.reload("userlist");
						});
				layer.close(index);
			});
	}  else if (obj.event === 'huifangxq') {
		$("#visit_customer_name1").val(data.visit_customer_name);
		$("#visit_user_name1").val(data.visit_user_name);
		$("#visit_info1").val(data.visit_info);
		$("#visit_pattern1").val(data.visit_pattern);
		$("#visit_money1").val(data.visit_money);
		$("#visit_pay1").val(data.visit_pay);
		layer.open({
			type : 1,
			title : "回访信息",
			area: ['700px', '480px'],
			content : $("#visit_user_div"),
			btn : [ "保存", "关闭" ],
			btn1 : function() {
				$.post("huifang3", {
					"visit_customer_name" : $("#visit_customer_name").val(),
					"visit_user_name" : $("#visit_user_name").val(),
					"visit_info" : $("#visit_info").val(),
					"visit_pattern" : $("#visit_pattern").val(),
					"visit_money" : $("#visit_money").val(),
					"visit_pay" : $("[name='visit_pay']:checked").val()
				}, function() {
					console.log($("#visit_pay1").val(data.visit_pay));
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