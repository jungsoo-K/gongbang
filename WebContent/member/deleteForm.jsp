<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp" %>
<%
	String id = request.getParameter("id");
	if(id == null)
		id = (String)session.getAttribute("id");
	
	String oldfile = request.getParameter("oldfile");
	if(oldfile == null)
		oldfile = dao.getFname(id);
	
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

    <title> </title>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
<DIV class="title">회원탈퇴</DIV>
 
<FORM name='frm' method='POST' action='./deleteProc.jsp'>
	<input type = "hidden" name = "id" value = "<%=id %>">
	<input type = "hidden" name = "oldfile" value = "<%=oldfile %>">
	<div class = "content">
	 탈퇴하면 끝임~~ <br>
	 그래도 할거면 탈퇴버튼 클릭하세요.
	</div>
	<DIV class='bottom'>
		<input type='submit' value='탈퇴'>
	    <input type='button' value='취소' onclick="history.back()">
	</DIV>
</FORM>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>