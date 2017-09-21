<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp" %>
<%
	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");
	boolean flag = dao.delete(id);
	if(flag){
		if(oldfile != null && !oldfile.equals("member.jpg")){
			UploadSave.deleteFile(upDir,oldfile);
		}
		session.invalidate();
	}
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
	<div class = "content">
		<%
			if(flag){
				out.print("탈퇴하셨습니다. 자동으로 로그아웃 됩니다.");
			} else {
				out.print("탈퇴 실패");
			}
		%>
	</div>
	<DIV class='bottom'>
	    <input type="button" value='다시 시도' onclick="history.back()">
	    <input type='button' value='홈' onclick="location.href='../index.jsp'">
	</DIV>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>