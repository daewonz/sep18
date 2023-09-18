<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> </title>
<link href="css/styles.css" rel="stylesheet" />
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

function adetailDel(){
	if(confirm("삭제하시겠습니까?")){
		location.href="./adetailDel?abno=${detail.abno}";
	}
}

function adetailUp(){
	if(confirm("수정하시겠습니까?")){
		location.href="./adetailUp?num=${detail.rowNum}";
	}
}
</script>

</head>
<body>
<%@ include file="nav.jsp" %>
<%@ include file="sidebar.jsp" %>
 <article id="article">
 <br>	

번호 : ${detail.rowNum } <br>
제목 : ${detail.abtitle } <br>
내용 : ${detail.abcontent }<br>
글쓴이 : ${detail.abwrite } <br>
날짜 : ${detail.abdate } <br>
<c:if test="${sessionScope.eno == detail.eno || session.egrade == 8}">
<button class="adetailDel" onclick="adetailDel()">삭제</button>
<button class="adetailUp" onclick="adetailUp()">수정</button>
</c:if>
<button class="areport">신고</button>
<br>
<c:choose>
<c:when test="${count gt 0 }">
<table class="table" border="1">
							<thead>
								<tr>
									<th>글쓴이</th>
									<th>내용</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${commentList }" var="row">
							<tr>
								<c:choose>
									<c:when test="${row.csecret == 0 && (sessionScope.eno == detail.eno|| sessionScope.eno == row.eno || session.egrade == 8)}">
										<td>${row.cwrite}<c:if test="${row.cself == 0 }"><h6 style="color: red">(작성자)</h6></c:if> </td>
										<td>${row.ccomment}  (비밀댓글입니다.)<c:if test="${sessionScope.eno == row.eno }"><button>수정</button><button>삭제</button></c:if> </td>
									</c:when>
									<c:when test="${row.csecret == 0 && (sessionScope.eno != detail.eno && sessionScope.eno != row.eno)}">
									<td colspan="2">비밀댓글입니다.</td>
									</c:when>
									<c:when test="${row.csecret == 1 }">
										<td>${row.cwrite}<c:if test="${row.cself == 0 }"><h6 style="color: red">(작성자)</h6></c:if></td>
										<td>${row.ccomment}<c:if test="${sessionScope.eno == row.eno }"><button>수정</button><button>삭제</button></c:if></td>
									</c:when>
								</c:choose>
							</tr>
								</c:forEach>
							</tbody>
						</table>
</c:when>
<c:otherwise>
댓글이 없습니다.
</c:otherwise>
</c:choose>

						

<form action="./comment" method="post">
<input type="text" name="comment" placeholder="글쓴이 : ${commentWriter }"><c:if test="${sessionScope.eno != detail.eno }"><input id="secret" type="checkbox" name="secret" value="0"/>비밀댓글</c:if><br>
<button type="submit">댓글쓰기</button>
<input type="hidden" name="writer" value="${commentWriter }" class="commentWriter'" >
<input type="hidden" name="eno" value="${sessionScope.eno }" class="commentEno'" >
<input type="hidden" name="abno" value="${detail.abno }" class="commentAbno'" >
<input type="hidden" name="detailEno" value="${detail.eno }" >

<input type="hidden" name="rowNum" value="${detail.rowNum }" >
</form>
</article>
</body>
</html>