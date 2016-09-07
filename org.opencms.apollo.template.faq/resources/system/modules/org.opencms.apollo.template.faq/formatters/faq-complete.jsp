<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.faq">

	<cms:formatter var="content" val="value" rdfa="rdfa">

		<div class="ap-faq-complete mb-20">
			<c:choose>
				<c:when test="${cms.element.inMemoryOnly}">
					<div class="alert">
						<fmt:message key="apollo.faq.message.new" />
					</div>
				</c:when>
				<c:otherwise>
					<!-- FAQ header -->
					<div class="blog-page">
                        <div class="row">
                            <div class="col-xs-12">
                                <apollo:headline setting="${cms.element.setting}" headline="${content.value.Question}" />
                            </div>
                            
                            <div class="col-xs-12 col-sm-6">
                            
                                <div class="row">
                                <div class="col-xs-1 col-sm-2">
                                    <i class="icon-custom icon-sm icon-color-u fa fa-calendar"></i>                                
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

								<c:set var="categories" value="${content.readCategories}" />
								<c:if test="${not categories.isEmpty}">
                                <div class="row">

                                    <div class="col-xs-1 col-sm-2">
                                        <i class="icon-custom icon-sm icon-color-u fa fa-tag"></i>                                
                                    </div>
                                    <div class="col-xs-11 col-sm-10">
                                        <ul class="list-unstyled list-inline blog-tags">
                                            <li> 
                                                <c:forEach var="category"
                                                    items="${categories.leafItems}"
                                                    varStatus="status">
                                                    <span class="label rounded label-light">
                                                        <i class="fa fa-tag"></i> ${category.title}
                                                    </span>
                                                </c:forEach>
                                            </li>
                                        </ul>
                                    </div>

                                </div>
                                </c:if>

                            </div>

						</div>                       
					</div>
					<%-- //END FAQ header --%>

					<%-- paragraphs --%>
					<c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
					<c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">

						<apollo:paragraph 
							showimage="true"
							imgalign="${imgalign}"
							paragraph="${paragraph}" />

					</c:forEach>
					<%-- //END paragraphs --%>
				</c:otherwise>
			</c:choose>
		</div>
	</cms:formatter>
</cms:bundle> 