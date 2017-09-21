<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file= "/member/ssi.jsp" %>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	Map map = new HashMap();
	map.put("id", id);
	map.put("passwd", passwd);
	
	boolean flag = dao.loginCheck(map);
	if(flag){
		String grade = dao.getGrade(id);
		session.setAttribute("id", id);
		session.setAttribute("grade", grade);
	}
%>

<!DOCTYPE html>
<html lang="en">

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
	<div id= "all">
        <div id="content">
            <div class="container">
				<DIV class="title">로그인 처리</DIV>
					<%
						if(flag){
					%>
							<script>
								(function(){
									location.href="<%=root%>/index.jsp";
								})()
							</script>
					<%	
						} else {
					%>
							<script>
								(function(){
									location.href="<%=root%>/member/loginForm.jsp";
								})()
							</script>
					<%
						}
					%>
            </div>
            <!-- /.container -->
        </div>
        <!-- /#content -->
	</div>






	
	<jsp:include page="/menu/footer.jsp" flush="false" />
</body>

</html>
