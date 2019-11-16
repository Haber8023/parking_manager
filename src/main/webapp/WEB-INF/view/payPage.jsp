<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>智能停车场管理系统</title>
<meta name="description" content="">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="robots" content="all,follow">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/css/fontastic.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/css/style.default.css"
	id="theme-stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/lib/css/custom.css">
<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/lib/img/favicon.ico">
</head>
<body>
	<div class="page">
		<header class="header"> <nav class="navbar">
		<div class="container-fluid">
			<div
				class="navbar-holder d-flex align-items-center justify-content-between">
				<div class="navbar-header">
					<a href="check_all" class="navbar-brand d-none d-sm-inline-block">
						<div class="brand-text d-none d-lg-inline-block">Parking
							Manager</div>
						<div class="brand-text d-none d-sm-inline-block d-lg-none">
							<strong>PM</strong>
						</div>
					</a> <a id="toggle-btn" href="#" class="menu-btn active"> <span></span><span></span><span></span>
					</a>
				</div>
				<ul
					class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
					<li class="nav-item"><a href="logout" class="nav-link logout">
							<span class="d-none d-sm-inline">返回登录界面</span><i
							class="fa fa-sign-out"></i>
					</a></li>
				</ul>
			</div>
		</div>
		</nav> </header>
		<div class="page-content d-flex align-items-stretch">
			<nav class="side-navbar">
			<div class="sidebar-header d-flex align-items-center">
				<div class="title">
					<p>欢迎您：</p>
					<h1 class="h4">游客用户</h1>
				</div>
			</div>
			<span class="heading">Main</span>
			<ul class="list-unstyled">
				<li class="active"><a href="check_all"> <i
						class="icon-padnote"></i>返回上页
				</a></li>
			</ul>
			</nav>
			<div class="content-inner">
				<div style="width: 100%; heigth: 100%">
					<div class="card">
						<div class="card-body">
							<form class="form-horizontal" name="inputForm" id="inputForm"
								action="https://bufpay.com/api/pay/95477"  onsubmit="return validateForm()" method="post">
								<div class="form-group row">
									<label class="col-sm-3 form-control-label">停车场名字：${lot_name }</label>
								</div>
								<div class="form-group row">
									<label class="col-sm-3 form-control-label">车位ID：${space_id }</label>
								</div>
								<div class="form-group row">
									<label class="col-sm-3 form-control-label">停入时间：${record_time_in }</label>
								</div>
								<div class="form-group row">
									<label class="col-sm-3 form-control-label">驶出时间：${record_time_out }</label>
								</div>
								<div class="form-group row">
									<label class="col-sm-3 form-control-label">应付金额：${amount }</label>
								</div>
								<div class="line"></div>
								<input type="hidden" name="name" id="name" value="停车金额" />
								<input type="hidden" name="pay_type" id="pay_type" value="wechat" />
								<input type="hidden" name="price" id="price" value=${amount } />
								<input type="hidden" name="order_id" id="order_id" value=${record_id } />
								<input type="hidden" name="order_uid" id="order_uid" value="" />
								<input type="hidden" name="secret" id="secret" value="5b83f5b45f534dbc9789a4a65fbbc56c" />
								<input type="hidden" name="notify_url" id="notify_url" value="http://localhost:8080/parking_manager/pay_result" />
								<input type="hidden" name="return_url" id="return_url" value="http://localhost:8080/parking_manager/pay_result" />
								<input type="hidden" name="sign" id="sign" />
								<div class="form-group row">
									<div class="col-md-4 offset-sm-5">
										<button type="submit" class="btn btn-primary">确认支付</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="<%=request.getContextPath()%>/lib/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/lib/vendor/popper.js/umd/popper.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/lib/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/lib/vendor/jquery.cookie/jquery.cookie.js"></script>
	<script
		src="<%=request.getContextPath()%>/lib/vendor/chart.js/Chart.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/lib/vendor/jquery-validation/jquery.validate.min.js"></script>
	<script src="<%=request.getContextPath()%>/lib/js/front.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/lib/js/md5.js"></script>
	<script type="text/javascript">
		var name = document.forms["inputForm"]["name"].value;
		var pay_type = document.forms["inputForm"]["pay_type"].value;
		var price = document.forms["inputForm"]["price"].value;
		var order_id = document.forms["inputForm"]["order_id"].value;
		var order_uid = document.forms["inputForm"]["order_uid"].value;
		var secret = document.forms["inputForm"]["secret"].value;
		var notify_url = document.forms["inputForm"]["notify_url"].value;
		var return_url = document.forms["inputForm"]["return_url"].value;
		var sign = $.md5(name+pay_type+price+order_id+order_uid+notify_url+return_url+secret);
		$("#sign").val(sign);
	</script>
		<script>
		function validateForm() {
			var price = document.forms["inputForm"]["price"].value;
			if (price  == "0.0") {
				document.getElementById("inputForm").action="pay_result";
			}
			else{
				document.getElementById("inputForm").action="https://bufpay.com/api/pay/95477";
			}
			return true;
		}
	</script>

</body>
</html>
