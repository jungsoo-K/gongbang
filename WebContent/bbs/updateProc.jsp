<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/bbs/ssi.jsp" %>
<jsp:useBean id="vo" class = "bbs.BbsVO" />
<jsp:setProperty name = "vo" property = "*" />
<%
	Map map = new HashMap();
	map.put("bbsno", vo.getBbsno());
	map.put("passwd", vo.getPasswd());
	
	boolean pflag = dao.passwdCheck(map);
	boolean flag = false;
	if(pflag){
		flag = dao.update(vo);
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
<script>
	function blist(){ 
		var url = "list.jsp";
		url += "?col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		location.href = url;
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
<DIV class="title">처리결과</DIV>
<div class = "content">
	<%
		if(!pflag) {
			out.print("비밀번호가 일치하지 않습니다.");
		} else if(flag){
			out.print("변경함~");
		} else {
			out.print("글 수정 실패함");
		}
	%>
</div> 
<DIV class='bottom'>
<% if(!pflag){ %>
	<input type='button' value='다시시도' onclick = "history.back()">
<%	} else {%>
	<input type='button' value='계속등록' onclick = "location.href = 'createForm.jsp'">
<% } %>	
    <input type='button' value='목록' onclick="blist()">
</DIV>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>