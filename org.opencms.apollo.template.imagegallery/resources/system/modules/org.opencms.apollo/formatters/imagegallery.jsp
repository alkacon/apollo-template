<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.imagegallery.messages">
    <cms:formatter var="content">
	
    <%-- ################################################################################################################## --%>
    <%-- #######           How it works	                          ######################################################### --%>
    <%-- ################################################################################################################## --%>
    <%-- #                                                                                                                # --%>
    <%-- # The div#links-container starts empty and is filled by AJAX-Request. Through inline script in the               # --%>
    <%-- # imagegallery.xml the Javascript procedure is started, which uses the information from data-attributes          # --%>
    <%-- # provided by generated content of the <apollo:gallerydata> tag. The AJAX-Request is recieved by                 # --%>
    <%-- # imagegallery-inner.jsp which uses the <apollo:galleryitems> tag to render the images into the list.            # --%>
    <%-- #                                                                                                                # --%>
    <%-- ################################################################################################################## --%>
	
    
    <%-- ################################################################################################################## --%>
    <%-- #######           Search config and AJAX-Link            ######################################################### --%>
    <%-- ################################################################################################################## --%>
    
    <c:set var="pathPrefix">${cms.requestContext.siteRoot}</c:set>
    <c:if test="${fn:startsWith(content.value.ImageFolder.stringValue, '/shared/')}"><c:set var="pathPrefix"></c:set></c:if>
    <c:set var="path" value="${pathPrefix}${content.value.ImageFolder}" />
    <c:set var="solrParamType">fq=type:"image"</c:set>
    <c:set var="solrParamDirs">&fq=parent-folders:"${path}"</c:set>
    <c:set var="extraSolrParams">${solrParamType}${solrParamDirs}&sort=path asc</c:set>
    <c:set var="searchConfig">
        { "ignorequery" : true,
          "extrasolrparams" : "${fn:replace(extraSolrParams,'"','\\"')}",
          pagesize: 500 }
    </c:set>
    <c:set var="ajaxLink">
        <cms:link>%(link.strong:/system/modules/org.opencms.apollo/elements/imagegallery-ajax.jsp:9bb25674-8f80-11e5-a6ad-0242ac11002b)</cms:link>
    </c:set>
    
    <%-- ################################################################################################################## --%>
    <%-- #######            Gallery body and AJAX-data            ######################################################### --%>
    <%-- ################################################################################################################## --%>

    <div id="imagegallery" class="ap-image-gallery clearfix">
        <c:set var="textnew"><fmt:message key="apollo.imagegallery.message.new" /></c:set>
        <c:set var="textedit"><fmt:message key="apollo.imagegallery.message.edit" /></c:set>
        <apollo:init-messages textnew="${textnew}" textedit="${textedit}">

            <c:set var="pageSize" value="${cms.element.settings.imagesPerPage}" />
            <c:if test="${empty pageSize}"><c:set var="pageSize" value="20" /></c:if>
            <div id="links"></div>
            <div class="spinner animated">
                <div class="spinnerInnerBox"><i class="fa fa-spinner"></i></div>
            </div>
            <button class="btn animated" id="more" data-page="1" >
                <fmt:message key="apollo.imagegallery.message.more" />
            </button>

            <apollo:gallerydata ajax="${ajaxLink}" path="${path}" count="${pageSize}" searchconf="${searchConfig}" />

        </apollo:init-messages>
    </div>

    </cms:formatter>
</cms:bundle>