<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>	
<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">

<c:set var="accId">${cms.element.instanceId}</c:set>

<cms:formatter var="content" val="value">

    <div class="ap-faq-panel panel panel-default ${cms.element.settings.index == 0 ? '':'mt-5'}">
        <div  class="panel-heading">
            <h4 class="panel-title">
                <a
                    class="accordion-toggle ${cms.element.settings.index == 0 ? '':'collapsed'}"
                    data-parent="#list-${cms.element.settings.listid}"
                    data-toggle="collapse"
                    href="#collapse-${accId}-${cms.element.settings.index}">

                    <div class="ap-panel-title">${content.value.Question}</div>

                </a>
            </h4>
        </div>
        <div
            id="collapse-${accId}-${cms.element.settings.index}"
            class="panel-collapse collapse ${cms.element.settings.index == 0 ? 'in' : ''}"
            style="height: ${cms.element.settings.index == 0 ? 'auto' : '0px'};">
            <div class="panel-body ap-panel-body">
                <c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">
                    <apollo:paragraph 
                        showimage="true"
                        headline="inline"
                        headlinestyle="ap-faq-header"
                        paragraph="${paragraph}" />
                </c:forEach>
            </div>
        </div>
    </div>

</cms:formatter>

</cms:bundle> 