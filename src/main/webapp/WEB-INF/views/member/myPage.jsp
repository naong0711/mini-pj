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
/* 전체 레이아웃 중앙 정렬 */
body {
  font-family: 'Arial', sans-serif;
  background-color: #f9f9f9;
  padding: 40px 20px;
  margin: 0;
}

/* 회원정보 박스 */
div.info-box {
  background-color: #ffffff;
  border: 1px solid #ddd;
  padding: 24px 32px;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  margin: 0 auto;
  max-width: 700px;
}

/* 회원정보 테이블 */
table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  padding: 12px;
  text-align: left;
}

th {
  background-color: #f0f2f5;
  color: #333;
}

tr:hover {
  background-color: #fafafa;
}

/* 버튼 정렬 및 스타일 */
.button-container {
  text-align: right;
  margin-top: 20px;
}

button {
  padding: 10px 18px;
  margin-left: 10px;
  border: none;
  border-radius: 6px;
  color: white;
  font-weight: bold;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

</style>
</head>
<body>
<input type="hidden" value="${member.userid}" id="userid">
<h1><a href="${pageContext.request.contextPath}/">&lt;</a> 회원 정보</h1>

<div class="info-box">
  <table>
    <tr>
      <th>아이디</th>
      <td>${member.userid}</td>
    </tr>
    <tr>
      <th>비밀번호</th>
      <td>${member.pw}</td>
    </tr>
    <tr>
      <th>이름</th>
      <td>${member.name}</td>
    </tr>
    <tr>
      <th>닉네임</th>
      <td>${member.nickname}</td>
    </tr>
    <tr>
      <th>우편번호</th>
      <td>${member.add_No}</td>
    </tr>
    <tr>
      <th>주소</th>
      <td>${member.address1}</td>
    </tr>
    <tr>
      <th>상세주소</th>
      <td>${member.address2}</td>
    </tr>
    <tr>
      <th>이메일</th>
      <td>${member.email}</td>
    </tr>
    <tr>
      <th>전화번호</th>
      <td>${member.phone}</td>
    </tr>
  </table>

  <button onclick="location.href='updateForm?userid=${member.userid}'">수정</button>
  <button onclick="deleteMember()" style="background-color: #6c757d;">탈퇴</button>

</div>
	
<script type="text/javascript">

function deleteMember() {

	const userid = document.querySelector("#userid").value;
	
	if (!confirm("정말 탈퇴하시겠습니까?")) return;
	
	fetch('deleteMember', {
		  method: 'DELETE',
		  headers: {
		    'Content-Type': 'application/json'
		  },
		  body: JSON.stringify({ userid: userid }) 
		})
		  .then(res => res.json())
		  .then(data => {
			  console.log('응답:', data);
			  alert(data.message);
			  location = "${pageContext.request.contextPath}/"
		  })
		  .catch(err => console.error(err));
	
}



</script>

</body>
</html>