<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ page import="org.springframework.web.util.UriUtils" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
	Date currentTime = new Date();
	String mTime = mSimpleDateFormat.format (currentTime);
	response.setHeader("Content-Disposition", "attachment; filename="+UriUtils.encodeFragment("사용자 리스트 _","UTF-8")+mTime+".xls;'");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
%>
<style type="text/css">
.teleExcelTbl {
	border: thin solid black;
}
.header{
	border: thin solid black;
	background-color: #f9ffff;
	text-align: center;
}
.body{
	border: thin solid black;
	text-align: center;
}
.numStyle {
	border: thin solid black;
	text-align: right;
}
</style>
<table class="userExcelTbl">
	<thead>
		<tr>
			<th class="header"> No </th>
			<td class="header" style="width: 10%;">사용자ID</td>
			<td class="header" style="width: 10%;">사용자명</td>
			<td class="header" style="width: 10%;">부서명</td>
			<td class="header" style="width: 20%;">이메일</td>
			<td class="header" style="width: 25%;">연락처</td>
			<td class="header" style="width: 10%;">권한</td>
			<td class="header" style="width: 10%;">상태</td>
		</tr>
	</thead>
			<tbody>
				<c:if test="${not empty userExcel}">
					<c:forEach var="userExcel" items="${userExcel}">
						<tr>
							<%-- <td class="body" colspan="2"><c:out value="합계"></c:out></td> --%>
							<td class="body"><c:out value="${userExcel.RNUM }"></c:out></td>
							<td class="body"><c:out value="${userExcel.USER_ID}"></c:out></td>
							<td class="body"><c:out value="${userExcel.USER_NM}"></c:out></td>
							<td class="body"><c:out value="${userExcel.DEPT_NM}"></c:out></td>
							<td class="body"><c:out value="${userExcel.EMAIL_ID}@${userExcel.EMAIL_DOMAIN}"></c:out></td>
							<td class="body"><c:out value="${userExcel.CPHONE_NUM1}-${userExcel.CPHONE_NUM2}-${userExcel.CPHONE_NNUM}"></c:out></td>
							<td style="width: 10%;" class="body">
								<c:if test="${empty userExcel.AUTH_NM}"><c:out value="권한없음"></c:out></c:if>
								<c:if test="${not empty userExcel.AUTH_NM}"><c:out value="${userExcel.AUTH_NM}"></c:out></c:if>
							</td>
							<td class="body"><c:out value="${userExcel.ACTIVE_FLG}"></c:out></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${userExcel.size() == 0}">
					<tr style="cursor: default; background-color: white;">
						<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
					</tr>
				</c:if>
				</tbody>
</table>

</body>
</html>
