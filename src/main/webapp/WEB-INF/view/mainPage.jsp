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
				<li class="active"><a href="mainPage"> <i class="icon-home"></i>停车场主页
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
				<section class="dashboard-counts no-padding-bottom">
				<div class="container-fluid">
					<div class="row bg-white has-shadow">
						<div class="col-xl-3 col-sm-3">
							<div class="item d-flex align-items-center">
								<div class="icon bg-violet"></div>
								<div class="title">
									<span>今日收入</span>
									<div></div>
								</div>
								<div class="title">
									<strong>${today_bonus}元</strong>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-sm-3">
							<div class="item d-flex align-items-center">
								<div class="icon bg-blue"></div>
								<div class="title">
									<span>本月收入</span>
									<div></div>
								</div>
								<div class="title">
									<strong>${month_bonus}元</strong>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-sm-3">
							<div class="item d-flex align-items-center">
								<div class="icon bg-green"></div>
								<div class="title">
									<span>本年收入</span>
									<div></div>
								</div>
								<div class="title">
									<strong>${year_bonus}元</strong>
								</div>
							</div>
						</div>
					</div>
				</div>
						</section>
							<section class="dashboard-counts no-padding-bottom">
				<div class="chart col-lg-6 col-12">
					<div class="line-chart bg-white d-flex align-items-center justify-content-center has-shadow">
						<canvas id="lineChart"> </canvas>
					</div>
				</div>
			
				</section>

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
		var legendState = true;
		if ($(window).outerWidth() < 576) {
			legendState = false;
		}

		var LINECHART = $('#lineChart');
		var myLineChart = new Chart(LINECHART, {
			type : 'line',
			options : {
				scales : {
					xAxes : [ {
						display : true,
						gridLines : {
							display : false
						}
					} ],
					yAxes : [ {
						display : true,
						gridLines : {
							display : false
						}
					} ]
				},
				legend : {
					display : legendState
				}
			},
			data : {
				labels : ${week_bonus_time},
				datasets : [ {
					label : "近七天收入",
					fill : true,
					lineTension : 0,
					backgroundColor : "transparent",
					borderColor : '#0066FF',
					pointBorderColor : '#0066FF',
					pointHoverBackgroundColor : '#0066FF',
					borderCapStyle : 'butt',
					borderDash : [],
					borderDashOffset : 0.0,
					borderJoinStyle : 'miter',
					borderWidth : 1,
					pointBackgroundColor : "#fff",
					pointBorderWidth : 1,
					pointHoverRadius : 5,
					pointHoverBorderColor : "#fff",
					pointHoverBorderWidth : 2,
					pointRadius : 1,
					pointHitRadius : 0,
					data : ${week_bonus_bonus},
					spanGaps : false
				} ]
			}
		});
	</script>
</body>
</html>