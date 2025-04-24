<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_style.css">
<title>Insert title here</title>
<style>
  body {
    font-family: 'Arial', sans-serif;
    background-color: #f9f9f9;
    padding: 40px 20px;
    margin: 0;
  }

  form {
    background-color: #ffffff;
    border: 1px solid #ddd;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    max-width: 700px;
    margin: 0 auto;
  }

  form label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
  }

  form input[type="text"],
  form input[type="password"],
  form input[type="email"],
  form input[type="tel"] {
    width: 50%;
    padding: 10px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;

  }

  .button-group {
    text-align: right;
    margin-top: 30px;
  }

  .button-group input[type="button"] {
    padding: 10px 18px;
    border: none;
    border-radius: 6px;
    margin-left: 10px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    background-color: #6c757d;
    transition: background-color 0.2s ease;
  }

  .button-group input[type="button"]:hover {
    background-color: none;
  }

  input[type="text"][readonly],
  input[type="password"][readonly],
  input[type="email"][readonly],
  input[type="tel"][readonly] {
    background-color: #f1f1f1;
    cursor: not-allowed;
  }
  
input[type="button"]:disabled {
	background: gray;
}

.no-hover:disabled:hover {
  background-color: gray !important;
  color: white !important;
  cursor: default !important;
  transform: translateY(0px) !important;
}

</style>
</head>
<body>
	<h1><a onclick="history.back()">&lt;</a> 멤버정보</h1>

<form>

  아이디 : <input type="text" value="${member.userid}" readonly="readonly" id="userid"> <br>
  비밀번호 : <input type="password" value="${member.pw}" readonly="readonly" id="pw"> <br/>
  이름 : <input type="text" value="${member.name}" readonly="readonly" id="name"> <br/>
  닉네임 : <input type="text" value="${member.nickname}" readonly="readonly" id="nickname"> <br/>
  우편번호 : <input type="text" value="${member.add_No}" readonly="readonly" id="add_No"> <br/>
  주소 : <input type="text" value="${member.address1}" readonly="readonly" id="address1"> <br/>
  상세주소 : <input type="text" value="${member.address2}" readonly="readonly" id="address2"> <br/>
  이메일 : <input type="email" value="${member.email}" readonly="readonly" id="email"> <br/>
  전화번호 : <input type="text" value="${member.phone}" readonly="readonly" id="phone"> <br/>
  가입날짜 : <input type="text" value="${fn:substring(member.reg_at, 0, 10)}" readonly="readonly" id="reg_at"> <br/>
  탈퇴여부 : <input type="text" value="${member.is_del}" readonly="readonly" id="is_del"> <br/>
  
  <c:if test="${member.is_del == 'T'}">
    탈퇴일시 : <input type="text" value="${fn:substring(member.del_at, 0, 10)}" readonly="readonly" id="del_at"> <br/>
  </c:if>
  
  잠금여부 : <input type="text" value="${member.is_lock}" readonly="readonly" id="is_lock">
  <input type="button" value="잠금해제" id="unlockBtn" onclick="unlock()" class="no-hover" disabled>
  <br><hr>

</form>

<script type="text/javascript">

//잠금여부에 따른 버튼 활성화
let unlockBtn = document.querySelector("#unlockBtn");
const is_lock = document.querySelector("#is_lock").value;

console.log(is_lock);
if(is_lock == "T") { //잠금상태이면
  unlockBtn.disabled = false; //버튼 활성화
}

//잠금해제
function unlock() {
  
  const userid = document.querySelector("#userid").value;
  
  if (!confirm("잠금을 해제하겠습니까?")) return;
  
  fetch('unlockMember', {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ userid: userid }) 
  })
  .then(res => res.json())
  .then(data => {
    console.log('응답:', data);
    alert(data.message);
    location.reload();
  })
  .catch(err => console.error(err));
}

</script>

</body>
</html>