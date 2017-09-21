<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/member/ssi.jsp" %>
<%
 	UploadSave upload = new UploadSave(request,-1,-1,tempDir);
 	String id=upload.getParameter("id");
 	String email=upload.getParameter("email");
 	
 	String str = "";
 	if(dao.duplicateId(id)){
 		str = "중복된 아이디입니다. 아이디중복을하세요";
 	} else if (dao.duplicateEmail(email)) {
 		str = "중복된 이메일입니다. 이메일중복확인을 하세요";
 	} else {
 		request.setAttribute("upload",upload);
%>
 	<jsp:forward page="/member/createProc.jsp" />
<% 
	return;
 	}
%>	
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">ID & e-mail 중복확인</DIV>
 
<div class="content">
<%=str %>
</div>
  
  <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>
 
<!-- *********************************************** -->
<jsp:include page="/menu/footer.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 