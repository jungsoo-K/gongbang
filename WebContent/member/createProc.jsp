<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/member/ssi.jsp" %>
<jsp:useBean id="vo" class="member.MemberVO"/>
<%
	UploadSave upload = (UploadSave)request.getAttribute("upload");

	vo.setId(upload.getParameter("id"));
	vo.setMname(UploadSave.encode(upload.getParameter("mname")));
	vo.setAddress1(UploadSave.encode(upload.getParameter("address1")));
	vo.setAddress2(UploadSave.encode(upload.getParameter("address2")));
	vo.setPasswd(upload.getParameter("passwd"));
	vo.setTel(upload.getParameter("tel"));
	vo.setZipcode(upload.getParameter("zipcode"));
	vo.setEmail(upload.getParameter("email"));
	vo.setJob(upload.getParameter("job"));
	
	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();
	String filename = "member.jpg";
	if(size>0){
		filename = UploadSave.saveFile(fileItem, upDir);
	}
	
	vo.setFname(filename);
	
	boolean flag = dao.create(vo);
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
 
<DIV class="title">회원가입 처리</DIV>
 	<div class="content">
 		<%
 		if(flag){
 			out.print("회원가입을 했습니다.");
 		} else {
 			out.print("회원가입을 실패했습니다.");
 		}
 		%>
 	</div>

  <DIV class='bottom'>
  	<%if(flag){ %>
    <input type='button' value='로그인' onclick="location.href='./loginForm.jsp'">
    <%}else{ %>
    <input type='button' value='다시시도' onclick=history.back()>
    <%} %>
    <input type='button' value='home' onclick="location.href='../index.jsp'">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/footer.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 