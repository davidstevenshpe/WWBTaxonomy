<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">
	<syswf:control mode="script" caption="${controlName}" targetTask="/admin/user/newPersonArtifact" />
</c:if>