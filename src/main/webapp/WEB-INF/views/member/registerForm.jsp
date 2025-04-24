<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/">&lt;</a><br>
	<h1>회원가입</h1>
	<form name="registerForm" id="registerForm" action="register"
		method="post">
		아이디 <input type="text" name="userid" id="userid" required="required">
		<input type="button" value="중복확인" id="validButton"> *8자 이상 입력해주세요 <br />
		비밀번호 <input type="password" name="pw" id="pw" required="required"> *영문자+숫자+특수문자 1개이상 포함 최소8자<br />
		비밀번호확인 <input type="password" name="pw2" id="pw2" required="required"><br />
		이름 <input type="text" name="name" id="name" required="required"><br />
		닉네임 <input type="text" name="nickname" id="nickname" required="required"><br />
		전화번호 <input type="tel"name="phone" id="phone" required="required" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"><br />
		우편번호 <input type="number" name="add_No" id="add_No" required="required"><br />
		주소 <input type="text" name="address1" id="address1" required="required"><br />
		상세주소 <input type="text" name="address2" id="address2" required="required"><br />
		이메일 <input type="text" name="email" id="email" required="required">
			 <select name="emailDomain" id="emailDomain" required="required">
			  	<option value="gmail.com">gmail.com</option>
			  	<option value="naver.com">naver.com</option>
			  	<option value="daum.net">daum.net</option>
		        <option value="">--직접입력--</option>
			</select>
			<input type="text" id="emailCustomDomain" style="display:none;" placeholder="도메인 입력">

		<br/>

		<input type="submit" value="회원가입"> <input type="reset" value="초기화"> <br/>
	</form>


	<script type="text/javascript">
	//아이디 중복검사 & 8자 이상 입력
	//비밀번호 형식 검사& 비밀번호 확인
		let existUserId = true; //서버에 존재하는 아이디인지
		let validClicked = false;  //아이디 중복확인검사여부
	//비밀번호 정규식
		 const regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_\-+=\[\]{};':"\\|,.<>\/?]).{8,}$/;
	//이메일 정규식
		 const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
		 
	//이메일 직접입력시 직접입력칸 보이기
	const emailDomainSelect = document.querySelector("#emailDomain");
	const customDomainInput = document.querySelector("#emailCustomDomain");
	
	emailDomainSelect.addEventListener("change", () => {
		  if (emailDomainSelect.value === "") {
		    customDomainInput.style.display = "inline-block";
		  } else {
		    customDomainInput.style.display = "none";
		  }
		});
	
		//아이디 중복검사
	 	let validButton = document.querySelector("#validButton");
	 	if (validButton) {
	 		validButton.addEventListener("click", e => {
	 			validClicked = true;

				const userid = document.querySelector("#userid");
	 			if(userid.value.length == 0) {
	 				alert("아이디를 입력해주세요");
	 				userid.focus();
	 				return ;
	 			} else if (userid.value.length < 8) {
	 				alert("아이디는 8자 이상이어야 합니다.");
	 				userid.focus();	
	 				return ;
	 			}  

				fetch("isExistUserId", { 
				  method: 'post', 
				  headers: {
				    'Content-Type': 'application/json;charset=utf-8'
				  },
				  body: JSON.stringify({userid : userid.value})
				})
				  .then(response => response.json())
				  .then(json => {
					  existUserId = json.existUserId;//서버에서 전달된 값
					  if (existUserId) {
						  alert("[" + userid.value + "] 해당 아이디는 사용 불가능 합니다 ")
					  } else {
						  alert("[" + userid.value + "] 해당 아이디는 사용 가능 합니다 ")
					  }
					  console.log('POST요청결과:', json) 
				  })	 			
	 		});
	 	}
	 	
	 	//회원가입 폼 검사
	 	let registerForm = document.querySelector("#registerForm");
	 	if (registerForm) {
	 		//이벤트 핸들러 등록 
	 		registerForm.addEventListener("submit", e => {
				e.preventDefault();  // form의 기본 동작을 취소함.
				
				if (!confirm("회원 가입하시겠습니까?")) return;
				
				console.log("validClicked = " , validClicked);
				console.log(validClicked == false);
				
				if (validClicked === false) {
					alert("아이디 중복을 검사해주세요");
					return ;
				}
				
				//비밀번호&비밀번호 확인
				const pw = document.querySelector("#pw");
				const pw2 = document.querySelector("#pw2");
				if (pw.value != pw2.value) {
					alert("비밀번호가 잘못되었습니다");
					pw.value = "";
					pw2.value = "";
					pw.focus();

					return;
				}
				
				//비밀번호 형식 확인
				if(!regex.test(pw.value)) {
					
					alert("비밀번호 형식이 잘못되었습니다. 비밀번호는 영문자+숫자+특수문자를 포함하여 8자 이상이어야합니다.");
					pw.value = "";
					pw2.value = "";
					pw.focus();
					
					return;
				} 
				
				//이메일 형식
				const emailId = document.querySelector("#email").value; //사용자입력필드
				const domain = emailDomainSelect.value || customDomainInput.value; //이메일 가져오기
				const fullEmail = emailId + "@" + domain; //전체이메일
				console.log(fullEmail);

				//이메일 형식 확인
				if(!emailRegex.test(fullEmail)) {
					alert("이메일 형식이 잘못되었습니다.");
					customDomainInput.focus();
					return;
				}
				
				//form의 하위 객체를 이름을 사용하여 접근 하는 방법
				const param = {
					userid : registerForm.userid.value,   	
					pw : registerForm.pw.value,   	
					name : document.querySelector("#name").value,   	
					nickname : document.querySelector("#nickname").value,   	
					phone : document.querySelector("#phone").value,   	
					add_No : document.querySelector("#add_No").value,   	
					address1 : document.querySelector("#address1").value,   	
					address2 : document.querySelector("#address2").value,   	
					email : fullEmail
				}
				console.log("param", param);

				fetch("register", { 
					  method: 'post', 
					  headers: {
					    'Content-Type': 'application/json;charset=utf-8'
					  },
					  body: JSON.stringify(param)
					})
					  .then(response => response.json())
					  .then(json => {
						  if (json.status == "error") {
							  alert(json.errorMessage);
						  } else {
							  alert("회원가입이 완료되었습니다.");
							  location = "loginForm";
						  }
				})

	 		})
	 	}
	
	 	
	 	
	 	
	
	</script>




</body>
</html>