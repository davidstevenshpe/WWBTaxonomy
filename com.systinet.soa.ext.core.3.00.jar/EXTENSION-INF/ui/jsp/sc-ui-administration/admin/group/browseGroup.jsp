<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="iconFormat" value="small" />
</syswf:component>
<syswf:component name="/core/table" prefix="browseGroup" wrap="true">
    <syswf:param name="customizationId" value="admin.group.table" />
    <syswf:param name="kind" value="browse" />	    
</syswf:component>

  