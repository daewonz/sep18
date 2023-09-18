<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>annony</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="../css/annony.css">

</head>
<body>
	<%@ include file="nav.jsp"%>
	<%@ include file="sidebar.jsp"%>
	<article id="article">
		<br>
		<div class="atList">
			<h1 class="title">익명게시판</h1>
			<c:choose>
				<c:when test="${fn:length(list) gt 0 }">
					<div class="atList2">
						<div class="div-btn">
							<c:if test="${sessionScope.eid ne null }">
								<button type="button" class="viewBtn"
									onclick="location.href='./annonyWrite'">글쓰기</button>
							</c:if>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="row">
									<tr onclick="location.href='./annonyDetail?num=${row.rowNum}'">
										<td>${row.rowNum}</td>
										<td>${row.abtitle}
										<td>${row.abwrite}</td>
										<td>${row.abread }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						  <div class="page_wrap">
                  <div class="page_nation">
                <div class="page_left_wrap">
                  <c:if test="${ph.showPrev}">
                        <button class="page_left"  onclick="location.href='./annonyboard?page=${ph.startPage-1}'">이전</button>
                    </c:if>
                 </div>
                  <c:forEach var="i" begin="${ph.startPage}" end="${ph.endPage}">
                  <a class="num" href="<c:url value='./annonyboard?page=${i}&pageSize=${ph.pageSize}'/>" data-page="${i}">${i}</a>
                  </c:forEach>
                  <c:if test="${ph.showNext}">
                        <button class="page"
                           onclick="location.href='./annonyboard?page=${ph.endPage+1}'">다음</button>
                    </c:if>
                  </div>
               </div>
					</div>
				</c:when>
				<c:otherwise>
					<h1>게시판에 글이 없습니다.</h1>
					<c:if test="${sessionScope.eid ne null }">
						<button type="button" class="viewBtn"
							onclick="location.href='./annonyWrite'">글쓰기</button>
					</c:if>
				</c:otherwise>
			</c:choose>
			<br>
		</div>
	</article>

</body>
</html>