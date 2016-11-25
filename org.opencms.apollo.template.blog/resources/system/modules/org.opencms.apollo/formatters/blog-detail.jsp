<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>	
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.blog.messages">

	<cms:formatter var="content" val="value" rdfa="rdfa">

		<div class="ap-blog-page mb-20">
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
                <div class="ap-blog-header">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="hidden-xs pull-right">
                                <a class="btn ap-btn-xs mt-10"
                                    href="<cms:pdf format='%(link.weak:/system/modules/org.opencms.apollo/pages/blog-pdf.jsp:ca595340-57ca-11e5-a989-0242ac11002b)' content='${content.filename}' locale='${cms.locale}'/>"
                                    target="pdf"> <i class="fa fa-file-pdf-o"></i> Download PDF
                                </a>
                            </div>
                            <apollo:headline headline="${content.value.Title}" />
                            <div class="visible-xs">
                                <a class="btn ap-btn mb-10"
                                    href="<cms:pdf format='%(link.weak:/system/modules/org.opencms.apollo/pages/blog-pdf.jsp:ca595340-57ca-11e5-a989-0242ac11002b)' content='${content.filename}' locale='${cms.locale}'/>"
                                    target="pdf"> <i class="fa fa-file-pdf-o"></i> Download PDF
                                </a>
                            </div>
                        </div>

                        <div class="col-xs-12 col-sm-6">

                            <div class="row">
                            <div class="col-xs-1 col-sm-2">
                                <i class="icon-detail fa fa-calendar"></i>                                
                            </div>
                            <div class="col-xs-11 col-sm-10">

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
                                <i class="icon-detail fa fa-pencil"></i>
                            </div>
                            <div class="col-xs-11 col-sm-5">
                                <h5>${author}</h5>
                            </div>
                        </c:if> 

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

                <c:set var="editblogpage">${cms.subSitePath}blog/post-a-new-blog-entry/</c:set>
                <c:if test="${content.isEditable and cms.vfs.existsResource[editblogpage]}">
                    <a href="<cms:link>${editblogpage}</cms:link>?fileId=${content.id}">
                        <button type="button" class="btn btn-default">Edit this blog entry</button>
                    </a>
                </c:if>
			</apollo:init-messages>
		</div>
	</cms:formatter>
</cms:bundle>