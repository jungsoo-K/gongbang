<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/bbs/ssi.jsp" %>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	BbsVO vo = dao.replyRead(bbsno);
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
	function inCheck(f){
		if(f.wname.value == ""){
			alert("이름좀 입력해라!!")
			f.wname.focus();
			return false;
		}
		if(f.title.value == ""){
			alert("제목좀 입력해라!!")
			f.title.focus();
			return false;
		}
		if (CKEDITOR.instances['content'].getData() == '') {
		      window.alert('내용을 입력해 주세요.');
		      CKEDITOR.instances['content'].focus();
		      return false;
		}
		if(f.passwd.value == ""){
			alert("비번좀 입력해라!!")
			f.passwd.focus();
			return false;
		}
	}
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
 <script type="text/JavaScript">
   window.onload=function(){
     CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
 </script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->

<DIV class="title">답변</DIV>
<FORM name='frm' method='POST' action='./replyProc.jsp' onsubmit = "return inCheck(this)">
<input type="hidden" name = "bbsno" value = "<%=vo.getBbsno() %>">
<input type="hidden" name = "grpno" value = "<%=vo.getGrpno() %>">
<input type="hidden" name = "indent" value = "<%=vo.getIndent() %>">
<input type="hidden" name = "ansnum" value = "<%=vo.getAnsnum() %>">
<input type="hidden" name="col" value = "<%=request.getParameter("col")%>">
<input type="hidden" name="word" value = "<%=request.getParameter("word") %>">
  <TABLE>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name = "wname"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name = "title" value="<%=vo.getTitle() %>"></TD>
    </TR>
    <TR>
      <TD colspan="2">
      	<textarea rows = "10" cols = "45" name = "content"></textarea>
      </TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name = "passwd"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='답변'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>