<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/imgBoard/ssi.jsp" %>

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
<script type = "text/javascript">
	function inCheck(f){
		if(f.title.value ==""){
			alert("제목을 입력하세요.");
			f.title.focus();
			return false;
		}
		if(f.name.value ==""){
			alert("작성자를 입력하세요.");
			f.name.focus();
			return false;
		}
		if(f.passwd.value ==""){
			alert("비밀번호를 입력하세요.");
			f.passwd.focus();
			return false;
		}
		if(f.filename.value ==""){
			alert("이미지를 선택하세요.");
			f.filename.focus();
			return false;
		}	
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
<DIV class="title">이미지 등록</DIV>
 
<FORM name='frm' method='POST' enctype="multipart/form-data" 
		action='./createProc.jsp' onsubmit="return inCheck(this)">
  <TABLE>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title"></TD>
    </TR>
    <TR>
      <TH>작성자</TH>
      <TD><input type="text" name="name"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="5" cols="20" name="content"></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    <TR>
      <TH>이미지</TH>
      <TD><input type="file" name="filename"></TD>
    </TR>
  </TABLE> 
 
  <DIV class='bottom'>
    <button type = "submit">등록</button>
    <button type = "reset">다시입력</button>
    <input type='button' value='뒤로가기' onclick="history.back()">
   </DIV>
</FORM>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>