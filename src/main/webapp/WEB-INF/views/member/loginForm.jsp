<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form name="loginForm" id="loginForm" action="login">
	아이디 : <input type="text" name="userid" id="userid" required="required"><br/>
	비밀번호 : <input type="password" name="pw" id="pw" required="required"><br/>
	<input type="submit" value="로그인"> 	
</form>

	<script type="text/javascript">
	 	let loginForm = document.querySelector("#loginForm");
		const userid = document.querySelector("#userid");   	
		const pw = document.querySelector("#pw");   	
		
		//로그인버튼
	 	if (loginForm) {
	 		//이벤트 핸들러 등록 
	 		loginForm.addEventListener("submit", e => {
				e.preventDefault();  // form의 기본 동작을 취소함.

				
				//form의 하위 객체를 이름을 사용하여 접근 하는 방법
				const param = {
					userid : userid.value,   	
					pw : pw.value   	
				}
				
				fetch("login", { 
					  method: 'post', 
					  headers: {
					    'Content-Type': 'application/json;charset=utf-8'
					  },
					  body: JSON.stringify(param),
					  credentials: 'include'
					})
					  .then(response => response.json())
					  .then(json => {
						  if (json.status == "error") {
							  alert(json.errorMessage);
							  userid.value = "";
							  pw.value = "";
							  userid.focus();
						  } else if (!json.loginSecces) {
							  alert(json.message);
						  }  else {
							 location = "${pageContext.request.contextPath}/"; //el 구문을 사용한 절대 경로 표기법  
						  }
				})	 			

	 		})
	 	}
	
	
	
	
	</script>

</body>
</html>