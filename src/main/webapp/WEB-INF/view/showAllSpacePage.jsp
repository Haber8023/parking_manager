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
						<form>
							<div class="card-body">
								<div class="row">
									<div style="width: 100%; heigth: 100%">
										<div class="card">
											<table class="table table-hover table-bordered"
												id="lotsTable">
												<thead>
													<tr>
														<th>车位ID</th>
														<th>车位状态</th>
														<th>车位操作</th>
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
														<td><c:choose>
																<c:when test="${space_list.space_status==1}">
																	<button id="pay" type="button" onclick="payModal(this)"
																		class="btn btn-success btn-sm" data-toggle="modal">付款</button>
																</c:when>
																<c:when test="${space_list.space_status==0}">
																	<button type="button" class="btn btn-default btn-sm"
																		disabled>无法付款</button>
																</c:when>
																<c:when test="${space_list.space_status==2}">
																	<button type="button" class="btn btn-default btn-sm"
																		disabled>无法付款</button>
																</c:when>
															</c:choose></td>
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
	<div class="modal fade" id="payModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">确认车位信息</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form name="payForm" id="payForm" action="pay_for_space"
					method="post" class="form-validate">
					<div class="modal-body">停车场名字：${lot_name }</div>
					<div class="modal-body">
						车位ID： <input style="border: none;" id="space_id" type="text" name="space_id" readonly>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-success"
							onclick="show_all_space">确认</button>
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
		function payModal(obj) {
			$("#payModal").modal('show');
			var $td = $(obj).parents('tr').children('td');
			var space_id = $td.eq(0).text();
			$("#space_id").val(space_id);
		}
	</script>
</body>
</html>