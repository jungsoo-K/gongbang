<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp"%>

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

<title></title>
<script type="text/javascript">
	function inCheck(f){
		if(f.passwd.value==""){
			alert("패스워드를 입력하세요");
			f.passwd.focus();
			return false;
		}
		if(f.repasswd.value==""){
			alert("패스워드확인을 입력하세요");
			f.repasswd.focus();
			return false;
		}
		if(f.passwd.value!=f.repasswd.value){
			alert("비밀번호가 일치하지 않습니다 다시입력하세요");
			f.repasswd.value="";
			f.repasswd.focus();
			return false;
		}
	}
</script>
	<link href="<%=root%>/css/templStyle.css" rel="Stylesheet" type="text/css">

</head>
<body>
	<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
	<!-- *********************************************** -->
	<DIV class="title">비밀번호 변경</DIV>

	<FORM name='frm' method='POST' action='./updatePwProc.jsp'
		onsubmit="return inCheck(this)">
		<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
		<TABLE>
			<TR>
				<TH>비밀번호</TH>
				<TD><input type="password" name="passwd"></TD>
			</TR>
			<TR>
				<TH>비밀번호 확인</TH>
				<TD><input type="password" name="repasswd"></TD>
			</TR>
		</TABLE>

		<DIV class='bottom'>
			<input type='submit' value='확인'> <input type='button'
				value='취소' onclick="history.back()">
		</DIV>
	</FORM>

	<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
	<!-- *********************************************** -->
</body>
</html>