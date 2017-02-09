<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages>

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.blog.messages">

<div class="ap-detail-page ap-blog-page">

    <%-- blog header --%>
    <c:choose>
    <c:when test="${cms.element.setting.showmarkers.toBoolean}">

    <%-- create author link --%>
    <c:set var="author" value="${fn:trim(value.Author)}" />
    <c:choose>
        <c:when test="${fn:length(author) > 3 && value.AuthorMail.exists}">
            <c:set var="author">
                <a href="mailto:${value.AuthorMail}" title="${author}">${author}</a>
            </c:set>
        </c:when>
        <c:when test="${fn:length(author) > 3}">
            <c:set var="author">${author}</c:set>
        </c:when>
        <c:when test="${value.AuthorMail.exists}">
            <c:set var="author">
                <a href="mailto:${value.AuthorMail}" title="${value.AuthorMail}">${value.AuthorMail}</a>
            </c:set>
        </c:when>
        <c:otherwise>
            <c:set var="author" value=""></c:set>
        </c:otherwise>
    </c:choose>
    <%-- //END create author link --%>

    <div class="ap-blog-header">
        <div class="row">
            <div class="col-xs-12">
               <c:if test="${cms.element.setting.showpdflink.toBoolean}">
                    <div class="pull-right">
                        <a class="btn btn-xs"
                            href="<cms:pdf format='%(link.weak:/system/modules/org.opencms.apollo/pages/blog-pdf.jsp:ca595340-57ca-11e5-a989-0242ac11002b)' content='${content.filename}' locale='${cms.locale}'/>"
                            target="pdf"> <i class="fa fa-file-pdf-o"></i> <fmt:message key="apollo.blog.message.pdflink" />
                        </a>
                    </div>
                </c:if>
                <div class="headline pull-left">
                    <h2 ${content.value.Title.rdfaAttr}>${content.value.Title}</h2>
                </div>
            </div>

            <div class="col-xs-12 col-sm-6">

                <div class="row">
                <div class="col-xs-1 col-sm-2">
                    <i class="detail-icon fa fa-calendar"></i>
                </div>
                <div class="col-xs-11 col-sm-10 detail-date">

                    <h5>
                        <fmt:formatDate
                            value="${cms:convertDate(value.Date)}"
                            dateStyle="SHORT"
                            timeStyle="SHORT"
                            type="both" />
                    </h5>

                </div>
                </div>

                <apollo:categorylist categories="${content.readCategories}" showbigicon="true" />

            </div>

            <c:if test="${author ne ''}">
                <div class="col-xs-1">
                    <i class="detail-icon fa fa-pencil"></i>
                </div>
                <div class="col-xs-11 col-sm-5 detail-author">
                    <h5>${author}</h5>
                </div>
            </c:if>

        </div>
    </div>

    </c:when>
    <c:otherwise>
       <div class="clearfix">
           <c:if test="${cms.element.setting.showpdflink.toBoolean}">
                <div class="pull-right">
                    <a class="btn btn-xs"
                        href="<cms:pdf format='%(link.weak:/system/modules/org.opencms.apollo/pages/blog-pdf.jsp:ca595340-57ca-11e5-a989-0242ac11002b)' content='${content.filename}' locale='${cms.locale}'/>"
                        target="pdf"> <i class="fa fa-file-pdf-o"></i> Download PDF
                    </a>
                </div>
            </c:if>
            <div class="headline pull-left">
                <h2 ${content.value.Title.rdfaAttr}>${content.value.Title}</h2>
            </div>
        </div>
    </c:otherwise>
    </c:choose>
    <%-- //END blog header --%>

    <%-- paragraphs --%>
    <c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
    <c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">

        <apollo:paragraph
            showimage="true"
            imgalign="${imgalign}"
            paragraph="${paragraph}" />

    </c:forEach>
    <%-- //END paragraphs --%>

    <c:set var="editblogpage">${cms.subSitePath}blog/post-a-new-blog-entry/</c:set>
    <c:if test="${content.isEditable and cms.vfs.existsResource[editblogpage]}">
        <a href="<cms:link>${editblogpage}</cms:link>?fileId=${content.id}">
            <button type="button" class="btn btn-default">Edit this blog entry</button>
        </a>
    </c:if>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>