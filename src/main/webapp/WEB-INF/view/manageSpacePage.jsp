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
			alert('修改车位信息成功');
		}
		if (msg == "2") {
			alert('删除车位信息成功');
		}
		if (msg == "-1") {
			alert('操作失败');
			window.location.replace("manageSpacePage");
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
							<span class="d-none d-sm-inline">退出登录</span><i
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
						<li class="active"><a href="manageLotPage">管理停车场信息</a></li>
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
													<th>车位ID</th>
													<th>车位状态</th>
													<th>操作</th>
												</tr>
											</thead>
											<c:forEach var="space_list" items="${space_list}">
												<tr>
													<td>${space_list.space_id }</td>
													<td><c:choose>
															<c:when test="${space_list.space_status==0}">空闲</c:when>
															<c:when test="${space_list.space_status==1}">占用</c:when>
															<c:when test="${space_list.space_status==2}">维护</c:when>
														</c:choose></td>
													<td>
														<button id="update" type="button"
															onclick="updateModal(this)"
															class="btn btn-warning btn-sm" data-toggle="modal">修改</button>
														<button id="manageSpace" type="button"
															onclick="deleteModal(this)" class="btn btn-danger btn-sm"
															data-toggle="modal">删除</button>
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
					<h4 class="modal-title" id="myModalLabel">修改车位信息</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form name="spaceForm" id="spaceForm" action="updateSpace"
					method="post" class="form-validate">
					<div class="modal-body">
						车位ID： <input style="border: none;" style="border: none;" id="space_id" type="text" name="space_id" readonly>
					</div>
					<div class="modal-body">
						车位状态： <select name="space_status" id="space_status">
							<option>空闲</option>
							<option>占用</option>
							<option>维护</option>
						</select>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-success"
							onclick="return validateForm()">提交</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">删除车位信息</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form name="lotForm" id="lotForm" action="deleteSpace" method="post"
					class="form-validate">
					<div class="modal-body">确认删除？操作不可恢复！</div>
					<div class="modal-body">
						停车场ID： <input style="border: none;" id="space_id_delete" type="text"
							name="space_id_delete" readonly>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">删除</button>
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
			var space_id = $td.eq(0).text();
			var space_status = $td.eq(1).text();
			$("#space_id").val(space_id);
			$("#space_status").val(space_status);
		}
	</script>
	<script>
		function deleteModal(obj) {
			$("#deleteModal").modal('show');
			var $td = $(obj).parents('tr').children('td');
			var space_id_delete = $td.eq(0).text();
			$("#space_id_delete").val(space_id_delete);
		}
	</script>
	<script>
		function validateForm() {
			var space_id = document.forms["spaceForm"]["space_id"].value;
			var space_status = document.forms["spaceForm"]["space_status"].value;
			if (space_id == null || space_id == "" || space_status == null
					|| space_status == "") {
				alert("内容需填写完整");
				return false;
			}
		}
	</script>
</body>
</html>