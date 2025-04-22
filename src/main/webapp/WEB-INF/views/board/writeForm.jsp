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

<h2>글쓰기</h2>
<table border="1">
<form action="upload" method="post" id="writeForm">
<input type="text" value="${member.userid}" id="userid">
	<tr>
	<th>카테고리</th>	
	<th><select name="c_no" id="c_no" required="required">
	    <option value="0" selected="selected"> --카테고리--
	    <option value="1"> 공지사항 <!-- 관리자일때만 쓸 수 있게 -->
	    <option value="2"> 게시판
	</select></th>
	<th>제목</th>	
	<th><input type="text" id="title"></th>	
	<th>패스워드 설정</th>
	<th><input type="password" id="post_pw"></th>
	</tr>
	<tr>
	<td colspan="6"> <textarea id="content" name="content" rows="5" cols="100" placeholder="내용을 입력하세요" required="required"></textarea></td>
	</tr>

</table>
<input type="submit" value="등록" id="uploadBtn">
<input type="button" value="취소"
	onclick="if (!confirm('작성된 내용은 저장되지 않습니다. 글쓰기를 그만두시겠습니까?')) return; history.back();">
</form>


<script type="text/javascript">
	let writeForm = document.querySelector("#writeForm");
	let c_no = document.querySelector("#c_no").value;
	let post_pw = document.querySelector("#post_pw").value;
	let title = document.querySelector("#title").value;
	let content = document.querySelector("#content").value;

	if (writeForm) {
 		//이벤트 핸들러 등록 
 		writeForm.addEventListener("submit", e => {
			e.preventDefault();  // form의 기본 동작을 취소함.
			
			if (!confirm("등록 하시겠습니까?")) return;
			
			//비밀번호 있을때 경고문
			if(post_pw == null) {
				confirm("비밀번호 분실 시 삭제할 수 없습니다");
				return;
			}
			
			//카테고리 선택
			if(c_no <= 0) {
				alert("카테고리를 선택해주세요");
				return;
			}
			
			
			//form의 하위 객체를 이름을 사용하여 접근 하는 방법
			const param = {  	
				userid : document.querySelector("#userid").value,   	
				c_no : c_no,   	
				title : title,   	
				post_pw : post_pw,   	
				content : content.value	
			}
			console.log("param", param);
			
			fetch("write", { 
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
						  location.href='updatePost?post_no='+post_no;
					  }
			})	 			
 		})
 	}



</script>


</body>
</html>