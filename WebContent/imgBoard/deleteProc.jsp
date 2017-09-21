<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/imgBoard/ssi.jsp" %>
<%
	int imgno = Integer.parseInt(request.getParameter("imgno"));
	String passwd = request.getParameter("passwd");
	
	Map map = new HashMap();
	map.put("imgno", imgno);
	map.put("passwd", passwd);
	
	boolean pflag = dao.checkPw(map);
	boolean flag = false;
	if(pflag){
		flag = dao.delete(imgno);
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
	<link href="<%=root%>/css/templStyle.css" rel="Stylesheet" type="text/css">

    <title> </title>
<script type="text/javascript">
	function iread(){
		var url = "read.jsp";
		url = url + "?imgno=<%=request.getParameter("imgno")%>";
		url = url + "&col=<%=request.getParameter("col")%>";
		url = url + "&word=<%=request.getParameter("word")%>";
		location.href = url;
	}
	
	function ilist(){
		var url = "list.jsp";
		url = url + "?imgno=<%=request.getParameter("imgno")%>";
		url = url + "&col=<%=request.getParameter("col")%>";
		url = url + "&word=<%=request.getParameter("word")%>";
		location.href = url;
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	<DIV class="title">처리결과</DIV>

	<DIV class="content">
	<% 
		if(!pflag){
	%>
		비밀번호가 일치하지 않습니다.
	<%
		} else if(flag) {
	%>
		글을 삭제하였습니다.
	<%
		} else {
	%>
		글 삭제 실패.
	<% } %>
	</DIV>

	<DIV class='bottom'>
	<% 
		if(!pflag) {
	%>
		<input type='button' value='재시도' onclick="history.back()">
		<input type='button' value='취소' onclick="iread()">
	<% } else {%>
		<input type='button' value='목록' onclick="ilist()">
		
	<% } %>
	</DIV>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>