<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_style.css">
<meta charset="UTF-8">
<title>멤버 목록</title>
<style>
body {
  padding: 40px 5%;
  max-width: 1200px;
  margin: 0 auto;
  background-color: #f4f6f8;
}

/* 필터 바 수평 정렬용 추가 */
.filter-bar {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  gap: 30px;
}

.filter-bar > div {
  flex: 0 0 auto;
}

.filter-bar form {
  background: none;
  box-shadow: none;
  padding: 0;
  display: flex;
  margin: 0;
  align-items: center;
}

.filter-bar form input[type="text"] {
  border-radius: 6px 0 0 6px;
  border-right: none;
  height: 40px;
  padding: 10px 12px;
  margin-bottom: 0;
  flex-grow: 1;
}

.filter-bar form input[type="submit"] {
  border-radius: 0 6px 6px 0;
  margin: 0;
  height: 40px;
  padding: 10px 15px;
  flex-shrink: 0;
}

table {
  width: 100%;
  border-collapse: collapse;
  background-color: #fff;
  border: 1px solid #ddd;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

th, td {
  padding: 12px;
  border-bottom: 1px solid #eee;
  text-align: center;
}

th {
  background-color: #f0f2f5;
  font-weight: 600;
  color: #333;
}

tr:hover {
  background-color: #f9f9f9;
}

.pagination {
  text-align: center;
  margin-top: 20px;
}

.pagination a {
  margin: 0 6px;
  padding: 6px 10px;
  text-decoration: none;
  border-radius: 4px;
  color: #007bff;
  font-weight: 500;
}

.pagination a:hover {
  background-color: #e9f0fb;
}

.pagination span {
  padding: 6px 10px;
  font-weight: bold;
  color: red;
}
</style>
</head>
<body>

	<h1><a href="${pageContext.request.contextPath}/">&lt;</a> 멤버 목록</h1>

<div class="filter-bar">

  <label for="size"  style="white-space: nowrap;">건수:</label>
	<select id="size" name="size" style="width: 20%; margin-bottom: 0;">
	  <option value="10" <c:if test="${pageResponse.size == 10}">selected</c:if>>10</option>
	  <option value="20" <c:if test="${pageResponse.size == 20}">selected</c:if>>20</option>
	  <option value="50" <c:if test="${pageResponse.size == 50}">selected</c:if>>50</option>
	</select>

  <form action="list" method="get">
    <input type="text" id="keyword" name="keyword" placeholder="검색어를 입력하세요">
    <input type="submit" value="검색">
  </form>
</div>

<table>
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
      <td>${member.nickname}</td>
      <td>${fn:substring(member.reg_at, 0, 10)}</td>
      <td>${member.is_del}</td>
      <td>${member.is_lock}</td>
    </tr>
  </c:forEach>
</table>

<div class="pagination">
  <c:if test="${pageResponse.prev}">
    <a href="list?pageNo=${pageResponse.startPage-1}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">«</a>
  </c:if>

  <c:forEach var="pageNo" begin="${pageResponse.startPage}" end="${pageResponse.endPage}">
    <c:choose>
      <c:when test="${pageNo == pageResponse.pageNo}">
        <span>${pageNo}</span>
      </c:when>
      <c:otherwise>
        <a href="list?pageNo=${pageNo}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">${pageNo}</a>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <c:if test="${pageResponse.next}">
    <a href="list?pageNo=${pageResponse.endPage+1}&size=${pageResponse.size}&searchValue=${pageResponse.searchValue}">»</a>
  </c:if>
</div>

<script type="text/javascript">
const size = document.querySelector("#size");
const searchValue = document.querySelector("#searchValue");
size.addEventListener("change", e => {
	location = "list?pageNo=1&size=" + size.value + "&searchValue=" + searchValue.value;
});
</script>

</body>
</html>