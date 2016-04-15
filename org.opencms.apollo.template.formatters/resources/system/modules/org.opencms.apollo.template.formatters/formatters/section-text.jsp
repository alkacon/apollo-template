<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content">

<c:if test="${content.value.Text.isSet}">
    <div class="${cms.element.setting.tstyle}" <c:if test="${not content.value.Link.exists}">${content.rdfa.Link}</c:if>>
        <div ${content.rdfa.Text}>
            ${content.value.Text}
        </div>
        <c:if test="${content.value.Link.exists}">
            <p ${content.rdfa.Link}>
                <a 
                    class="btn btn-u u-small" 
                    href="<cms:link>${content.value.Link.value.URI}</cms:link>">
                        ${content.value.Link.value.Text}
                </a>
            </p>
        </c:if>
    </div> 
</c:if>

</cms:formatter>