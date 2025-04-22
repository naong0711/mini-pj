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

<form name="updateForm" id="updateForm" action="update" method="post">

아이디 : <input type="text" value="${member.userid}" readonly="readonly" id="userid"> <br>
비밀번호 : <input type="password" value="${member.pw}" readonly="readonly" id="pw"> <br> 
이름 : <input type="text" value="${member.name}" id="name"> <br>
닉네임 : <input type="text" value="${member.nickname}" id="nickname"> <br>
우편번호 : <input type="text" value="${member.add_No}" id="add_No"> <br>
주소 : <input type="text" value="${member.address1}" id="address1"> <br>
상세주소 : <input type="text" value="${member.address2}" id="address2"> <br>
이메일 : <input type="text" value="${member.email}" id="email"> <br>
전화번호 : <input type="text" value="${member.phone}" id="phone"> <br>
<br>
비밀번호 확인 : <input type="password"id="pw2" required="required"> <br> 

<input type="submit" value="변경" >
<input type="reset" value="초기화" >
<input type="button" value="취소" onclick="location.href='myPage?userid=${member.userid}'">


</form>


<script type="text/javascript">
	 	
	 	//정보수정
	 	let updateForm = document.querySelector("#updateForm");
	 	if (updateForm) {
	 		//이벤트 핸들러 등록 
	 		updateForm.addEventListener("submit", e => {
				e.preventDefault();  // form의 기본 동작을 취소함.
				
				if (!confirm("정보를 수정하시겠습니까?")) return;

				//비밀번호 확인
				const pw = document.querySelector("#pw");
				const pw2 = document.querySelector("#pw2");
				if (pw.value != pw2.value) {
					alert("비밀번호가 다릅니다");
					pw2.value = "";
					pw2.focus();

					return;
				}
				
				
				//form의 하위 객체를 이름을 사용하여 접근 하는 방법
				const param = {
					userid : document.querySelector("#userid").value,   	
					pw : updateForm.pw.value,  	
					name : document.querySelector("#name").value,   	
					nickname : document.querySelector("#nickname").value,   	
					phone : document.querySelector("#phone").value,   	
					add_No : document.querySelector("#add_No").value,   	
					address1 : document.querySelector("#address1").value,   	
					address2 : document.querySelector("#address2").value,   	
					email : document.querySelector("#email").value	
				}
				console.log("param", param);
				
				fetch("update", { 
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
							  alert("정보수정이 완료되었습니다.");
							  location = "myPage?userid=${member.userid}";
						  }
				})	 			
	 		})
	 	}
	
	 	
	 	
	 	
	
	</script>




</body>
</html>