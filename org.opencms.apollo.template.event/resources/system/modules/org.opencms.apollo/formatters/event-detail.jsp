<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.event">

	<cms:formatter var="content" val="value" rdfa="rdfa">

		<div class="mb-20">
			<c:set var="inMemoryMessage"><fmt:message key="apollo.event.message.edit" /></c:set>
            <apollo:init-messages textnew="${inMemoryMessage}">
                <!-- blog header -->
                <div class="blog-page">
                    <div class="row">
                        <div class="col-xs-12">
                            <apollo:headline headline="${content.value.Title}" />
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
                                    <c:if test="${value.EndDate.isSet}"> 
                                        - <fmt:formatDate
                                            value="${cms:convertDate(value.EndDate)}" 
                                            dateStyle="SHORT"
                                            timeStyle="SHORT" 
                                            type="both" />
                                    </c:if>
                                </h5>
                            
                            </div>
                            </div>

                            <apollo:categorylist categories="${content.readCategories}" showbigicon="true" />

                        </div>
                        
                        <c:if test="${value.Location.isSet or value.Address.isSet or value.AddressDetails.isSet}">
                            <div class="col-xs-1">
                                <i class="icon-custom icon-sm icon-color-u fa fa-map-marker"></i>
                            </div>
                            <div class="col-xs-11 col-sm-5">
                                <c:if test="${value.Location.isSet}">
                                    <h5 ${rdfa.Location}>${value.Location}</h5>
                                </c:if>
                                <c:if test="${value.Address.isSet}">
                                    <div ${rdfa.Address}>${value.Address}</div>
                                </c:if>
								<c:if test="${value.AddressDetails.isSet}">
                                    <div class="adress">
										<div class="street"> ${value.AddressDetails.value.StreetAddress}</div>
										<c:if test="${value.AddressDetails.value.ExtendedAddress.isSet}">
											<div class="extended"> ${value.AddressDetails.value.ExtendedAddress}</div>
										</c:if>
										<div class="ap-contact-city">
											<span class="code"> ${value.AddressDetails.value.PostalCode}</span>
											<span class="region"> ${value.AddressDetails.value.Locality}</span>
										</div>
										<div class="ap-contact-region">
											<c:if test="${value.AddressDetails.value.Region.isSet}">
												<span class="region"> ${value.AddressDetails.value.Region}</span>
											</c:if>
											<c:if test="${value.AddressDetails.value.Country.isSet}">
												<span class="country"> ${value.AddressDetails.value.Country}</span>
											</c:if>
										</div>
									</div>
                                </c:if>
                            </div>
                        </c:if> 
                                
                    </div>                       
                </div>
                <%-- //END blog header --%>

                <%-- paragraphs --%>
                <c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
                <c:forEach 
                    var="paragraph" 
                    items="${content.valueList.Paragraph}"
                    varStatus="status">

                    <apollo:paragraph 
                        showimage="true"
                        imgalign="${imgalign}"
                        paragraph="${paragraph}" />

                </c:forEach>
                <%-- //END paragraphs --%>
			</apollo:init-messages>
		</div>
	</cms:formatter>
</cms:bundle>
