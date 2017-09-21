<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import="member.*" %>
<%@ page import="java.util.*" %>
<%@ page import="utility.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<jsp:useBean id="dao" class="member.MemberDAO" />
<%    
	  request.setCharacterEncoding("utf-8");
      String root = request.getContextPath();
      //업로드용 파일 저장 공간 선언
      String upDir=application.getRealPath("/member/storage");
      String tempDir=application.getRealPath("/member/temp");
%> 
 
