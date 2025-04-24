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

<a href="${pageContext.request.contextPath}/">&lt;</a><br>

아이디 : <input type="text" value="${member.userid}" readonly="readonly" id="userid"> <br>
비밀번호 : ${member.pw} <br/>
이름  : ${member.name} <br/>
닉네임  : ${member.nickname} <br/>
우편번호  : ${member.add_No} <br/>
주소  : ${member.address1} <br/>
상세주소  : ${member.address2} <br/>
이메일  : ${member.email} <br/>
전화번호  : ${member.phone} <br/>


<input type="button" value="메인" onclick="location.href='${pageContext.request.contextPath}/'">
<input type="button" value="수정" onclick="location.href='updateForm?userid=${member.userid}'">
<input type="button" value="탈퇴" onclick="deleteMember()">

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