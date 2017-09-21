<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/bbs/ssi.jsp" %>
<% 
	//-- 검색관련 --//
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")) word = "";
	
	// == 페이징 관련 --//
	int nowPage = 1; //현재페이지
	if(request.getParameter("nowPage") != null)
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	
	int recordPerPage = 5; // 페이지당 레코드개수
	//DB에서 데이터를 가져올 순번
	int sno = ((nowPage-1) * recordPerPage) +1;
	int eno = nowPage * recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	List<BbsVO> list = dao.list(map); 
	int totalRecord = dao.total(map);
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
    
<script>
	function read(bbsno){
		var url = "./read.jsp";
		url += "?bbsno=" + bbsno;
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		location.href = url;
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	 
<DIV class="title">자유게시판</DIV>
 
<div class = "search">
<form method = "post" action="./list.jsp">
	<select name = "col">
		<option value = "wname" <%if(col.equals("wname")) out.print("selected = 'selected'"); %>>성명</option>
		<option value = "title" <%if(col.equals("title")) out.print("selected = 'selected'"); %>>제목</option>
		<option value = "content" <%if(col.equals("content")) out.print("selected = 'selected'"); %>>내용</option>
		<option value = "total">전체</option>
	</select>
	<input type = "text" name = "word" value = "<%=word%>">
	<button type= "submit">검색</button>
	<button type='button' onclick="location.href='./createForm.jsp'">글쓰기</button>
	
</form>
</div>
  <TABLE class = "listTab">
    <TR>
      <TH></TH>
      <TH>제목</TH>
      <TH>작성자</TH>
      <TH>작성일</TH>
      <TH>조회수</TH>
      <TH>grpno</TH>
      <TH>indent</TH>
      <TH>ansnum</TH>
    </TR>
    <%	if(list.size() == 0){ %>
    	<tr>
    		<td colspan = "8">등록된 글이 없습니다.</td>
    	</tr>
    <%	} else {
    	for(int i = 0; i<list.size(); i++){
    		BbsVO vo = list.get(i);
    %>
    <tr>
    	<td><%=vo.getBbsno() %></td>
    	<td>
    	<%
    		for(int j = 0; j < vo.getIndent(); j++){
    			out.print("&nbsp;&nbsp;&nbsp;");
    		}
    		if(vo.getIndent() > 0){
    			out.print("<img src='../img/re.jpg'>");
    		}
    	%>
    	<a href = "javascript:read('<%=vo.getBbsno()%>')"><%=vo.getTitle() %></a>
    	<% if(Utility.compareDay(vo.getWdate().substring(0,10))){ %>
    			<img src = "<%=root %>/img/new.gif">
    	<% } %>	
    	</td>
    	<td><%=vo.getWname() %></td>
    	<td><%=vo.getWdate() %></td>
    	<td><%=vo.getViewcnt() %></td>
    	<td><%=vo.getGrpno() %></td>
    	<td><%=vo.getIndent() %></td>
    	<td><%=vo.getAnsnum() %></td>
    </tr>
    <%
    	} //for-end
    } // if-end
    %>
  </TABLE>
  
  <DIV class='bottom'>
	<%= Utility.paging3(totalRecord, nowPage, recordPerPage, col, word)	%>
  </DIV>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>