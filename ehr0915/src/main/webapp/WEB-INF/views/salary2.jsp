<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salary</title>
<link href="./css/salary.css" rel="stylesheet" />
<link href="./css/style.css" rel="stylesheet" />
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<%@ include file="nav.jsp" %>
<%@ include file="sidebar.jsp" %>
	<div class="total-content">
		<h1>관리자-급여목록</h1>
		<div class="top-area">
			<form action="./salary2" method="get">
				<ul>
					<li>조회기간<input type="month" name="scstrdate" > ~ <input type="month" name="scenddate"></li>
					<li>소속<input name="edept"></li>
					<li>직급 <select name="egrade">
							<option value="0">사원</option>
							<option value="1">주임</option>
							<option value="2">대리</option>
							<option value="3">과장</option>
							<option value="4">차장</option>
							<option value="5">부장</option>
							<option value="6">부사장</option>
							<option value="7">사장</option>
							<option value="8">관리자</option>
					</select>
					</li>
					<li>사번<input name="eid"></li>
					<li>성명<input name="ename" class="ename"></li>
					<li>재직상태 <select name="estate">
							<option value="0">재직</option>
							<option value="1">퇴사</option>
					</select>
					</li>
				</ul>
				<button class="search">조회</button>
				<input type="hidden" name="eno" value="${sessionScope.eno}">
			</form>
			<div class="middle-area">
				<div class="buttonText-area">
					<div class="buttonA">
						<button>입력</button>
						<button>저장</button>
					</div>
					<div class="table-area">
						<table border="1">
							<tr>
								<td>No</td>
								<td>삭제</td>
								<td>사번</td>
								<td>성명</td>
								<td>부서</td>
								<td>직급</td>
								<td>재직상태</td>
								<td>급여일자</td>
								<td>기본급</td>
								<td>변동급</td>
								<td>월단위총액</td>
								<td>연봉총액</td>
								<td>시작일</td>
								<td>종료일</td>
							</tr>
							<c:forEach items="${list }" var="row">
								<tr>
								<td class="sno">${row.sno }</td>
								<td>${row.sdel }</td>
								<td>${row.eid }</td>
								<td>${row.ename }</td>
								<td>${row.edept }</td>
								<td>${row.egrade }</td>
								<td>${row.estate }</td>
								<td>${row.sdate }</td>
								<td><fmt:formatNumber value="${row.sbasesal }" pattern="#,###" />원</td>
								<td><fmt:formatNumber value="${row.seat }" pattern="#,###" />원</td>
								<td><fmt:formatNumber value="${row.ssalary }" pattern="#,###" />원</td>
								<td><fmt:formatNumber value="${row.sannualsal }" pattern="#,###" />원</td>
								<td>${row.scstrdate }</td>
								<td>${row.scenddate }</td>
								</tr>
							</c:forEach>
						</table>
					</div>


				</div>
			</div>



		</div>




	</div>

</body>
</html>
