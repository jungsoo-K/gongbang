<%@ page contentType="text/html; charset=UTF-8" %> 
<% 
	String root = request.getContextPath(); 
	String id = (String)session.getAttribute("id");
	String grade = (String)session.getAttribute("grade");
%>
<!DOCTYPE html>
<html>
<head>
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,500,700,300,100' rel='stylesheet' type='text/css'>

    <!-- styles -->
    <link href="<%=root %>/css/font-awesome.css" rel="stylesheet">
    <link href="<%=root %>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=root %>/css/animate.min.css" rel="stylesheet">
    <link href="<%=root %>/css/owl.carousel.css" rel="stylesheet">
    <link href="<%=root %>/css/owl.theme.css" rel="stylesheet">

    <!-- theme stylesheet -->
    <link href="<%=root %>/css/style.default.css" rel="stylesheet" id="theme-stylesheet">

    <!-- your stylesheet with modifications -->
    <link href="<%=root %>/css/custom.css" rel="stylesheet">
    <script src="<%=root %>/js/respond.min.js"></script>
    <link rel="shortcut icon" href="favicon.png">
    
    <style>
    #loginForm{
    	float : right;
    	margin : 0;
    }
    
    .inputlogin{
    	width : 128px;
    }
    #top ul.menu{
    	padding:0;
    }
    .formbutton{
    	background-color: #555555 !important;
    	color : #eeeeee;
    }
    .buttonGrp{
    	float : right;
    }
    </style>
</head>
<body>

    <!-- *** TOPBAR ***
    _________________________________________________________ -->
    <div id="top">
        <div class="container">
            <div class="col-md-6 offer" data-animate="fadeInDown">
                <a href="#" class="btn btn-success btn-sm" data-animate-hover="shake">Offer of the day</a>  <a href="#">Get flat 35% off on orders over $50!</a>
            </div>
            <div class="col-md-6" data-animate="fadeInDown">
	            <form id="loginForm"action="<%=root%>/member/loginProc.jsp" method="post">
	            	<%if(id == null){ %>
						<input type="text" class="inputlogin" name="id" placeholder = "아이디">
						<input type="password" class="inputlogin" name="passwd" placeholder = "비밀번호"><br>
					<% } else { %>
						
					<%} %>
					<div class = "buttonGrp">
					<%if(id == null){ %>
						<button type="submit" class="btn btn-xs formbutton">로그인</button>
						<button type="button" onclick="location.href='<%=root%>/member/agreement.jsp'" class="btn btn-xs formbutton">회원가입</button>
					<% } else { %>
						<button type= "button" onclick = "location.href='<%=root%>/member/read.jsp'" class="btn btn-xs formbutton">내정보</button>
						<button type= "button" onclick = "location.href='<%=root%>/member/logout.jsp'" class="btn btn-xs formbutton">로그아웃</button>
						<button type="button" onclick="#" class="btn btn-xs formbutton">최근본페이지</button>
					<%} %>
					</div>
					<%-- <ul class="menu">
		                <li><a href="#" data-toggle="modal" data-target="#login-modal">Login</a></li>
		                <li><a href="<%=root%>/member/loginForm.jsp">Login</a></li>
		                <li><a href="<%=root%>/member/agreement.jsp">Register</a></li>
		                <li><a href="<%=root%>/member/contact.jsp">Contact</a></li>
		                <li><a href="#">Recently viewed</a></li>
		            </ul> --%>
				</form>
            </div>
        </div>
    </div>

    <!-- *** TOP BAR END *** -->

    <!-- *** NAVBAR ***
 _________________________________________________________ -->

    <div class="navbar navbar-default yamm" role="navigation" id="navbar">
        <div class="container">
            <div class="navbar-header">

                <a class="navbar-brand home" href="${pageContext.request.contextPath}/index.jsp" data-animate-hover="bounce">
                    <img src="<%=root %>/img/logo.png" alt="Obaju logo" class="hidden-xs">
                    <img src="<%=root %>/img/logo-small.png" alt="Obaju logo" class="visible-xs"><span class="sr-only">Obaju - go to homepage</span>
                </a>
                <div class="navbar-buttons">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-align-justify"></i>
                    </button>
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#search">
                        <span class="sr-only">Toggle search</span>
                        <i class="fa fa-search"></i>
                    </button>
                    <a class="btn btn-default navbar-toggle" href="basket.jsp">
                        <i class="fa fa-shopping-cart"></i>  <span class="hidden-xs">3 items in cart</span>
                    </a>
                </div>
            </div>
            <!--/.navbar-header -->

            <div class="navbar-collapse collapse" id="navigation">

                <ul class="nav navbar-nav navbar-left">
	                <li class="yamm-fw">
	               		<a href="<%=root%>/imgBoard/list.jsp">후기 게시판</b></a>
	               	</li>
	               	<li class="yamm-fw">
	               		<a href="<%=root%>/bbs/list.jsp">자유게시판</b></a>
	               	</li>
	               	<li class="yamm-fw">
	               		<a href="<%=root%>/guest/list.jsp">첫인사 & 잡담</b></a>
	               	</li>
<!--                     <li class="dropdown yamm-fw"> -->
<!--                         <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="200">bread <b class="caret"></b></a> -->
<!--                         <ul class="dropdown-menu"> -->
<!--                             <li> -->
<!--                                 <div class="yamm-content"> -->
<!--                                     <div class="row"> -->
<!--                                         <div class="col-sm-3"> -->
<!--                                             <h5>Clothing</h5> -->
<!--                                             <ul> -->
<!--                                                 <li><a href="category.jsp">T-shirts</a> -->
<!--                                                 </li> -->
<!--                                                 <li><a href="category.jsp">Shirts</a> -->
<!--                                                 </li> -->
<!--                                                 <li><a href="category.jsp">Pants</a> -->
<!--                                                 </li> -->
<!--                                                 <li><a href="category.jsp">Accessories</a> -->
<!--                                                 </li> -->
<!--                                             </ul> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 /.yamm-content -->
<!--                             </li> -->
<!--                         </ul> -->
<!--                     </li> -->
                </ul>
            </div>
            <!--/.nav-collapse -->

<!--             <div class="navbar-buttons"> -->

<!--                 <div class="navbar-collapse collapse right" id="basket-overview"> -->
<!--                     <a href="basket.jsp" class="btn btn-primary navbar-btn"><i class="fa fa-shopping-cart"></i><span class="hidden-sm">3 items in cart</span></a> -->
<!--                 </div> -->
<!--                 /.nav-collapse -->

<!--                 <div class="navbar-collapse collapse right" id="search-not-mobile"> -->
<!--                     <button type="button" class="btn navbar-btn btn-primary" data-toggle="collapse" data-target="#search"> -->
<!--                         <span class="sr-only">Toggle search</span> -->
<!--                         <i class="fa fa-search"></i> -->
<!--                     </button> -->
<!--                 </div> -->

<!--             </div> -->

<!--             <div class="collapse clearfix" id="search"> -->

<!--                 <form class="navbar-form" role="search"> -->
<!--                     <div class="input-group"> -->
<!--                         <input type="text" class="form-control" placeholder="Search"> -->
<!--                         <span class="input-group-btn"> -->

<!-- 			<button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button> -->

<!-- 		    </span> -->
<!--                     </div> -->
<!--                 </form> -->

<!--             </div> -->
            <!--/.nav-collapse -->

        </div>
        <!-- /.container -->
    </div>
    <!-- /#navbar -->

    <!-- *** NAVBAR END *** -->
