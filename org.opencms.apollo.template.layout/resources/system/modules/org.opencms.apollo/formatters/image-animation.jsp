<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
    <cms:formatter var="content" val="value" rdfa="rdfa">
    <apollo:image-vars image="${content.value.Image}">
        <c:choose>
      <c:when test="${empty imageLink}">
                <div class="alert">
                    <fmt:message key="no.image" />
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <div class="thumbnails thumbnail-style thumbnail-kenburn ${cms.element.setting.shadowborder.value ? 'shadow-border' : ''}">
            <apollo:image-kenburn 
              setting="${cms.element.setting}"
              image="${content.value.Image}"
              width="-1"
              headline="${content.value.Headline}"
              link="${content.value.Link}" />
                    </div>

          <%-- ####### Show link as button if enabled ######## --%>
          <c:if test="${content.value.Link.isSet and cms.element.setting.ilink.value == 'button'}">
            <div class="thumbnails thumbnail-style" style="text-align: right; margin-top: 20px;">
              <apollo:link link="${content.value.Link}" linkclass="btn-more no-hover-effect" style="position: relative;" settitle="false"/>
            </div>
          </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </apollo:image-vars>
    </cms:formatter>
</cms:bundle>
