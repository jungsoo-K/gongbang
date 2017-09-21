<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp" %>
<%
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);
	String id = upload.getParameter("id");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();
	String filename = null;
	if(size>0){
		if(oldfile!=null && !oldfile.equals("member.jpg")){
			UploadSave.deleteFile(upDir,oldfile);
		filename = UploadSave.saveFile(fileItem, upDir);
		}	
	}
	Map map = new HashMap();
	map.put("id",id);
	map.put("fname",filename);
	boolean flag = dao.updateFile(map);
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
    <title> </title>
    <link href="<%=root%>/css/templStyle.css" rel="Stylesheet" type="text/css">
    
    <script type="text/javascript">
		function read(){
			var url = "read.jsp?id=<%=id%>";
			
			location.href=url;
		}
	</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
	<DIV class="title">사진변경</DIV>
	<div class="content">
		<%
			if(flag){
				out.print("사진을 변경했습니다.");
			} else {
				out.print("사진변경을 실패했습니다.");
			}
		%>
	</div> 
	  
	<DIV class='bottom'>
		<%if(flag){ %>
		    <input type='button' value='나의정보' onclick="read()">
		<%}else{ %>    
		    <input type='button' value='다시시도' onclick="history.back()">
		<%} %>    
	</DIV>
	
	
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>