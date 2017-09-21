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
<script type = "text/javascript">
	function ilist(){
		var url = "./list.jsp";
		url += "?col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		url += "&nowPage=<%=request.getParameter("nowPage")%>";
		
		location.href=url;
	}
	
	function idelete(){
		if(confirm("삭제할꺼야?")){
		var url = "./deleteForm.jsp";
		url += "?imgno=<%=imgno%>";
		url += "&oldfile=<%=dto.getFname()%>";
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		url += "&nowPage=<%=request.getParameter("nowPage")%>";

		location.href=url;
		}
	}
	
	function iupdate(){
		var url = "./updateForm.jsp";
		url += "?imgno=<%=imgno%>";
		url += "&oldfile=<%=dto.getFname()%>";
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		url += "&nowPage=<%=request.getParameter("nowPage")%>";

		location.href=url;
		}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
<DIV class="title">image info</DIV>
  <TABLE>
    <TR>
    	<td rowspan="5">
        	<img src="./storage/<%=dto.getFname() %>">
    	</td>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><%=dto.getName() %></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><%=dto.getContent() %></TD>
    </TR>
    <TR>
      <TH>등록날짜</TH>
      <TD><%=dto.getWdate().substring(0,10) %></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='등록' onclick="location.href='createForm.jsp'">
    <input type='button' value='수정' onclick="iupdate()">
    <input type='button' value='목록' onclick="ilist()">
    <input type='button' value='삭제' onclick="idelete()">
  </DIV> 
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>