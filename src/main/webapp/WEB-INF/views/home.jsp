<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Main</title>
</head>
<body>
<!-- 로그인 기능
회원가입, 상세보기 수정 탈퇴 관리자의 경우 회원 목록
아이디 중복확인
비밀번호 패턴 검사 기능 영문자 숫자 특수문자 1개이상 필수 최소8자
아이디 검증 최소8자 
로그인 5회 실패 시 계정 자동잠금
로그인 잠금 기능해제는 관리자만 가능
회원관리목록 검색&페이징
게시물관리기능 < CRUD구현
상세보기 시 조회수 카운트 (세션으로 카운트, 중복카운트x)
게시물 삭제 시 게시물 비밀번호 확인
 -->
<ul>

	<li><a href="member/list">관리자-회원목록11</a></li>
	
	<c:if test="${empty member}">
		<li><a href="registerForm">회원가입</a></li>
		<li><a href="loginForm">로그인</a></li>
	
	</c:if>
	
	<c:if test="${not empty member}">
		<li><a href="myPage?userid=${member.userid}">${member.name}</a>회원정보상세보기>수정,탈퇴</a></li>
	</c:if>
	
</ul>

	게시물목록>상세보기


</body>
</html>
