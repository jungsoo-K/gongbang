<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/bbs/ssi.jsp" %>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	dao.upViewcnt(bbsno);
	BbsVO vo = dao.read(bbsno);
	String content = vo.getContent();
	content = content.replaceAll("\r\n", "<br>");
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
	function breply(){
		var url = "replyForm.jsp";
		url += "?bbsno=<%=bbsno%>";
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		location.href = url;
	}
	function bdelete(){ 
		var url = "deleteForm.jsp";
		url += "?bbsno=<%=bbsno%>";
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		location.href = url;
	}
	function bupdate(){
		var url = "updateForm.jsp";
		url += "?bbsno=<%=bbsno%>";
		url += "&col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		location.href = url;
	}
	
	function blist(){
		var url = "./list.jsp";
		url += "?col=<%=request.getParameter("col")%>";
		url += "&word=<%=request.getParameter("word")%>";
		location.href = url;
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	 
  <TABLE class="readTab">
    <TR>
      <TH>제목</TH>
      <TD><%=vo.getTitle() %></TD>
    </TR>
    <TR>
      <TD colspan="2"><%=content %></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><%=vo.getWname() %></TD>
    </TR>
    <TR>
      <TH>등록일자</TH>
      <TD><%= vo.getWdate()%></TD>
    </TR>
    <TR>
      <TH>조회수</TH>
      <TD><%=vo.getViewcnt() %></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='등록' onclick="location.href='createForm.jsp'">
    <input type='button' value='수정' onclick="bupdate()">
    <input type='button' value='삭제' onclick="bdelete()">
    <input type='button' value='답변' onclick="breply()">
    <input type='button' value='목록' onclick="blist()">
  </DIV>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>