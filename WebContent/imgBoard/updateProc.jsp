<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/imgBoard/ssi.jsp" %>
<jsp:useBean id="dto" class="imgBoard.ImgDTO" />
<jsp:setProperty name = "dto" property="*" />
<%
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);
	int imgno = (Integer.parseInt(upload.getParameter("imgno")));
	String passwd = upload.getParameter("passwd");
	String oldfile = upload.getParameter("oldfile");
	
	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();
	String filename = null;
	if(size > 0){
		if(oldfile != null && oldfile != "member.jpg"){
			UploadSave.deleteFile(upDir, oldfile);
		}
		filename = UploadSave.saveFile(fileItem, upDir);
		dto.setFname(filename);
	} else {
		dto.setFname("member.jpg");
	}
	Map map = new HashMap();
	map.put("imgno",imgno);
	map.put("passwd", passwd);
	
	boolean flagP = dao.checkPw(map);
	boolean flag = false;
	if(flagP){
		flag = dao.update(dto);
	}
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
	function ilist(){
		var url = "./list.jsp";
		location.href = url;
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
<DIV class="title"></DIV>
<div class= "content">
	<%
		if(flagP){
			if(flag){
				out.print("정보 수정에 성공하였습니다.");
			} else {
				out.print("정보 수정에 실패하였습니다.");
			}
		} else {
			out.print("비밀번호가 틀립니다!!!");
		}
	%>
</div>
<DIV class='bottom'>
	<%if(flag){ %>
    <input type='button' value='목록' onclick="ilist()">
    <%} else { %>
    <input type="button" value='이전으로' onclick="history.back()">
    <input type='button' value='목록' onclick="ilist()">
    <%} %>
</DIV>	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>