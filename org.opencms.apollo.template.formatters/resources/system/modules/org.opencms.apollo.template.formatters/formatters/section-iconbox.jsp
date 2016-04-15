<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.text">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<div class="${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : "" }${' ' }${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : "p-20 fa-center" }" ${rdfa.Link}>
	
    <c:choose>
    	<c:when test="${cms.element.inMemoryOnly}">
    		<p><fmt:message key="apollo.text.message.new" /></p>
    	</c:when>
        <c:otherwise>
            <c:if test="${value.Link.exists}"><a href="<cms:link>${value.Link.value.URI}</cms:link>"<c:if test="${value.Link.value.Text.isSet}"> title="${value.Link.value.Text}"</c:if>></c:if>
  			<h2 class="heading-md" ${rdfa.Headline}>${value.Headline}</h2>
  			<div><i class="icon-lg ${cms.element.setting.iconclass.isSet ? cms.element.setting.iconclass : "icon-bg-default fa fa-lightbulb-o" }"></i></div>
  			<div ${rdfa.Text}>${value.Text}</div>
  			<c:if test="${value.Link.exists}"></a></c:if>
        </c:otherwise>
    </c:choose>
	</div>
</cms:formatter>
</cms:bundle>