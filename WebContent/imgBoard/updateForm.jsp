<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/imgBoard/ssi.jsp" %>
<%
	int imgno = Integer.parseInt(request.getParameter("imgno"));
	ImgDTO dto = dao.read(imgno);
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
	function upCheck(e){
		if(e.title.value == ""){
			alert("제목을 입력하세요");
			e.title.focus();
			return false;
		}
		if(e.name.value == ""){
			alert("이름을 입력하세요");
			e.name.focus();
			return false;
		}
		if(e.fname.value == ""){
			alert("변경할 사진을 등록하세요");
			return false;
		}
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->

<DIV class="title">내용 수정</DIV>
 
<FORM name='frm' method='POST' enctype="multipart/form-data" 
	action='./updateProc.jsp' onsubmit = "return upCheck(this)">
<input type="hidden" name="imgno" value="<%=dto.getImgno() %>">
<input type="hidden" name="oldfile" value='<%=request.getParameter("oldfile")%>'>
  <TABLE>
    <TR>
      <TH>제목</TH>
      <TD><input type ="text" name = "title" value="<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><input type="text" name="name" value ="<%=dto.getName()%>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea name = "content" rows = "10" cols = "50"><%=dto.getContent() %></textarea></TD>
    </TR>
    <TR>
      <TH>현재사진</TH>
      <TD><img src = "./storage/<%=request.getParameter("oldfile")%>"></TD>
    </TR>
    <TR>
      <TH>수정사진</TH>
      <TD><input type ="file" name = "fname" accept = ".png,.jpg,.gif"></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name = "passwd"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='수정'>
    <input type='reset' value='다시작성'>
  </DIV>
</FORM>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>