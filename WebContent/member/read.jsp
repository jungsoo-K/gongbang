<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp" %>
<%
 	String id = request.getParameter("id");
 	if(id == null)
 		id = (String)session.getAttribute("id");
 	MemberVO vo = dao.read(id);
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
    <script>
	    function update(){
	    	var url = "updateForm.jsp";
	    	url += "?id=<%=id%>";
	    	
	    	location.href=url;
	    }
	    function updatePw(){
	    	var url = "updatePwForm.jsp";
	    	url += "?id=<%=id%>";
	    	
	    	location.href=url;
	    }
	    function updateFile(){
	    	var url = "updateFileForm.jsp";
	    	url += "?id=<%=id%>";
	    	url += "&oldfile=<%=vo.getFname()%>";
	    	
	    	location.href=url;
	    }
	    function del(){
	    	var url = "deleteForm.jsp";
	    	url += "?id=<%=id%>";
	    	url += "&oldfile=<%=vo.getFname()%>"
	
	    	location.href=url;
	    }
	    function downM(){
	    	var url = "<%=root%>/download";
	    	url += "?dir=/member/storage";
	    	url += "&filename=<%=vo.getFname()%>";
	    	
	    	location.href=url;
	    }
    </script> 
	<link href="<%=root%>/css/templStyle.css" rel="Stylesheet" type="text/css">
	<style type="text/css">
		.myinfo > img{
			width : 100%;
			height : auto;
		}
	</style>
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
	
<DIV class="title"><%=vo.getMname() %>님의 회원정보</DIV>
 
  <TABLE>
    <TR>
      <TD colspan="2" class="myinfo" width ="600px">
      <img src="./storage/<%=vo.getFname()%>">
      </TD>

    </TR>
    <TR>
      <TH>아이디</TH>
      <TD><%=vo.getId() %></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><%=vo.getMname() %></TD>
    </TR>
    <TR>
      <TH>전화번호</TH>
      <TD><%=Utility.checkNull(vo.getTel()) %></TD>
    </TR>
    <TR>
      <TH>이메일</TH>
      <TD><%=vo.getEmail() %></TD>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD><%=Utility.checkNull(vo.getZipcode()) %></TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD>
      <%=Utility.checkNull(vo.getAddress1()) %>
      <%=Utility.checkNull(vo.getAddress2()) %>
      </TD>
    </TR>
    <TR>
      <TH>직업</TH>
      <TD>
      	직업코드:<%=vo.getJob() %>
      	(<%=Utility.getCodeValue(vo.getJob())%>)
      </TD>
    </TR>
    <TR>
      <TH>등록날짜</TH>
      <TD><%=vo.getMdate() %></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='비밀번호수정' onclick="updatePw()">
    <input type='button' value='정보수정' onclick="update()">
    <input type='button' value='사진수정' onclick="updateFile()">
    <input type='button' value='다운로드' onclick="downM()"> 
    <input type='button' value='탈퇴' onclick="del()">
  </DIV>
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
<!-- *********************************************** -->
</body>
</html>