<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>멤버목록</h1>

건수 : <select name="size" id="size">
	<c:forTokens items="10,30,90,100" delims="," var="size">
		<option value="${size}" ${pageResponse.size == size ? 'selected' : ''}>${size}</option>
	</c:forTokens>
	<!--
	<option value="10" ${pageResponse.size == 10 ? 'selected' : ''}>10</option>
	<option value="20" ${pageResponse.size == 20 ? 'selected' : ''}>20</option>
	<option value="30" ${pageResponse.size == 30 ? 'selected' : ''}>30</option>
	<option value="50" ${pageResponse.size == 50 ? 'selected' : ''}>50</option>
	<option value="100" ${pageResponse.size == 100 ? 'selected' : ''}>100</option>
	-->
</select>
<!--  현재 페이지 번호 / 전체 페이지 번호 -->
(${pageResponse.pageNo} / ${pageResponse.totalPage})<br/>
<form action="list">
	검색어 : <input type="text" name="searchValue" id="searchValue" value="${pageResponse.searchValue}">
	<input type="submit" value="검색">
</form>

<table border=1>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>가입일</th>
			<th>탈퇴여부</th>
			<th>잠금여부</th>
		</tr>

		<c:forEach var="member" items="${pageResponse.list}" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td><a href="${pageContext.request.contextPath}/memberDetail?userid=${member.userid}">${member.name}</a></td>
				<td>${member.userid}</td>
				<td>${member.nickname }</td>
				<td>${fn:substring(member.reg_at,0,10)}</td>
				<td>${member.is_del}</td>
				<td>${member.is_lock}</td>
			</tr>
		</c:forEach>
 
	</table>
	
		<!-- 시작블록 < 버튼  -->
	<c:if test="${pageResponse.prev}">
		<a href="list?pageNo=${pageResponse.startPage-1}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">«</a>
	</c:if>

	<!--페이지 숫자 출력 -->
	<c:forEach var="pageNo" begin="${pageResponse.startPage}" end="${pageResponse.endPage}">
		<a style="text-decoration: none; color: black;" href="list?pageNo=${pageNo}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">
		<c:choose>
			<c:when test="${pageNo == pageResponse.pageNo}">
				<span style="font-weight: bold; color: red; ">${pageNo}</span>
			</c:when>
			<c:otherwise>${pageNo}</c:otherwise>
		</c:choose>
		</a>
	</c:forEach>

	<!-- 다음블록 > 버튼  -->
	<c:if test="${pageResponse.next}">
		<a href="list?pageNo=${pageResponse.endPage+1}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">»</a>
	</c:if>


</body>
</html>