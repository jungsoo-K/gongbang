<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp"%>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	Map map = new HashMap();
	map.put("id", id);
	map.put("passwd", passwd);

	boolean flag = dao.updatePw(map);
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

<link href="<%=root%>/css/templStyle.css" rel="Stylesheet" type="text/css">
</head>
<body>
	<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
	<!-- *********************************************** -->
	
	<DIV class="title">비밀번호 변경처리</DIV>
	<div class="content">
		<%
			if (flag) {
				out.print("비밀번호를 변경했습니다.");
			} else {
				out.print("비밀번호 변경에 실패했습니다.");
			}
		%>
	</div>

	<DIV class='bottom'>
		<%
			if (flag) {
		%>
		<input type='button' value="확인" onclick="location.href='../index.jsp'">
		<%
			} else {
		%>
		<input type='button' value='다시시도' onclick="history.back()">
		<%
			}
		%>
		
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
	<!-- *********************************************** -->
</body>
</html>