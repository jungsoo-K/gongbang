<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp" %>

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
	<link href="<%=root%>/css/templStyle.css" rel="Stylesheet" type="text/css">
    <script type="text/javascript">
		function inCheck(f){
			if(f.fname.value==""){
				alert("사진을 선택하세요");
				f.fname.focus();
				return false;		
			}
		}
	</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
	<FORM name='frm' 
		  method='POST' 
		  enctype="multipart/form-data"
		  action='./updateFileProc.jsp'
		  onsubmit = "return inCheck(this)">
	<input type="hidden" name="id" value='<%=request.getParameter("id")%>'>
	<input type="hidden" name="oldfile" value='<%=request.getParameter("oldfile")%>'>
	  <TABLE>
	    <TR>
	      <TH>원본파일</TH>
	      <TD>
	      	<img src = "./storage/<%=request.getParameter("oldfile")%>">
	      	원본파일명:<%=request.getParameter("oldfile") %>
	      </TD>
	    </TR>
	    <TR>
	      <TH>변경파일</TH>
	      <TD>
	      	<input type = "file" name = "fname" accept = ".png,.jpg,.gif">
	      </TD>
	    </TR>
	  </TABLE>
	  
	  <DIV class='bottom'>
	    <input type='submit' value='수정'>
	    <input type='button' value='취소' onclick="history.back()">
	  </DIV>
	</FORM>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>