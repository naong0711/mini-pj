<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_style.css">
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<style>
  body {
    font-family: 'Arial', sans-serif;
    background-color: #f9f9f9;
    padding: 40px 20px;
    margin: 0;
  }

  form#updateForm {
    background-color: #ffffff;
    border: 1px solid #ddd;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    max-width: 700px;
    margin: 0 auto;
  }

  form#updateForm label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
  }

  form#updateForm input[type="text"],
  form#updateForm input[type="password"],
  form#updateForm input[type="email"],
  form#updateForm input[type="tel"] {
    width: 100%;
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

  .button-group input[type="submit"],
  .button-group input[type="reset"],
  .button-group input[type="button"] {
    padding: 10px 18px;
    border: none;
    border-radius: 6px;
    margin-left: 10px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }

  input[type="submit"] {
    background-color: #28a745;
  }

  input[type="submit"]:hover {
    background-color: #218838;
  }

  input[type="reset"] {
    background-color: #ffc107;
  }

  input[type="reset"]:hover {
    background-color: #e0a800;
  }

  input[type="button"] {
    background-color: #6c757d;
  }

  input[type="button"]:hover {
    background-color: #5a6268;
  }
</style>
</head>
<body>

<form name="updateForm" id="updateForm" action="update" method="post">

  <label>아이디</label>
  <input type="text" value="${member.userid}" readonly="readonly" id="userid">

  <label>비밀번호</label>
  <input type="password" value="${member.pw}" readonly="readonly" id="pw">

  <label>이름</label>
  <input type="text" value="${member.name}" id="name">

  <label>닉네임</label>
  <input type="text" value="${member.nickname}" id="nickname">

  <label>우편번호</label>
  <input type="text" value="${member.add_No}" id="add_No">

  <label>주소</label>
  <input type="text" value="${member.address1}" id="address1">

  <label>상세주소</label>
  <input type="text" value="${member.address2}" id="address2">

  <label>이메일</label>
  <input type="email" value="${member.email}" id="email">

  <label>전화번호</label>
  <input type="tel" value="${member.phone}" id="phone" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">

  <label>비밀번호 확인</label>
  <input type="password" id="pw2" required="required">

    <input type="submit" value="변경">
    <input type="reset" value="초기화" style="background-color: #6c757d;">
    <input type="button" value="취소" style="background-color: #6c757d;" onclick="location.href='myPage?userid=${member.userid}'">

</form>

<script type="text/javascript">
  let updateForm = document.querySelector("#updateForm");
  if (updateForm) {
    updateForm.addEventListener("submit", e => {
      e.preventDefault();

      if (!confirm("정보를 수정하시겠습니까?")) return;

      const pw = document.querySelector("#pw");
      const pw2 = document.querySelector("#pw2");
      if (pw.value != pw2.value) {
        alert("비밀번호가 다릅니다");
        pw2.value = "";
        pw2.focus();
        return;
      }

      const param = {
        userid: document.querySelector("#userid").value,
        pw: updateForm.pw.value,
        name: document.querySelector("#name").value,
        nickname: document.querySelector("#nickname").value,
        phone: document.querySelector("#phone").value,
        add_No: document.querySelector("#add_No").value,
        address1: document.querySelector("#address1").value,
        address2: document.querySelector("#address2").value,
        email: document.querySelector("#email").value
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
      });
    });
  }
</script>

</body>
</html>