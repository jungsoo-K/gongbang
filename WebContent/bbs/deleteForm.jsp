<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/bbs/ssi.jsp" %>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	boolean flag = dao.getRefnum(bbsno);
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
		var url = "./list.jsp";
		url += "?col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		location.href =url;
	}
	
	function inputCheck(e){
		if(e.passwd.value == ""){
			alert("비밀번호를 입력하세요");
			e.passwd.focus();
			return false;
		}
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->

<DIV class="title">삭제</DIV>
<%
	if(flag){
%>
 <div class = "content">답글이 존재해서 삭제 못함!</div>
 <DIV class='bottom'>
    <input type='button' value='목록' onclick="blist()" >
    <input type='button' value='뒤로가기' onclick="history.back()">
  </DIV>
<% } else { %>
<FORM name='frm' method='POST' action='./deleteProc.jsp' onsubmit = "return inputCheck(this)">
<input type = "hidden" name = "bbsno" value = "<%=bbsno%>" >
<input type = "hidden" name = "col" value = "<%=request.getParameter("col")%>" >
<input type = "hidden" name = "word" value = "<%=request.getParameter("word")%>" >
<div class="content">삭제하면 복구불가능. </div>
  <TABLE>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name = "passwd"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='확인'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<% } %>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>