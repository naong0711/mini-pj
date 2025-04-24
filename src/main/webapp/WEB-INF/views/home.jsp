<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_style.css">
<title>Main</title>
<style>
body {
	padding: 40px 5%;
	max-width: 1200px;
	margin: 0 auto;
}

/* 콘텐츠 박스 영역 너비 제한 */
div {
	max-width: 1000px;
	margin-left: auto;
	margin-right: auto;
}

/* 테이블도 폭 제한 */
table {
	max-width: 100%;
	table-layout: auto;
}

/* 폼 너비도 반응형 정돈 */
form {
	max-width: 600px;
	width: 90%;
}

</style>
</head>
<body>

	<ul>
		<c:if test="${member.m_role == 0}">
			<li><a href="member/list">회원목록</a></li>
		</c:if>
		<c:if test="${empty member}">
			<li><a href="registerForm">회원가입</a></li>
			<li><a href="loginForm">로그인</a></li>
		</c:if>
		<c:if test="${not empty member}">
			<li><a href="myPage?userid=${member.userid}">${member.name}님</a></li>
			<li><a href="logout">로그아웃</a></li>
		</c:if>
	</ul>

	<!-- 자유게시판 최신글 -->
	<div>
		<h2 onclick="location.href='freeBoard';">자유게시판 <span style="float: right;">+</span></h2>
		<hr>
		<table>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="board" items="${freeBoard}" end="7">
				<tr>
					<td><a href="detailView?post_no=${board.post_no}">${board.title}</a></td>
					<td>${board.userid}</td>
					<td>${fn:substring(board.post_at, 0, 10)}</td>
					<td>${board.view_cnt}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<!-- 공지사항 최신글 -->
	<div>
		<h2 onclick="location.href='noticeBoard';">공지사항 <span style="float: right;">+</span></h2>
		<hr>
		<table>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="board" items="${notiecBoard}" end="7">
				<tr>
					<td><a href="detailView?post_no=${board.post_no}">${board.title}</a></td>
					<td>${board.userid}</td>
					<td>${fn:substring(board.post_at, 0, 10)}</td>
					<td>${board.view_cnt}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

</body>
</html>