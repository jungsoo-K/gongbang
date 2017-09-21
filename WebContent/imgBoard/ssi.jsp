<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import="imgBoard.*" %> 
<%@ page import = "java.util.*" %>
<%@ page import = "utility.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<jsp:useBean id="dao" class="imgBoard.ImgDAO" />

<%
	request.setCharacterEncoding("utf-8");
	String root = request.getContextPath();
	
	/* file upload */
	String upDir = application.getRealPath("/imgBoard/storage");
	String tempDir = application.getRealPath("/imgBoard/temp");
%>
