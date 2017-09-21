<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/member/ssi.jsp" %>

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
</head>
<body>
<!-- *********************************************** -->
	<jsp:include page="/menu/top.jsp" />
<!-- *********************************************** -->
	
	
<!-- container -->
	<div id="container">
		
		<!-- content -->
		<div id="content">
			<h2 class="blind">네이버 회원가입</h2>
			<div class="join_content">
				<div class="join_form">
				
<form id="join_form" method="post" action="/user2/join.nhn?m=check" onSubmit="return mainSubmit(0);">		
	<input type="hidden" id="birthday" name="birthday" value="">		
	<input type="hidden" id="token_sjoin" name="token_sjoin" value="LiSKbHWsxGIrtre1">
	<input type="hidden" id="joinMode" name="joinMode" value="unreal">
	<input type="hidden" id="pbirthday" name="pbirthday" value="">
	<input type="hidden" id="ptelecom" name="ptelecom" value="SKT">
	<input type="hidden" id="authFlag" name="authFlag" value="N">
	<input type="hidden" id="ipinFlag" name="ipinFlag" value="N">
	<input type="hidden" id="encPswd" name="encPswd" value="">
	<input type="hidden" id="encKey" name="encKey" value="">
	<input type="hidden" id="platform" name="platform" value="PC">
	<input type="hidden" id="old_mobno" name="old_mobno" value="">
	<input type="hidden" id="old_pmobno" name="old_pmobno" value="">
	<input type="hidden" id="old_imobno" name="old_imobno" value="">
	<input type="hidden" id="old_authno" name="old_authno" value="">
	<input type="hidden" id="agentType" name="agentType" value="">
    <input type="hidden" id="nid_t2" name="nid_t2" value="">
    <input type="hidden" id="nid_ev2" name="nid_ev2" value="">
    <input type="hidden" id="nid_ev2_old" name="nid_ev2_old" value="">
    <input type="hidden" id="nid_kb2" name="nid_kb2" value="">

				<fieldset class="join_from">						
					<legend class="blind">회원가입</legend>	
					<div class="row_group">
						<div id="idDiv" class="join_row">
							<span class="ps_box int_id">
								<input type="text" id="id" name="id" value="" maxlength="20" autocomplete="off" 
								onFocus="toggleLabel('idLb','id', 'in');"
								onBlur="toggleLabel('idLb','id', 'out');checkId('first')"
								placeholder="아이디" class="int"> 
								<label id="idLb" for="id" class="lbl">아이디</label> <button type="button" disabled="" title="delete" class="wrg">삭제</button>
							</span> 
							<!-- class:error e_info, error, error gm -->
							<div id="idMsg" class="error" style="display:none">필수 정보입니다.</div>
						</div>						
						<div id="pswd1Div" class="join_row">
							<!-- [D]normal상태 int_pass / 1단계 사용불가 int_pass_step1 / 2단계 낮음 int_pass_step2 / 3단계 적정 int_pass_step3 / 4단계 높음 int_pass_step4 -->							
							<span id="pswd1Img" class="ps_box int_pass">
								<input type="password" id="pswd1" name="pswd1" maxlength="20"
								onFocus="toggleLabel('pswd1Lb','pswd1','in');"
								onBlur="toggleLabel('pswd1Lb','pswd1','out');checkPswd1('check')";								
								onkeyup="checkShiftUp(event);"								
								onkeypress="checkCapslock(event)";
								onKeydown="checkShiftDownJoin(event);"								 
								placeholder="비밀번호" class="int"> 
								<label id="pswd1Lb" for="pswd1" class="lbl">비밀번호</label> <button type="button" disabled="" title="delete" class="wrg">삭제</button>
							</span>							
							<div id="pswd1Msg" class="error" style="display:none">필수 정보입니다.</div>
						</div>
						<div id="pswd2Div" class="join_row">
							<!-- [D]normal상태 int_pass_check / 비밀번호 확인완료 int_pass_check2  -->							
							<span id="pswd2Img" class="ps_box int_pass_check">
								<input type="password" id="pswd2" name="pswd2" maxlength="20"
								onFocus="toggleLabel('pswd2Lb','pswd2','in');"
								onBlur="toggleLabel('pswd2Lb','pswd2','out');checkPswd2('check')";
								onkeyup="checkShiftUp(event);"								
								onkeypress="checkCapslock2(event)";
								onKeydown="checkShiftDown(event);"
								placeholder="비밀번호 재확인" class="int"> 
								<label id="pswd2Lb" for="pswd2" class="lbl">비밀번호 재확인</label> <button type="button" disabled="" title="delete" class="wrg">삭제</button>
							</span> 
							<div id="pswd2Msg" class="error" style="display:none">필수 정보입니다.</div>
						</div>
					</div>

					<div class="row_group">
						<div id="nmDiv" class="join_row">
							<span class="ps_box">
								<input type="text" id="nm" name="nm" maxlength="40" value=""
								onFocus="toggleLabel('nmLb','nm','in');"
								onBlur="toggleLabel('nmLb','nm','out');checkName('check')"
								placeholder="이름" class="int"> 
								<label id="nmLb" for="nm" class="lbl">이름</label> <button type="button" disabled="" title="delete" class="wrg">삭제</button>
							</span>
							<div id="nmMsg" class="error" style="display:none">필수 정보입니다.</div>
						</div>						
						<div id="sexDiv" class="join_row join_sex">
							<span class="row_title blind"> 성별 </span>
							<span class="sex">
								<span class="jender"><input type="radio" id="man" name="sex" value="0" onClick="checkSex()" /><label id="manLb" for="man">남자 </label>
								</span><span class="jender"><input type="radio" id="woman" name="sex" value="1" onClick="checkSex()" /><label id="womanLb" for="woman">여자 </label></span>
							</span>
							<span id="sexMsg" class="error" style="display:none">필수 정보입니다.</span>
						</div>
						
						<div id="birthdayDiv" class="join_row join_birthday">
							<div class="join_birth">
								<div class="bir_title"><span>생일</span></div>
								<div class="bir_yy">
									<span class="ps_box">
										<input type="text" id="yy" maxlength="4" value=""
										onFocus="toggleLabel('yyLb','yy','in');"
										onBlur="toggleLabel('yyLb','yy','out');checkBirthday('check')"
										placeholder="년(4자)" class="int"> 
										<label id="yyLb" for="yy" class="lbl">년(4자)</label> <button type="button" disabled="" title="delete" class="wrg">삭제 </button>
									</span>
								</div>
								<span class="cell">|</span>
								<div class="bir_mm">
									<span class="ps_box">
										<select id="mm" title="월" class="sel" onChange="checkBirthday('check')">
											<option value="">월</option>
										  	 			<option value="1" >1</option>
										  	 			<option value="2" >2</option>
										  	 			<option value="3" >3</option>
										  	 			<option value="4" >4</option>
										  	 			<option value="5" >5</option>
										  	 			<option value="6" >6</option>
										  	 			<option value="7" >7</option>
										  	 			<option value="8" >8</option>
										  	 			<option value="9" >9</option>
										  	 			<option value="10" >10</option>
										  	 			<option value="11" >11</option>
										  	 			<option value="12" >12</option>
										</select>
									</span>
								</div>
								<span class="cell">|</span>
								<div class=" bir_dd">
									<span class="ps_box">
										<input type="text" id="dd" maxlength="2" value=""
										onFocus="toggleLabel('ddLb','dd','in');"
										onBlur="toggleLabel('ddLb','dd','out');checkBirthday('check')"
										placeholder="일" class="int"> 
										<label id="ddLb" for="dd" class="lbl">일</label> <button type="button" disabled="" title="delete" class="wrg">삭제 </button>
									</span>
								</div>
							</div>
							<span id="birthdayMsg" class="error" style="display:none">필수 정보입니다.</span>
						</div>
						<div id="emailDiv" class="join_row join_email">
							<span class="ps_box int_email">
								<input type="text" id="email" name="email" maxlength="100" value=""
								onFocus="toggleLabel('emailLb','email','in');"
								onBlur="toggleLabel('emailLb','email','out');checkEmail('check')"								
								placeholder="본인확인 이메일(선택)" class="int">
								<label id="emailLb" for="email" class="lbl">본인확인 이메일(선택)</label> <button type="button" disabled="" title="delete" class="wrg">삭제</button>
							</span>
							<div id="emailMsg" class="error" style="display:none">필수 정보입니다.</div>
						</div>
					</div>
									
				
	
	
	
<!-- *********************************************** -->
	<jsp:include page="/menu/footer.jsp" />
<!-- *********************************************** -->
</body>
</html>