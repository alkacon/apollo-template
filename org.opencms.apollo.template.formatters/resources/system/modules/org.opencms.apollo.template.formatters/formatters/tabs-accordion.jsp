<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.tabs">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="ap-panel-section ${cms.element.setting.wrapperclass}">

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div>
	</c:if>

	<div class="panel-group" id="accordion-${cms.element.instanceId}">
		<c:forEach var="label" items="${content.valueList.Label}" varStatus="status">
			<div class="panel panel-default">
                <div  class="panel-heading">
                    <h4 class="panel-title">
                        <a
                            class="accordion-toggle ${status.first? '':'collapsed'}"
                            data-toggle="collapse"
                            data-parent="#accordion-${cms.element.instanceId}"
                            href="#collapse-${cms.element.instanceId}-${status.count}">
                                        
                            <div class="ap-panel-title">${label}</div>
                            
                        </a>
                    </h4>
                </div>
                <div
                    id="collapse-${cms.element.instanceId}-${status.count}"
                    class="panel-collapse collapse ${status.first? 'in':''}"
                    style="height: ${status.first?'auto':'0px'};">

                    <cms:container
                            name="tab-container${status.count}"
                            type="row"
                            tagClass="panel-body ap-panel-body"
                            maxElements="2">
                                <c:set var="msg"><fmt:message key="apollo.tabs.emptycontainer.text"/></c:set>
                                <apollo:container-box
                                    label="${msg}"
                                    boxType="container-box"
                                    role="author"
                                    type="row" />
                        </cms:container>
                </div>
            </div>
		</c:forEach>
	</div>
</div>

</cms:formatter>
</cms:bundle>
