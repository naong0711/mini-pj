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

<h2>게시물 수정</h2>

<form action="update" method="post" id="updateForm">
<table border="1">

<input type="text" value="${board.post_no }" id="post_no">
<input type="text" value="${member.userid}" id="userid">
	<tr>
		<th>카테고리</th>	
	<th><select name="c_no" id="c_no" required="required">
	    <option value="0" ${board.c_no == 0 ? 'selected' : ''}>--카테고리--</option>
	    <option value="1" ${board.c_no == 1 ? 'selected' : ''}>공지사항</option>
	    <option value="2" ${board.c_no == 2 ? 'selected' : ''}>게시판</option>
	</select></th>
		 <th>현재 비밀번호</th>
	<th><input type="password" id="post_pw" placeholder="수정 시 기존 비밀번호 입력" /></th>
	</tr>
	
	<tr>
		<th>제목</th>	
	<th><input type="text" id="title" value="${board.title }"></th>	
 		<th>새 비밀번호 (변경 시 입력)</th>
  	<th><input type="password" id="new_pw" placeholder="변경 안 할 경우 공란" /></th>
	</tr>
	
	<tr>
		<td colspan="6"><textarea id="content" name="content" rows="5" cols="100" placeholder="내용을 입력하세요" required="required">${board.content}</textarea></td>
	</tr>

</table>
<input type="submit" value="등록" id="updateBtn">
<input type="button" value="취소"
	onclick="if (!confirm('변경된 내용은 저장되지 않습니다. 수정을 그만두시겠습니까?')) return; history.back();">
</form>


<script type="text/javascript">
	let updateForm = document.querySelector("#updateForm");
	let c_no = document.querySelector("#c_no").value;
	let post_pw = document.querySelector("#post_pw").value;
	let new_pw = document.querySelector("#post_pw").value;
	let title = document.querySelector("#title").value;
	let content = document.querySelector("#content").value;
	
	if (updateForm) {
 		//이벤트 핸들러 등록 
 		updateForm.addEventListener("submit", e => {
			e.preventDefault();  // form의 기본 동작을 취소함.
			
			if (!confirm("등록 하시겠습니까?")) return;
			
			//비밀번호 있을때 검사 필드 둘 다 찼는지 비밀번호 맞는지
			if(post_pw != null) {
				confirm("비밀번호 분실 시 삭제할 수 없습니다");
				return;
			}
			
			
			const param = {  	
				userid : document.querySelector("#userid").value,   	
				c_no : c_no,   	
				title : title,   	
				post_pw : new_pw, //비밀번호 맞아서 새로운걸로 업뎃
				content : content.value	
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
						  alert("업로드가 완료되었습니다.");
						  history.back();
					  }
			})	 			
 		})
 	}


</script>

</body>
</html>