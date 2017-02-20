<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ page import="org.springframework.web.util.UriUtils" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
	Date currentTime = new Date();
	String mTime = mSimpleDateFormat.format (currentTime);
	response.setHeader("Content-Disposition", "attachment; filename="+UriUtils.encodeFragment("권한관리 리스트 _","UTF-8")+mTime+".xls;'");
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
</style>
<table class="authExcelTbl">
	<thead>
		<tr>
			<th class="header"> No </th>
			<td class="header" style="width: 10%;">권한ID</td>
			<td class="header" style="width: 10%;">권한명</td>
			<td class="header" style="width: 10%;">활성화여부</td>
			<td class="header" style="width: 10%;">삭제여부</td>
			<td class="header" style="width: 10%;">작성자</td>
			<td class="header" style="width: 10%;">작성일</td>
			<td class="header" style="width: 10%;">수정자</td>
			<td class="header" style="width: 10%;">수정일</td>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty authExcel}">			
			<c:forEach var="authExcel" items="${authExcel}" >
				<tr>
					<td class="body"><c:out value="${authExcel.RNUM }"></c:out></td>
					<td class="body"><c:out value="${authExcel.AUTH_ID }"></c:out></td>
					<td class="body"><c:out value="${authExcel.AUTH_NM }"></c:out></td>
					<td class="body"><c:out value="${authExcel.ACTIVE_FLG }"></c:out></td>
					<td class="body"><c:out value="${authExcel.DEL_FLG }"></c:out></td>
					<td class="body"><c:out value="${authExcel.CREATED_BY }"></c:out></td>
					<td class="body"><c:out value="${authExcel.CREATED }"></c:out></td>
					<td class="body"><c:out value="${authExcel.UPDATED_BY }"></c:out></td>
					<td class="body"><c:out value="${authExcel.UPDATED }"></c:out></td>
				</tr>
			</c:forEach>
		</c:if>
			
		<c:if test="${authExcel.size() == 0}">
			<tr style="cursor: default; background-color: white;">
				<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
			</tr>
		</c:if>
	</tbody>
	</table>
				
</body>
</html>