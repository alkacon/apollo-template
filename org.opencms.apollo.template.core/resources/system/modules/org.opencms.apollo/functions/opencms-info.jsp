<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.core.messages">

<div class="bg-grey-lighter mb-20 p-20">

    <div class="float-row">
        <div class="float-col">
            <i class="fs-36 fa fa-info-circle"></i>
        </div>
        <div class="float-col">
            <h2>
                <fmt:message key="apollo.info.installed" /> 
                <span style="white-space: nowrap;">
                    OpenCms ${cms.systemInfo.versionNumber}
                </span>
            </h2>
        </div>
    </div>

    <p>
    <c:forEach items="${cms.systemInfo.buildInfo}" var="item" varStatus="loop">
        <c:if test="${loop.count > 1}"><c:out value =" - "/></c:if>
        <span style="white-space: nowrap;">${item.value.niceName}: ${item.value.value}</span>
    </c:forEach>
    </p>

    <p>
        <fmt:message key="apollo.info.running" />${' '} 
        <cms:info property="java.vm.vendor" /> 
        <cms:info property="java.vm.name" />${' '}<fmt:message key="apollo.info.with" />${' '}
        <cms:info property="os.name" /> 
        <cms:info property="os.version" />
    </p>

</div>
</cms:bundle>