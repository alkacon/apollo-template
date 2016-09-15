<%@ tag 
    display-name="contact"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats contact information from the given content in hCard microformat" %>

<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="name" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="position" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="organisation" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="description" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="data" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>

<%@ attribute name="cols" type="java.lang.Integer" required="true" %>
	
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:set var="col1Classes" value="" />
<c:set var="col2Classes" value="" />
<c:set var="col2Present" value="false" />
<c:set var="icons" value="${cms.element.setting.showIcons.value}" />

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.contact">

<%-- #### Contact exposed in hCard microformat, see http://microformats.org/wiki/hcard #### --%>

    <c:if test="${cols > 1}">
        <c:out value='<div class="row">' escapeXml='false' />	
        <c:choose>
            <c:when test="${image.isSet}">
                <c:out value='<div class="ap-contact-image col-xs-4 col-sm-3">' escapeXml='false' />	
                <c:choose>
                    <c:when test="${(cols > 2) and ((not empty link and link.isSet) or (data.isSet and data.value.EMail.isSet))}">
                        <c:set var="col2Present" value="true" />
                        <c:set var="col1Classes" value="col-xs-8 col-sm-5" />
                        <c:set var="col2Classes" value="col-xs-12 col-sm-4" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="col2Present" value="false" />
                        <c:set var="col1Classes" value="col-xs-8 col-sm-9" />
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${(cols > 2) and ((not empty link and link.isSet) or (data.isSet and data.value.EMail.isSet))}">
                        <c:set var="col2Present" value="true" />
                        <c:set var="col1Classes" value="col-xs-12 col-sm-8" />
                        <c:set var="col2Classes" value="col-xs-12 col-sm-4" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="col2Present" value="false" />
                        <c:set var="col1Classes" value="col-xs-12" />
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:if>

    <apollo:image-kenburn-new
        image="${image}"
        imagestyle="photo"
        divstyle="thumbnail-style"
        shadowanimation="${cms.element.setting.showShadow.value}"
        imageanimation="${cms.element.setting.showKenburn.value}"
    >

    <c:if test="${(cols > 1) and image.isSet}">
        <c:out value='</div></div></div>' escapeXml='false' />	
    </c:if>

    <c:if test="${cols < 2 and not empty link and link.isSet and cms.element.setting.showLink.value}">
        <div class="thumbnail-kenburn">
            <c:set var="linktext"><fmt:message key="apollo.link.frontend.more" /></c:set>
            <apollo:link link="${link}" cssclass="btn-more hover-effect" linktext="${linktext}" />
        </div>
    </c:if>

    <div class="${col1Classes} ap-contact-details">

        <c:if test="${name.isSet}">
            <h3 class="<c:if test="${cols > 1}">mt-0</c:if> fn n">
                <c:if test="${name.value.Title.isSet}"><span class="honorific-prefix">${name.value.Title} </span></c:if>
                <span class="given-name"> ${name.value.FirstName}</span>
                <c:if test="${name.value.MiddleName.isSet}"><span class="additional-name"> ${name.value.MiddleName}</span></c:if>
                <span class="family-name"> ${name.value.LastName}</span>
                <c:if test="${name.value.Suffix.isSet}"><span class="honorific-suffix"> ${name.value.Suffix}</span></c:if>
            </h3>
        </c:if>

        <c:if test="${not empty position and position.isSet}"><h4 class="title" ${position.rdfaAttr}>${position}</h4></c:if>
        <c:if test="${not empty organisation and organisation.isSet and cms.element.setting.showOrganisation.value}"><div class="org" ${organisation.rdfaAttr}>${organisation}</div></c:if>
        <c:if test="${not empty description and description.isSet and cms.element.setting.showDescription.value}"><div class="note" ${description.rdfaAttr}>${description}</div></c:if>

        <c:if test="${data.isSet}">

            <c:if test="${cms.element.setting.showAddress.value}">
                <div class="ap-contact-address">
                    <c:if test="${icons}">
                        <a id="ap-contact-adrlink-${cms.element.instanceId}" href="" onclick="$('#ap-contact-adr-${cms.element.instanceId}').slideDown();$('#ap-contact-adrlink-${cms.element.instanceId}').hide();return false;"><i class="fa fa-map-marker"></i><fmt:message key="apollo.contact.showaddress"/></a>
                    </c:if>
                    <c:if test="${data.value.Address.isSet}">
                        <div class="adr" <c:if test="${icons}">id="ap-contact-adr-${cms.element.instanceId}" style="display: none;" onclick="$('#ap-contact-adr-${cms.element.instanceId}').slideUp();$('#ap-contact-adrlink-${cms.element.instanceId}').slideDown();"</c:if>>
                            <div class="street-address"> ${data.value.Address.value.StreetAddress}</div>
                            <c:if test="${data.value.Address.value.ExtendedAddress.isSet}">
                                <div class="extended-address"> ${data.value.Address.value.ExtendedAddress}</div>
                            </c:if>
                            <div class="ap-contact-city">
                                <span class="locality"> ${data.value.Address.value.PostalCode}</span>
                                <span class="region"> ${data.value.Address.value.Locality}</span>
                            </div>
                            <div class="ap-contact-street">
                                <c:if test="${data.value.Address.value.Region.isSet}">
                                    <span class="postal-code"> ${data.value.Address.value.Region}</span>
                                </c:if>     
                                <c:if test="${data.value.Address.value.Country.isSet}">
                                    <span class="country-name"> ${data.value.Address.value.Country}</span>
                                </c:if>     
                            </div>
                        </div>
                    </c:if>         
                </div>
            </c:if>

            <c:if test="${cms.element.setting.showPhone.value}">
                <div class="ap-contact-phonenumbers">            
                    <c:if test="${data.value.Phone.isSet}"> 
                        <div class="ap-contact-phone">
                            <span class="ap-contact-label">
                                <c:choose><c:when test="${icons}"><i class="fa fa-phone" title="<fmt:message key="apollo.contact.phone"/>"></i></c:when><c:otherwise><fmt:message key="apollo.contact.phone"/></c:otherwise></c:choose>
                            </span>
                            <span class="ap-contact-value">
                                <a href="tel:${fn:replace(data.value.Phone, ' ','')}" ${data.rdfa.Phone}>
                                    <span class="tel">${data.value.Phone}</span>
                                </a>
                            </span>
                        </div>	                    
                    </c:if>
                    <c:if test="${data.value.Mobile.isSet}">
                        <div class="ap-contact-mobile">
                            <span class="ap-contact-label">
                                <c:choose><c:when test="${icons}"><i class="fa fa-mobile" title="<fmt:message key="apollo.contact.mobile"/>"></i></c:when><c:otherwise><fmt:message key="apollo.contact.mobile"/></c:otherwise></c:choose>
                            </span>
                            <span class="ap-contact-value">
                                <a href="tel:${fn:replace(data.value.Mobile, ' ','')}" ${data.rdfa.Mobile}>
                                    <span class="tel">${data.value.Mobile}</span>
                                </a>
                            </span>
                        </div>
                    </c:if>
                    <c:if test="${data.value.Fax.isSet}">
                        <div class="ap-contact-fax">
                            <span class="ap-contact-label">
                                <c:choose><c:when test="${icons}"><i class="fa fa-fax" title="<fmt:message key="apollo.contact.fax"/>"></i></c:when><c:otherwise><fmt:message key="apollo.contact.fax"/></c:otherwise></c:choose>
                            </span>
                            <span class="ap-contact-value" ${data.rdfa.Fax}>
                                <span class="tel">${data.value.Fax}</span>
                            </span>
                        </div>
                    </c:if>  
                </div>
            </c:if> 

            <c:if test="${col2Present}">
                <c:out value='</div><div class="${col2Classes} ap-contact-links">' escapeXml='false' />
            </c:if>

            <c:if test="${cms.element.setting.showEmail.value and data.value.EMail.isSet}">
                <div class="ap-contact-email">
                    <c:choose>
                        <c:when test="${data.value.OpenEMail.isSet and data.value.OpenEMail == 'true'}">
                            <div class="ap-contact-label">
                                <c:choose><c:when test="${icons}"><i class="fa fa-at" title="<fmt:message key="apollo.contact.openemail"/>"></i></c:when><c:otherwise><fmt:message key="apollo.contact.openemail"/></c:otherwise></c:choose>
                            </div>
                            <a class="ap-contact-value" href="mailto:${data.value.EMail}" title="${data.value.EMail}">
                                <span class="email">${data.value.EMail}</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a class="ap-contact-email-obfuscated" href="javascript:descrambleContactEmail('<apollo:obfuscate-email text="${data.value.EMail}"/>');" id="apcontactemail${cms.element.id}" title="<fmt:message key="apollo.contact.email"/>">
                                <c:if test="${icons}"><i class="fa fa-at" title="<fmt:message key="apollo.contact.email"/>"></i></c:if><fmt:message key="apollo.contact.email"/>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <c:if test="${cols > 1 and not empty link and link.isSet and cms.element.setting.showLink.value}">
                    <apollo:link link="${link}" cssclass="btn btn-sm mt-5" />
            </c:if>

        </c:if>

    </div>

    <c:if test="${cols > 1}">
        <c:out value='</div>' escapeXml='false' />	
        <c:if test="${image.isSet}">
            <c:out value='<div><div>' escapeXml='false' />	
        </c:if>
    </c:if>

    </apollo:image-kenburn-new>

</cms:bundle>