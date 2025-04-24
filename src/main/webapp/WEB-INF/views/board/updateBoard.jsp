<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_style.css">
<style>
  h2 {
    font-size: 1.8em;
    color: #007bff;
    margin-bottom: 20px;
  }

  h2 a {
    font-size: 1.2em;
    color: #007bff;
    text-decoration: none;
    cursor: pointer;
  }

  form {
    background-color: #ffffff;
    border: 1px solid #ddd;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    max-width: 800px;
    margin: 0 auto;
  }

  form label {
    display: block;
    margin-top: 15px;
    font-weight: bold;
    font-size: 1.1em;
  }

  form input[type="text"],
  form input[type="password"],
  form input[type="email"],
  form input[type="tel"] {
    width: 100%;
    padding: 12px;
    margin-top: 8px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 1em;
  }

  form select {
    width: 100%;
    padding: 12px;
    margin-top: 8px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 1em;
  }

  textarea {
    width: 100%;
    padding: 12px;
    margin-top: 8px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 1em;
  }

  .button-style {
    padding: 8px 16px;
    font-weight: bold;
    border: none;
    border-radius: 6px;
    background-color: #007bff;
    color: #fff;
    cursor: pointer;
  }

  .button-style:hover {
    background-color: #0056b3;
  }

  .back-link {
    display: inline-block;
    margin-bottom: 20px;
    font-size: 1.2em;
    color: #007bff;
    text-decoration: none;
  }

  .back-link:hover {
    text-decoration: underline;
  }
</style>
</head>
<body>

<h2>게시물 수정</h2>

<form action="update" method="post" id="updateForm">
  <input type="hidden" value="${board.post_no }" id="post_no">
  <input type="hidden" value="${member.userid}" id="userid">

  <table>
    <tr>
      <th>카테고리</th>
      <td><select name="c_no" id="c_no" required="required">
          <option value="0" ${board.c_no == 0 ? 'selected' : ''}>--카테고리--</option>
        <c:if test="${member.m_role == 0}">
           <option value="1">공지사항</option>
        </c:if>
          <option value="2" ${board.c_no == 2 ? 'selected' : ''}>게시판</option>
        </select></td>
      <th>현재 비밀번호</th>
      <td><input type="password" id="post_pw" placeholder="수정 시 기존 비밀번호 입력"></td>
    </tr>

    <tr>
      <th>제목</th>
      <td><input type="text" id="title" value="${board.title }" required></td>
      <th>새 비밀번호 (변경 시 입력)</th>
      <td><input type="password" id="new_pw" placeholder="변경 안 할 경우 공란" /></td>
    </tr>

    <tr>
      <td colspan="4">
        <textarea id="content" name="content" rows="5" cols="100" placeholder="내용을 입력하세요" required>${board.content}</textarea>
      </td>
    </tr>
  </table>

  <input type="submit" value="등록" id="updateBtn" class="button-style">
  <input type="button" value="취소" class="button-style" style="background-color: #6c757d;" onclick="if (!confirm('변경된 내용은 저장되지 않습니다. 수정을 그만두시겠습니까?')) return; history.back();">
</form>



<script type="text/javascript">

  if (updateForm) {
	    // 이벤트 핸들러 등록
	    updateForm.addEventListener("submit", e => {
	      e.preventDefault();  // form의 기본 동작을 취소함.

  let updateForm = document.querySelector("#updateForm");
  let c_no = document.querySelector("#c_no").value;
  let post_no = document.querySelector("#post_no").value;
  let post_pw = document.querySelector("#post_pw").value;
  let new_pw = document.querySelector("#new_pw").value; // 새 비밀번호
  let title = document.querySelector("#title").value;
  let content = document.querySelector("#content").value;
  
	      if (!confirm("등록 하시겠습니까?")) return;

	      // 비밀번호가 있을 때만 검사 메시지 띄움
	      if (post_pw && post_pw !== "") {
	        alert("비밀번호 분실 시 삭제할 수 없습니다");
	        return;
	      }

	      // 새 비밀번호가 있으면 그걸로, 아니면 기존 비밀번호로
	      const param = {
	        post_no: post_no,
	        c_no: c_no,
	        title: title,
	        post_pw: new_pw && new_pw !== "" ? new_pw : post_pw,
	        content: content
	      };
      console.log("param", param);

      fetch("updateBoard", {
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
            alert("업로드가 완료되었습니다.");
            location = "detailView?post_no=${board.post_no}";
          }
        })
    })
  }
</script>

</body>
</html>