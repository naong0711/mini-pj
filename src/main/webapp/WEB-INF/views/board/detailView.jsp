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

	<input type="text" value="${member.userid}" id="userid">
	<input type="text" value="${board.post_no }" id="post_no">
	<input type="text" value="${board.post_pw}" id="post_pw">
	<div>
		<div>
			<!-- 카테고리네임조인 -->
			<h3>${board.title }</h3>
			${board.userid }<br> ${board.post_at } &nbsp; ${board.view_cnt }
		</div>

		<input type="button" value="수정" onclick="updatePost()">
		<input type="button" value="삭제" onclick="delPost()">
		<hr>
		<div>${board.content }</div>



	</div>




<script type="text/javascript">
	const post_no = document.querySelector("#post_no").value;
	const post_pw = document.querySelector("#post_pw").value;
	
	function updatePost() {

		    const inputPw = prompt("비밀번호를 입력하세요:");
		    if (inputPw === null) return;
		
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
		    	 location.href='updatePost?post_no='+post_no;
		      } else {
		        alert("비밀번호가 일치하지 않습니다.");
		      }
		    });
		  }
	}

	//삭제버튼
	function delPost() {
	  if (!confirm("삭제하시겠습니까?")) return;
	
	  if (post_pw === null || post_pw === "") {
		  deletePetch();
	  } else {
	    const inputPw = prompt("비밀번호를 입력하세요:");
	    if (inputPw === null) return;
	
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
	        // 비밀번호 일치 → 삭제 요청
	        deletePetch();
	      } else {
	        alert("비밀번호가 일치하지 않습니다.");
	      }
	    });
	  }
	}
	
	//삭제요청
	function deletePetch() {
		
		  fetch('deletePost', {
			    method: 'DELETE',
			    headers: {
			      'Content-Type': 'application/json'
			    },
			    body: JSON.stringify(post_no)
			  })
			  .then(res => res.json())
			  .then(result => {
			    if (result.success) {
			      alert("삭제가 완료되었습니다.");
			      location.href = document.referrer;
			    } else {

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