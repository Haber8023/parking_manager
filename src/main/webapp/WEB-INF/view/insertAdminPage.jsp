<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			alert('添加新管理员成功');
			window.location.replace("insertPage")
		} else if (mesg == "2") {
			alert('添加新管理员失败');
			window.location.replace("insertPage")
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
						<li><a href="manageLotPage">管理停车场信息</a></li>
					</ul></li>
				<li><a href="recordPage"> <i class="icon-padnote"></i>收入记录
				</a></li>
				<li class="active"><a href="insertPage"> <i
						class="icon-user"></i>新增管理员用户
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

							<form class="form-horizontal" name="inputForm"
								action="insertAdmin" onsubmit="return validateForm()"
								method="post">
<label class="col-sm-3 form-control-label"
										style="font-size: 20px;""><b>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;新增管理员用户</b></label>
								<div class="block">
									<label class="col-sm-3 form-control-label"><b>管理员用户名</b></label>

									<input id="admin_name_input" type="text" style="width: 300px;"
										name="admin_name_input" class="form-control">

								</div>
								<div class="block">
									<label class="col-sm-3 form-control-label"><b>密码</b></label> <input
										id="admin_psw_input" type="password" style="width: 300px;"
										name="admin_psw_input" class="form-control">

								</div>
								<div class="block">
									<label class="col-sm-3 form-control-label"><b>确认密码</b></label>

									<input id="psw_confirm" type="password" name="psw_confirm"
										style="width: 300px;" class="form-control">

								</div>

								<div class="line"></div>
								<div class="cxbottom">


									<h1>&ensp;</h1>

								</div>

								<div class="form-group row" syle="position:absolute;left:100px;">
									<h1>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;</h1>
									<button type="submit" class="btn btn-primary">提交</button>

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
	<script>
		function validateForm() {
			var admin_name = document.forms["inputForm"]["admin_name_input"].value;
			var password = document.forms["inputForm"]["admin_psw_input"].value;
			var password_confirm = document.forms["inputForm"]["psw_confirm"].value;

			if (admin_name == null || admin_name == "" || password == null
					|| password == "" || password_confirm == null
					|| password_confirm == "") {
				alert("信息需填写完整");
				return false;
			} else if (password != password_confirm) {
				alert("两次输入的密码不同");
				return false;
			}

		}
	</script>
</body>
</html>