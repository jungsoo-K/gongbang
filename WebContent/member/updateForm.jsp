<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp"%>
<%
	String id = request.getParameter("id");
	if (id == null)
		id = (String) session.getAttribute("id");
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

<title></title>
<link href="<%=root%>/css/templStyle.css" rel="Stylesheet" type="text/css">

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
<script type="text/javascript">
	function inputCheck(f){
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
	function emailCheck2(i){
		alert("이메일 변경을 원하시면 이메일 중복확인버튼을 사용하세요")
		i.blur();
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
<body>
	<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" flush="false"/>
	<!-- *********************************************** -->

	<DIV class="title">내 정보 수정</DIV>

	<FORM name='frm'
		  method='POST'
		  action='./updateProc.jsp'
		  onsubmit="return inputCheck(this)">
		<input type="hidden" name="id" value="<%=vo.getId()%>">
		<TABLE>
			<TR>
				<TH>사진</TH>
				<TD colspan='2'><img src="./storage/<%=vo.getFname()%>"></TD>
			</TR>
			<TR>
				<TH>아이디</TH>
				<TD><%=vo.getId()%></TD>
			</TR>
			<TR>
				<TH>이름</TH>
				<TD><%=vo.getMname()%></TD>
			</TR>
			<TR>
				<TH>전화번호</TH>
				<TD><input type="text" name="tel" size="15"	value="<%=vo.getTel()%>"></TD>
			</TR>
			<TR>
				<TH>e-mail</TH>
				<TD><input type="text" name="email" size="25"
					value="<%=vo.getEmail()%>" onclick="emailCheck2(this)">
					<button type="button"
						onclick="emailCheck(document.frm.email.value)">e-mail중복확인</button>
				</TD>
			</TR>
			<TR>
				<TH>우편번호</TH>
				<TD><input type="text" name="zipcode" id="sample6_postcode"
					size="7" placeholder="우편번호" value="<%=vo.getZipcode()%>">
					<button type="button" onclick="sample6_execDaumPostcode()">우편번호찾기</button>
				</TD>
			</TR>
			<TR>
				<TH>주소</TH>
				<TD><input type="text" name="address1" size="40"
					id="sample6_address" placeholder="주소" value="<%=vo.getAddress1()%>"><br>
					<input type="text" name="address2" size="40" id="sample6_address2"
					placeholder="상세주소" value="<%=vo.getAddress2()%>"></TD>
			</TR>
			<TR>
				<TH>*직업</TH>
				<TD><select name="job">
						<option selected>선택하세요</option>
						<option value="A01">회사원</option>
						<option value="A02">학생</option>
						<option value="A03">주부</option>
						<option value="A04">갓수</option>
						<option value="A05">전산관련직</option>
						<option value="A06">연구전문직</option>
						<option value="A07">공무원</option>
						<option value="A08">의사</option>
						<option value="A09">예술가</option>
						<option value="A10">법조인</option>
				</select> 
				<script type="text/javascript">
					document.frm.job.value='<%=vo.getJob()%>'
				</script>
      			</TD>
			</TR>
		</TABLE>

		<DIV class='bottom'>
			<input type='submit' value='회원수정'>
			<input type='reset' value='취소'>
		</DIV>
	</FORM>

	<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" flush="false"/>
	<!-- *********************************************** -->
</body>
</html>