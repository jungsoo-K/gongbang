<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/imgBoard/ssi.jsp" %>
<%
	int imgno = Integer.parseInt(request.getParameter("imgno"));
	boolean flag = dao.checkAn(imgno);
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
	function inputCheck(f) {
		if (f.passwd.value == "") {
			alert("비밀번호를 입력하세요");
			f.passwd.focus();
			return false;
		}
	}
	
	function ilist(){
		var url = "./list";
		url += "?col=${param.col}";
		url += "&word=${param.word}";
		location.href = url;
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->

<%
	if(flag){
%>
	<DIV class="content">답변글이 존재하므로 삭제할 수 없습니다. </div>
	<DIV class='bottom'>
		<input type='submit' value='목록' onclick = "ilist()">
		 <input type='button' value='뒤로가기' onclick="history.back()">
	</DIV>
<% } else { %>
	<FORM name='frm' method='POST' action='./deleteProc.jsp' onsubmit="return inputCheck(this)">
		<input type="hidden" name="imgno" value = "<%=imgno%>">
		<input type="hidden" name="oldfile" value = "<%=request.getParameter("oldfile") %>">
		<input type = "hidden" name = "col" value = "<%=request.getParameter("col")%>">
		<input type = "hidden" name = "word" value = "<%=request.getParameter("word")%>">
		<div align="center">삭제시 복구할 수 없습니다.</div>
		<br>
		<br>
		
		<TABLE>
			<TR>
				<TH>비밀번호 입력</TH>
				<TD><input type="password" name="passwd"></TD>
			</TR>
		</TABLE>

		<DIV class='bottom'>
			<input type='submit' value='삭제'>
			<input type='button' value='취소' onclick="history.back()">
		</DIV>
	</FORM>
 <% } %>
 
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>