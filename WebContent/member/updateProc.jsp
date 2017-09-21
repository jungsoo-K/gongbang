<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp"%>
<jsp:useBean id="vo" class="member.MemberVO" />
<jsp:setProperty property="*" name="vo" />
<%
	boolean flag = dao.update(vo);
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

<title></title>
<link href="<%=root%>/css/templStyle.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
		function read(){
			var url = "read.jsp?id=<%=vo.getId()%>";
		location.href = url;
	}
</script>
</head>
<body>
	<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->

	<DIV class="title">정보수정</DIV>

	<div class="content">
		<%
			if (flag) {
				out.print("정보를 수정했습니다.");
			} else {
				out.print("정보수정 실패용");
			}
		%>
	</div>

	<DIV class='bottom'>
		<%
			if (flag) {
		%>
			<input type='button' value='정보확인' onclick="read()"> 
		<%		
			} else {
		%>
			<input type='button' value='다시시도' onclick="history.back()">
		<%				
			}
		%>
	</DIV>

	<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false" />
	<!-- *********************************************** -->
</body>
</html>