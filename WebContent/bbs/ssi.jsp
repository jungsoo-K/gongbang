<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import="bbs.*" %> 
<%@ page import = "java.util.*" %> 
<%@ page import = "utility.*" %> 
<jsp:useBean id = "dao" class = "bbs.BbsDAO" />

<%
	request.setCharacterEncoding("utf-8");
    String root = request.getContextPath();
%> 