<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>	
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.blog">

	<cms:formatter var="content" val="value" rdfa="rdfa">

		<div class="mb-20">
			<c:set var="inMemoryMessage"><fmt:message key="apollo.blog.message.edit" /></c:set>
            <apollo:init-messages textnew="${inMemoryMessage}">
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
                <%-- blog header --%>
                <div class="blog-page">
                    <div class="blog">
                        <div class="hidden-xs pull-right">
                            <a class="btn ap-btn-xs"
                                href="<cms:pdf format='%(link.weak:/system/modules/org.opencms.apollo/pages/blog-pdf.jsp:ca595340-57ca-11e5-a989-0242ac11002b)' content='${content.filename}' locale='${cms.locale}'/>"
                                target="pdf"> <i class="fa fa-file-pdf-o"></i> Download PDF
                            </a>
                        </div>

                        <apollo:headline setting="${cms.element.setting}" headline="${content.value.Title}" />

                        <div class="visible-xs margin-bottom-20">
                            <a class="btn ap-btn-red"
                                href="<cms:pdf format='%(link.weak:/system/modules/org.opencms.apollo/pages/blog-pdf.jsp:ca595340-57ca-11e5-a989-0242ac11002b)' content='${content.filename}' locale='${cms.locale}'/>"
                                target="pdf"> <i class="fa fa-file-pdf-o"></i> Download PDF
                            </a>
                        </div>

                        <ul class="list-unstyled list-inline blog-info">
                            <li><i class="icon-calendar"></i> <fmt:formatDate
                                    value="${cms:convertDate(value.Date)}" dateStyle="SHORT"
                                    timeStyle="SHORT" type="both" /></li>
                            <c:if test="${author ne ''}">
                                <li><i class="icon-pencil"></i> ${author}</li>
                            </c:if>
                        </ul>
                        <apollo:categorylist categories="${content.readCategories}" showbigicon="false" />
                    </div>
                </div>
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

                <c:if test="${content.isEditable}">
                    <a href="<cms:link>${cms.subSitePath}blog/post-a-new-blog-entry/</cms:link>?fileId=${content.id}">
                        <button type="button" class="btn btn-default">Edit this blog entry</button>
                    </a>
                </c:if>
			</apollo:init-messages>
		</div>
	</cms:formatter>
</cms:bundle>