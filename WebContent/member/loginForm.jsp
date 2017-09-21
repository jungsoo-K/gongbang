<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String root = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="robots" content="all,follow">
<meta name="googlebot" content="index,follow,snippet,archive">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Obaju e-commerce template">
<meta name="author" content="Ondrej Svestka | ondrejsvestka.cz">
<meta name="keywords" content="">

<title>Obaju : e-commerce template</title>

</head>
<body>
	<jsp:include page="/menu/top.jsp" flush="false"/>
	<div id="all">
		<div id="content">
			<div class="container">
				<div class="col-md-6 col-md-offset-3">
					<div class="box">
						<h1>Login</h1>

						<p class="lead">이미 회원이신가요?</p>

						<form action="loginProc.jsp" method="post">
							<div class="form-group">
								<label for="id">아이디</label> <input type="text"
									class="form-control" name="id"> <label for="passwd">비밀번호</label>
								<input type="password" class="form-control" name="passwd">
							</div>
							<div class="text-center">
								<button type="submit" class="btn btn-primary">
									<i class="fa fa-sign-in"></i> Log in
								</button>
								<button type="button"
									onclick="location.href='<%=root%>/member/agreement.jsp'"
									class="btn btn-primary">회원가입</button>
							</div>
						</form>
						<hr>

						<p class="text-muted">
							<b>회원이 아니라면 가입 후 이용 부탁드립니다.</b>
						</p>
					</div>
				</div>

			</div>
			<!-- /.container -->
		</div>
		<!-- /#content -->
		<jsp:include page="/menu/footer.jsp" flush="false"/>
	</div>
</body>
</html>