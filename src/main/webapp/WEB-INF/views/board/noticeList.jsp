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

건수 : <select name="size" id="size">
	<c:forTokens items="10,30,90,100" delims="," var="size">
		<option value="${size}" ${pageResponse.size == size ? 'selected' : ''}>${size}</option>
	</c:forTokens>

</select>
<!--  현재 페이지 번호 / 전체 페이지 번호 -->
(${pageResponse.pageNo} / ${pageResponse.totalPage})<br/>
<form action="notiecBoard">
	검색어 : <input type="text" name="searchValue" id="searchValue" value="${pageResponse.searchValue}">
	<input type="submit" value="검색">
</form>

	<div>
		<h2>공지사항</h2>
		<hr>
		<table>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>

			<c:forEach var="board" items="${pageResponse.list}">
				<tr>
					<td>${board.title}</td>
					<td>${board.userid}</td>
					<td>${board.post_at}</td>
					<td>${board.view_cnt}</td>
				</tr>
			</c:forEach>
		</table>

	</div>
	
		<!-- 시작블록 < 버튼  -->
	<c:if test="${pageResponse.prev}">
		<a href="notiecBoard?pageNo=${pageResponse.startPage-1}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">«</a>
	</c:if>

	<!--페이지 숫자 출력 -->
	<c:forEach var="pageNo" begin="${pageResponse.startPage}" end="${pageResponse.endPage}">
		<a style="text-decoration: none; color: black;" href="notiecBoard?pageNo=${pageNo}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">
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
		<a href="notiecBoard?pageNo=${pageResponse.endPage+1}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">»</a>
	</c:if>
	
	
<script type="text/javascript">
const size = document.querySelector("#size");
const searchValue = document.querySelector("#searchValue");
	size.addEventListener("change", e => {
		location = "notiecBoard?pageNo=1&size=" + size.value + "&searchValue=" + searchValue.value;	
	});
function pageMove(pageNo) {
	const searchForm = document.querySelector("#searchForm");
	searchForm.pageNo.value = pageNo; 
	searchForm.submit();
}	
</script>

</body>
</html>