<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="bulk.startGovernance.yesButton.label" var="yesLabel" bundle="${messages}" />        
<fmt:message key="bulk.startGovernance.noButton.label" var="noLabel" bundle="${messages}" />        

<syswf:control mode="script" action="startGovernance" caption="${prefix}startGovernance" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>
<syswf:component name="/core/impl/util/dialog" prefix="startGovernanceDialog">
    <syswf:param name="handler" value="${prefix}startGovernance" />
    <syswf:param name="heading"><fmt:message key="bulk.startGovernance.action.heading" bundle="${messages}"/></syswf:param>
    <syswf:param name="content">
        <fmt:message key="bulk.startGovernance.action.content" bundle="${messages}" />
    </syswf:param>
    <syswf:param name="actionCaption" value="${yesLabel}" />
    <syswf:param name="cancelCaption" value="${noLabel}" />    
</syswf:component>
