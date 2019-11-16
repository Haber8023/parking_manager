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
			</nav>
			<div class="content-inner">
				<div style="width: 100%; heigth: 100%">
					<div class="card">
						<form>
							<div class="card-body">
								<div class="row">
									<div style="width: 100%; heigth: 100%">
										<div class="card">
											<table class="table table-hover table-bordered"
												id="lotsTable">
												<thead>
													<tr>
														<th>停车场ID</th>
														<th>停车场名字</th>
														<th>停车场状态</th>
														<th>停车场价格</th>
														<th>免费时段</th>
														<th>查询车位情况</th>
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
															<button id="query" type="button"
																onclick="queryModal(this)"
																class="btn btn-success btn-sm" data-toggle="modal">查询</button>
														</td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="queryModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">确认停车场信息</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form name="lotForm" id="lotForm" action="show_all_space"
					method="post" class="form-validate">
					<div class="modal-body">
						停车场ID： <input style="border: none;" id="lot_id" type="text" name="lot_id" readonly>
					</div>
					<div class="modal-body">
						停车场名字： <input style="border: none;" id="lot_name" type="text" name="lot_name" readonly>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-success"
							onclick="show_all_space">确认查询</button>
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
		function queryModal(obj) {
			$("#queryModal").modal('show');
			var $td = $(obj).parents('tr').children('td');
			var lot_id = $td.eq(0).text();
			var lot_name = $td.eq(1).text();
			$("#lot_id").val(lot_id);
			$("#lot_name").val(lot_name);
		}
	</script>
</body>
</html>