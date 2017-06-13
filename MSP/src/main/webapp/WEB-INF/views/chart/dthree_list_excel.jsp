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
	response.setHeader("Content-Disposition", "attachment; filename="+UriUtils.encodeFragment("지역관리 리스트 _","UTF-8")+mTime+".xls;'");
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
<table class="dthreeExcelTbl">
	<thead>
		<tr>
			<th class="header"> No </th>
			<td class="header" style="width: 10%;">지역명</td>
			<td class="header" style="width: 10%;">내국인</td>
			<td class="header" style="width: 10%;">외국인</td>
			<td class="header" style="width: 10%;">삭제여부</td>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty dthreeExcel}">			
			<c:forEach var="dthreeExcel" items="${dthreeExcel}" >
				<tr>
					<td class="body"><c:out value="${dthreeExcel.RNUM }"></c:out></td>
					<td class="body"><c:out value="${dthreeExcel.AREA }"></c:out></td>
					<td class="body"><c:out value="${dthreeExcel.KOREA }"></c:out></td>
					<td class="body"><c:out value="${dthreeExcel.FOREIGNER }"></c:out></td>
					<td class="body"><c:out value="${dthreeExcel.ACTIVE_FLG }"></c:out></td>
				</tr>
			</c:forEach>
		</c:if>
			
		<c:if test="${dthreeExcel.size() == 0}">
			<tr style="cursor: default; background-color: white;">
				<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
			</tr>
		</c:if>
	</tbody>
	</table>
				
</body>
</html>