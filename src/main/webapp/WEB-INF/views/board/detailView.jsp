<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_style.css">
<title>멤버정보</title>
<style>
  h1 {
    font-size: 1.8em;
    color: #007bff;
    margin-bottom: 20px;
  }

  h1 a {
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

  hr {
    margin: 20px 0;
    border: 0;
    border-top: 1px solid #ddd;
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


</style>
</head>
<body>
  <a href="${pageContext.request.contextPath}/" class="back-link">&lt; 목록으로</a>
  <input type="hidden" value="${board.post_no}" id="post_no">
  <input type="hidden" value="${board.post_pw}" id="post_pw">
  
  <div class="board-details">
    <h3>${board.title}</h3>
      <span style="color:gray;">${board.userid}</span>
      <span style="float:right; color:gray;">${board.post_at} | 조회수: ${board.view_cnt}</span>

    <hr>

    <div class="board-content">${board.content}</div>
  </div>
 
<c:if test="${member.userid ==  board.userid || member.m_role == 0}">
<input type="button" value="수정" onclick="updatePost()" class="button-style">
<input type="button" value="삭제" onclick="delPost()" class="button-style" style="background-color: #6c757d;">
</c:if>

<script type="text/javascript">
	const post_no = document.querySelector("#post_no").value;
	const post_pw = document.querySelector("#post_pw").value;
	
	function updatePost() {
		  // 비밀번호가 없는 경우 바로 업데이트 페이지로 이동
		  if (!post_pw || post_pw === "") {
		    location.href = 'updatePost?post_no=' + post_no;
		    return;
		  }

		  const inputPw = prompt("비밀번호를 입력하세요:");
		  if (inputPw === null || inputPw === "") return;

		  fetch('checkPassword', {
		    method: 'POST',
		    headers: {
		      'Content-Type': 'application/json'
		    },
		    body: JSON.stringify({
		      post_no: post_no,
		      post_pw: inputPw
		    })
		  })
		  .then(res => res.json())
		  .then(result => {
		    if (result.res) {
		      location.href = 'updatePost?post_no=' + post_no;
		    } else {
		      alert("비밀번호가 일치하지 않습니다.");
		    }
		  });
		}

		function delPost() {
		  if (!confirm("삭제하시겠습니까?")) return;

		  // 비밀번호가 없으면 바로 삭제 실행
		  if (!post_pw || post_pw === "") {
		    deletePost();
		    return;
		  }

		  const inputPw = prompt("비밀번호를 입력하세요:");
		  if (inputPw === null || inputPw === "") return;

		  fetch('checkPassword', {
		    method: 'POST',
		    headers: {
		      'Content-Type': 'application/json'
		    },
		    body: JSON.stringify({
		      post_no: post_no,
		      post_pw: inputPw
		    })
		  })
		  .then(res => res.json())
		  .then(result => {
		    if (result.res) {
		      deletePost();
		    } else {
		      alert("비밀번호가 일치하지 않습니다.");
		    }
		  });
		}

		function deletePost() {
		  fetch('deletePost', {
		    method: 'POST',
		    headers: {
		      'Content-Type': 'application/json'
		    },
		    body: JSON.stringify(post_no)
		  })
		  .then(res => res.json())
		  .then(result => {
		    if (result.success) {
		      alert("삭제가 완료되었습니다.");
		      location.href = "${pageContext.request.contextPath}/";
		    } else {
		      alert("삭제 중 오류가 발생했습니다.");
		    }
		  })
		  .catch(error => {
		    console.error('Error:', error);
		    alert('삭제 중 오류가 발생했습니다.');
		  });
		}
</script>

</body>
</html>