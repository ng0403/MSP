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
	response.setHeader("Content-Disposition", "attachment; filename="+UriUtils.encodeFragment("공통코드 리스트 _","UTF-8")+mTime+".xls;'");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
%>


<table class="userExcelTbl">
	<thead>
		<tr>
			<th class="header"> No </th>
			<td class="header" style="width: 10%;">공통코드</td>
			<td class="header" style="width: 20%;">공통코드명</td>
			<td class="header" style="width: 10%;">상세코드</td>
			<td class="header" style="width: 20%;">상세코드명</td>
		</tr>
	</thead>
			<tbody>
				<c:if test="${not empty codeExcel}">
					<c:forEach var="codeExcel" items="${codeExcel}">
						<tr>
							<%-- <td class="body" colspan="2"><c:out value="합계"></c:out></td> --%>
							<td class="body"><c:out value="${codeExcel.RNUM }"></c:out></td>
							<td class="body"><c:out value="${codeExcel.GRP_CD }"></c:out></td>
							<td class="body"><c:out value="${codeExcel.GRP_NM}"></c:out></td>
							<td class="body"><c:out value="${codeExcel.CODE1}"></c:out></td>
							<td class="body"><c:out value="${codeExcel.CODE_TXT}"></c:out></td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${codeExcel.size() == 0}">
					<tr style="cursor: default; background-color: white;">
						<td colspan="9" style="height: 100%; text-align: center;"><b>검색 결과가 없습니다.</b></td>
					</tr>
				</c:if>
				</tbody>
</table>

</body>
</html>
