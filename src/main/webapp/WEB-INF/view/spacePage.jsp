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
	<script type="text/javascript">
		var msg = "${message}";
		if (msg == "1") {
			alert('修改新停车场信息成功');
			window.location.replace("manageLotPage")
		} else if (mesg == "2") {
			alert('修改新停车场信息失败');
			window.location.replace("manageLotPage")
		}
	</script>
	<div class="page">
		<header class="header"> <nav class="navbar">
		<div class="container-fluid">
			<div
				class="navbar-holder d-flex align-items-center justify-content-between">
				<div class="navbar-header">
					<a href="mainPage" class="navbar-brand d-none d-sm-inline-block">
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
					<h1 class="h4">${admin_name}</h1>
				</div>
			</div>
			<span class="heading">Main</span>
			<ul class="list-unstyled">
				<li><a href="mainPage"> <i class="icon-home"></i>停车场主页
				</a></li>
				<li><a href="#lotManager" aria-expanded="false"
					data-toggle="collapse"> <i class="icon-interface-windows"></i>停车场管理
				</a>
					<ul id="lotManager" class="collapse list-unstyled ">
						<li><a href="insertLotPage">新增停车场信息</a></li>
						<li><a href="manageLotPage">管理停车场信息</a></li>
					</ul></li>
				<li><a href="recordPage"> <i class="icon-padnote"></i>收入记录
				</a></li>
				<li><a href="insertPage"> <i class="icon-user"></i>新增管理员用户
				</a></li>
				<li><a href="updatePage"> <i class="icon-grid"></i>个人信息修改
				</a></li>
				<li><a href="logout"> <i class="icon-close"></i>退出登录
				</a></li>
			</ul>
			<span class="heading">Extras</span> </nav>
			<div class="content-inner">
				<div style="width: 100%; heigth: 100%">
					<div class="card">
						<div class="card-body">
							<div class="row">
								<div style="width: 100%; heigth: 100%">
									<div class="card">
										<table class="table table-hover table-bordered" id="lotsTable">
											<thead>
												<tr>
													<th>停车场ID</th>
													<th>停车场名字</th>
													<th>停车场状态</th>
													<th>停车场价格</th>
													<th>免费时段</th>
													<th>操作</th>
												</tr>
											</thead>
											<c:forEach var="lot_list" items="${lot_list}">
												<tr>
													<td>${lot_list.lot_id }</td>
													<td>${lot_list.lot_name }</td>
													<td><c:choose>
															<c:when test="${lot_list.lot_status==0}">运营中</c:when>
															<c:when test="${lot_list.lot_status==1}">暂停使用</c:when>
														</c:choose></td>
													<td>${lot_list.lot_price }</td>
													<td>${lot_list.lot_free_start }~${lot_list.lot_free_end }</td>
													<td>
														<button id="update" type="button"
															onclick="updateModal(this)"
															class="btn btn-warning btn-sm" data-toggle="modal">修改</button>
													</td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">修改停车场信息</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form name="lotForm" id="lotForm" action="updateLot" method="post"
					class="form-validate">
					<div class="modal-body">
						停车场ID： <input id="lot_id" type="text" name="lot_id" readonly>
					</div>
					<div class="modal-body">
						停车场名字： <input id="lot_name" type="text" name="lot_name">
					</div>
					<div class="modal-body">
						价格： <input id="lot_price" type="text" name="lot_price">
					</div>
					<div class="modal-body">
						停车场状态： <select name="lot_status" id="lot_status">
							<option>运营中</option>
							<option>暂停使用</option>
						</select>
					</div>
					<div class="modal-body">
						免费时段：
						<div></div>
						<input id="lot_free_start" type="text" name="lot_free_start">~
						<div></div>
						<input id="lot_free_end" type="text" name="lot_free_end">
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-success"
							onclick="return validateForm()">提交</button>
					</div>
				</form>
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
	<script type="text/javascript">
		function updateModal(obj) {
			$("#updateModal").modal('show');
			var $td = $(obj).parents('tr').children('td');
			var lot_id = $td.eq(0).text();
			var lot_name = $td.eq(1).text();
			var lot_status = $td.eq(2).text();
			var lot_price = $td.eq(3).text();
			var lot_span = $td.eq(4).text();
			var lot_free_start = lot_span.substring(0, 8);
			var lot_free_end = lot_span.substring(9, 17);
			$("#lot_id").val(lot_id);
			$("#lot_name").val(lot_name);
			$("#lot_status").val(lot_status);
			$("#lot_price").val(lot_price);
			$("#lot_free_start").val(lot_free_start);
			$("#lot_free_end").val(lot_free_end);
		}
	</script>
	<script>
		function validateForm() {
			var lot_name = document.forms["inputForm"]["lot_name"].value;
			var lot_price = document.forms["inputForm"]["lot_price"].value;
			var lot_free_start = document.forms["inputForm"]["lot_free_start"].value;
			var lot_free_end = document.forms["inputForm"]["lot_free_end"].value;
			var lot_status = document.forms["inputForm"]["lot_status"].value;
			if (lot_name == null || lot_name == "" || lot_price == null
					|| lot_price == "" || lot_free_start == null
					|| lot_free_start == "" || lot_free_end == null
					|| lot_free_end == "" || lot_status == null
					|| lot_status == "") {
				alert("内容需填写完整");
				return false;
			}

			var myreg = /^([012][0-9])\:([0-5][0-9]):([0-5][0-9])$/;
			if (!myreg.test(lot_free_start) || !myreg.test(lot_free_end)) {
				alert("免费时间段格式：HH:MM:SS(12:00:00)");
				return false;
			}

			myreg = /^(([1-9]{1}\d{0,5})|(0{1}))(\.\d{0,2})?$/;
			if (!myreg.test(lot_price)) {
				alert("价格格式：xxxxx.xx(1.50)");
				return false;
			}
		}
	</script>
</body>
</html>