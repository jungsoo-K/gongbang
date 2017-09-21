<%@ page contentType="text/html; charset=UTF-8" %> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body>
 
<DIV class="title">e-mail 중복확인</DIV>
 
<FORM name='frm' method='POST' action='./email_proc.jsp'>
  <TABLE>
    <TR>
      <TH>e-mail</TH>
      <TD><input type="text" name="email"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='중복확인'>
    <input type='button' value='취소' onclick="window.close()">
  </DIV>
</FORM>
 
 
</body>
</html> 