<%@ page contentType="text/html; charset=UTF-8" %> 
<% 
	String root = request.getContextPath(); 
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.imgbox {
  width: 500px;
  background-color: #ecefef;
}

.table {
	margin-left: 200px;
}
.filetype {
  position: relative;
  display: inline-block;
  vertical-align: top;
  *margin-right: 4px;
}

.filetype * {
  vertical-align: middle;
}

.filetype .file-text {
  position: relative;
  width: 203px;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
  display: inline-block;
  height: 25px;
  background-color: #ffffff;
  margin: 0;
  border: 1px solid #cdd3d4;
  line-height: 20px;
  z-index: 10;
}

.filetype .file-select {
  position: absolute;
  top: 0;
  right: 0;
  width: 80px;
  overflow: hidden;
}

.filetype .file-select .input-file {
  width: 60px;
  filter: alpha(opacity=0);
  opacity: 0;
  height: 20px;
}

.filetype .file-text + .file-btn {
  display: inline-block;
  background-color: #cdd3d4;
  height: 22px;
  line-height: 22px;
  padding: 0 15px;
  color: #000!important;
  cursor: pointer;
  *margin-left: 4px;
}
</style>

<!-- input file 스타일 변경 스크립트-->

<!-- <script>
	var $fileBox = $('.filetype');
	
	$fileBox.each(function() {
	  var $fileUpload = $(this).find('.input-file'),
	  	$fileText = $(this).find('.file-text')
	  $fileUpload.on('change', function() {
	    var fileName = $(this).val();
	    $fileText.attr('disabled', 'disabled').val(fileName);
	  })
	})
</script> -->

<!-- 아이디 체크 ajax -->

<script>
function getXmlHttp() {
    var xmlhttp;
    try {
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            xmlhttp = false;
        }
    }
    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
        xmlhttp = new XMLHttpRequest();
    }
    return xmlhttp;
}

var idFlag = false;
var pwFlag = false;

function checkId(event) {
    toggleLabel('idLb', 'id', 'out');

    var id = document.getElementById("id").value;
    var oMsg = document.getElementById("idMsg");
    if (id == "") {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "필수 정보입니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_ID_REQUIRED, document.getElementById("token_sjoin").value, true,'');
        lua_do2('join_kr'+document.getElementById("platform").value,'',ERROR_ID_REQUIRED+";keyboard^"+log2.sb(), document.getElementById("token_sjoin").value, true, document.getElementById("id").value);
        return false;
    }

    var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
    if (!isID.test(id)) {
        oMsg.style.display = "block";
        oMsg.className = "error";
        oMsg.innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
        lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_ID, document.getElementById("token_sjoin").value, true,'');
        return false;
    }

    idFlag = false;
    try {
        var xmlhttp = getXmlHttp();
        xmlhttp.open("GET", "/user2/joinAjax.nhn?m=checkId&id=" + id);
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4) {
                var result = xmlhttp.responseText.substr(4, 999);
                if (result == "Y") {
                    if (event == "first") {
                        oMsg.style.display = "block";
                        oMsg.className = "error gm";
                        oMsg.innerHTML = "멋진 아이디네요!";
                    } else {
                        oMsg.style.display = "none";
                    }
                    idFlag = true;
                    return true;
                } else {
                    oMsg.style.display = "block";
                    oMsg.className = "error";
                    oMsg.innerHTML = "이미 사용중이거나 탈퇴한 아이디입니다.";

                    lua_do('join_kr'+document.getElementById("platform").value,'',ERROR_FORMAT_ID, document.getElementById("token_sjoin").value, true,'');
                    return false;
                }
            }
        };
        xmlhttp.send(null);
    } catch (e) {
        if (window.bridgeGotTime) {
            throw e;
        }
    }

    return true;

}
</script>

<!-- 주소검색 api -->

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
<script type = "text/javascript">
function inputCheck(f){
	if(f.id.value==""){
		alert("아이디를 입력하세요 ^오^");
		f.id.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("비밀번호를 입력하세요 ^오^");
		f.passwd.focus();
		return false;
	}
	if(f.repasswd.value==""){
		alert("비밀번호를 확인하세요 ^오^");
		f.repasswd.focus();
		return false;
	}
	if(f.passwd.value!=f.repasswd.value){
		alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
		f.repasswd.value="";
		f.repasswd.focus();
		return false;
	}
	if(f.mname.value==""){
		alert("이름을 입력하세요.");
		f.mname.focus();
		return false;
	}
	if(f.email.value==""){
		alert("e-mail을 입력하세요.");
		f.email.focus();
		return false;
	}
	if(f.job.selectedIndex==0){
		alert("직업을 선택하세요.");
		f.job.focus();
		return false;
	}
}

function idCheck(id){
	if(id==""){
		alert("아이디를 입력하세요");
		document.frm.id.focus();
	}else{
		var url = "id_proc.jsp"
		url += "?id="+id;
		
		wr=window.open(url,"아이디검색","width=550,height=500");
		wr.moveTo((window.screen.width-550)/2,(window.screen.height-500)/2);
	}
}
	function emailCheck(email){
		if(email==""){
			alert("email을 입력하세요");
			document.frm.email.focus();
		}else{
			var url = "email_proc.jsp"
			url += "?email="+email;
			
			wr=window.open(url,"email검색","width=550,height=500");
			wr.moveTo((window.screen.width-550)/2,(window.screen.height-500)/2);
		}	

}
</script>

</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">회원가입</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  enctype="multipart/form-data"
	  action='./prcreateProc.jsp'
	  onsubmit = "return inputCheck(this)">
  <TABLE class="table table-bordered">
    <TR>
      <TH>사진</TH>
      <TD>
		  <input type="file" name="fname" class="input-file" size="3"></span>
      </TD>
    </TR>
    <TR>
      <TH>아이디</TH>
      <TD>
      	<input type="text" name="id" size="25">
      	<button type="button" onclick="idCheck(document.frm.id.value)">ID중복확인</button><br>
      	<div id="idMsg"></div>
      </TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd" size="25"></TD>
    </TR>
    <TR>
      <TH>비밀번호 확인</TH>
      <TD><input type="password" name="repasswd" size="25"></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><input type="text" name="mname" size="25"></TD>
    </TR>
    <TR>
      <TH>전화번호</TH>
    	 <TD><input type="text" name="tel" size="25"></TD>
    </TR>
    <TR>
      <TH>e-mail</TH>
      <TD><input type="text" name="email" size="25">
   	  <button type="button" onclick="emailCheck(document.frm.email.value)">e-mail중복확인</button>
      </TD>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD>
   		 <input type="text" name="zipcode" id="sample6_postcode" size="7" placeholder="우편번호">
   	 	 <button type="button" onclick="sample6_execDaumPostcode()">우편번호찾기</button>
      </TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD>
      	 <input type="text" name="address1" size="40" id="sample6_address"  placeholder="주소"><br>
     	 <input type="text" name="address2" size="40" id="sample6_address2"  placeholder="상세주소">
      </TD>
    </TR>
    <TR>
      <TH>직업</TH>
      <TD>
      <select name="job">
      	<option selected>선택하세요</option>
      	<option value = "A01">회사원</option>
      	<option value = "A02">학생</option>
      	<option value = "A03">주부</option>
      	<option value = "A04">갓수</option>
      	<option value = "A05">전산관련직</option>
      	<option value = "A06">연구전문직</option>
      	<option value = "A07">공무원</option>
      	<option value = "A08">의사</option>
      	<option value = "A09">예술가</option>
      	<option value = "A10">법조인</option>
      </select>
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='회원가입'>
    <input type='reset' value='취소'>
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/footer.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 