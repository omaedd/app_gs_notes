<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<jsp:include page="../fragments/userheader.jsp" />
<div class="container">

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<jsp:include page="../fragments/usermenu.jsp" />
		</div>
	</nav>






	<div>
		<h3>Notes de délibération</h3>
		

		<s:authorize access="isAuthenticated()">
		<form action="${pageContext.request.contextPath}/deliberation/exportDeliberationFile" name="deliberationForm" method="post">
			<select name="niveau" class="form form-control">
			    <c:forEach items="${niveaux}" var="niveau">
			        <option value="${niveau.alias}">${niveau.titre}</option>
			    </c:forEach>
			</select>
			<input type="submit" class="btn btn-success mt-2" value="Exporter le fichier de délibération">
	 	</form>
		</s:authorize>
	</div>



<jsp:include page="../fragments/userfooter.jsp" />

</div>