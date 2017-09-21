<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/imgBoard/ssi.jsp" %>
<jsp:useBean id="dto" class="imgBoard.ImgDTO" />
<%
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setName(UploadSave.encode(upload.getParameter("name")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(upload.getParameter("passwd"));
	
	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	if(size>0){
		dto.setFname(UploadSave.saveFile(fileItem,upDir));
	} else {
		dto.setFname("member.jpg");
	}
	boolean flag = dao.create(dto);
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
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
<DIV class="title">등록결과</DIV>

<div class="content"> 
<%	
	if(flag){
		out.print("이미지 등록 완료.");
	}else{
		out.print("이미지 등록 실패.");
	}
%>
</div>

  <DIV class='bottom'>
	<button type="button" onclick = "location.href='./createForm.jsp'">계속등록</button>
	<button type="button" onclick = "location.href='./list.jsp'">목록</button>
  </DIV>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>