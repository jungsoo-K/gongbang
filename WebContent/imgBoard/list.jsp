<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/imgBoard/ssi.jsp" %>
<%
	//검색
 	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")){
		word="";
	}
	//페이지
	int nowPage = 1;
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5;
	//순번
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col",col);
	map.put("word",word);
	map.put("sno",sno);
	map.put("eno",eno);
	
	int total = dao.total(map);
	List<ImgDTO> list = dao.list(map);
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
	function iread(imgno){
		var url = "./read.jsp";
		url += "?imgno="+imgno;
		url += "&col=<%=col%>";
		url += "&word=<%=word%>"; 
		url += "&nowPage=<%=nowPage%>"; 
		
		location.href=url;
	}
</script>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" />
<!-- *********************************************** -->
	
<DIV class="title">List</DIV>
 
<div class="search">
	<FORM name='frm' method='POST' action='.list.jsp'>
		<select name="col">
			<option value="name"<%if(col.equals("name"))out.print("selected='selected'"); %>>성명</option>
			<option value="title"<%if(col.equals("title"))out.print("selected='selected'"); %>>제목</option>
			<option value="total">전체출력</option>
		</select>
		<input type = "text" name="word" value="<%=word %>">
		<input type = "submit" value="검색">
		<input type=  'button' value='글쓰기' onclick="location.href='./createForm.jsp'">
	</form>
</div>
<br>
  <TABLE>
    <TR>
      <TH>사진</TH>
      <TH>번호</TH>
      <TH>제목</TH>
      <TH>이름</TH>
    </TR>
<%
	for(int i=0;i<list.size();i++){
	ImgDTO dto = list.get(i);	
%>
    <tr>
    <td>
    	<a href = "javascript:iread('<%=dto.getImgno()%>')">
    	<img src="./storage/<%=dto.getFname() %> "></a>
    </td>
    <td><%=dto.getImgno() %></td>
    <td><%=dto.getTitle()%></td>	
    <td><%=dto.getName() %></td>	
    </tr>
<%
}
%> 
</TABLE>
<br>
<div class="bottom">
	<%=Utility.paging3(total, nowPage, recordPerPage, col, word)%>
</div>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" />
<!-- *********************************************** -->
</body>
</html>