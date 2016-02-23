<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="L10nSCAdministration"/>
<%-- Copied from editArtiact.jsp - will be modified  --%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${artifactLabel}" />
</syswf:component>

<%-- For consistency, keep prefix in sync in view/new/edit pages --%>
<syswf:component name="/core/layout/columns" prefix="props" wrap="false">
    <syswf:param name="customizationId" value="${this.bean.customizationId}" />
    <syswf:param name="artifact" value="${this.bean.artifact}" />
    <syswf:param name="validationReport" value="${this.bean}" />
    <syswf:param name="artifactBean" value="${this.bean}" />
</syswf:component>

<hr />

<syswf:block className="UI Block Green Last">
    <div class="Content">
        <div class="UI Form Controls">
            <fmt:message bundle="${messages}" key="Save" var="Save" />
            <syswf:control mode="postAnchor" action="save" caption="${Save}">
                <syswf:attribute name="class" value="btn btn-primary" />
                <syswf:param name="refresh" value="refresh" />
            </syswf:control>
            <fmt:message bundle="${messages}" key="Cancel" var="Cancel" />
            <syswf:control mode="postAnchor" action="refresh" caption="${Cancel}" targetDepth="${sessionStack.currentDepth-1}">
                <syswf:attribute name="class" value="btn btn-gray" />
            </syswf:control>
        </div>
    </div>
</syswf:block>
<syswf:component name="/util/stayLoggedIn" prefix="stayLoggedIn" wrap="false" />