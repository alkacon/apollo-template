<%@ tag 
    display-name="contact"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats contact information from the given content in hCard microformat" %>

<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="Value wrapper for the contact image data. Standard Apollo image." %>

<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="Value wrapper for the contact link. Standard Apollo link." %>

<%@ attribute name="name" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="Value wrapper for the contact name. From nested schema type contact-name." %>

<%@ attribute name="position" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="Value wrapper for the contact position. Standard string." %>

<%@ attribute name="organization" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" 
    description="Value wrapper for the contact organization. Standard string." %>

<%@ attribute name="description" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" 
    description="Value wrapper for the contact description. Standard HTML." %>

<%@ attribute name="data" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" 
    description="Value wrapper for the contact data that includes address, telephone etc. From nested schema type contact-data." %>

<%@ attribute name="fragments" type="java.lang.String" required="false"
    description="The contact fragments to show.
    Possible values are [
    image: Show the image.
    label-icon: Use icons for labels.
    label-text: Use text for labels.
    effect-kenburns: Apply a 'Ken Burns' effect to the image.
    effect-shadow: Apply a shadow effect to the image. 
    animated-link: Show the animated link button over the image.
    name: Show the contact name and position.
    address: Show the contact address.
    organization: Show the contact organization.
    description: Show the contact description.
    phone: Show the contact phone numbers.
    email: Show the contact email.
    static-link: Show the static link text.
    ]" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:set var="labels">
    <c:if test="${fn:contains(fragments, 'label-text')}">text</c:if>
    <c:if test="${fn:contains(fragments, 'label-icon')}">icon</c:if>
</c:set>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.contact">

<%-- #### Contact exposed in hCard microformat, see http://microformats.org/wiki/hcard #### --%>

<apollo:image-animated
    test="${fn:contains(fragments, 'image')}"
    image="${image}"
    cssimage="photo"
    kenburnsanimation="${fn:contains(fragments, 'effect-kenburns')}"
    shadowanimation="${fn:contains(fragments, 'effect-shadow')}"
    >

    <c:if test="${link.isSet and fn:contains(fragments, 'animated-link')}">
        <div class="link">
            <apollo:link 
                link="${link}"
                cssclass="btn btn-xs btn-animated" />
        </div>
    </c:if>

    <c:if test="${fn:contains(fragments, 'name')}">
        <c:if test="${name.isSet}">
            <h3 class="fn n">
                <c:if test="${name.value.Title.isSet}"><span class="honorific-prefix">${name.value.Title} </span></c:if>
                <span class="given-name"> ${name.value.FirstName}</span>
                <c:if test="${name.value.MiddleName.isSet}"><span class="additional-name"> ${name.value.MiddleName}</span></c:if>
                <span class="family-name"> ${name.value.LastName}</span>
                <c:if test="${name.value.Suffix.isSet}"><span class="honorific-suffix"> ${name.value.Suffix}</span></c:if>
            </h3>
        </c:if>

        <c:if test="${position.isSet}"><h4 class="title" ${position.rdfaAttr}>${position}</h4></c:if>
    </c:if>

    <c:if test="${fn:contains(fragments, 'organization') and organization.isSet}"><div class="org" ${organization.rdfaAttr}>${organization}</div></c:if>
    <c:if test="${fn:contains(fragments, 'description') and description.isSet}"><div class="note" ${description.rdfaAttr}>${description}</div></c:if>

    <c:if test="${fn:contains(fragments, 'address') and data.isSet}">
        <div class="ap-contact-address">
            <c:if test="${icons}">
                <a id="ap-contact-adrlink-${cms.element.instanceId}"
                    href="" 
                    onclick="$('#ap-contact-adr-${cms.element.instanceId}').slideDown();$('#ap-contact-adrlink-${cms.element.instanceId}').hide();return false;">
                        <i class="fa fa-map-marker"></i>
                        <fmt:message key="apollo.contact.showaddress"/>
                </a>
            </c:if>
            <c:if test="${data.value.Address.isSet}">
                <div class="adr"<c:if test="${icons}">id="ap-contact-adr-${cms.element.instanceId}" style="display: none;" onclick="$('#ap-contact-adr-${cms.element.instanceId}').slideUp();$('#ap-contact-adrlink-${cms.element.instanceId}').slideDown();"</c:if>>
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

    <c:set var="showphone" value="${fn:contains(fragments, 'phone') and data.isSet}"/>
    <c:set var="showemail" value="${fn:contains(fragments, 'email') and data.isSet and data.value.EMail.isSet}"/>

    <apollo:tag test="${showphone or showemail}">div class="ap-contact-data"</apollo:tag>

    <c:if test="${showphone}">
        <c:if test="${data.value.Phone.isSet}"> 
            <div class="ap-contact-phone ap-tablerow">
                <apollo:icon-prefix icon="phone" fragments="${labels}">
                    <jsp:attribute name="text"><fmt:message key="apollo.contact.phone"/></jsp:attribute>
                </apollo:icon-prefix>
                <span class="ap-contact-value">
                    <a href="tel:${fn:replace(data.value.Phone, ' ','')}" ${data.rdfa.Phone}>
                        <span class="tel">${data.value.Phone}</span>
                    </a>
                </span>
            </div>
        </c:if>
        <c:if test="${data.value.Mobile.isSet}">
            <div class="ap-contact-mobile ap-tablerow">
                <apollo:icon-prefix icon="mobile" fragments="${labels}">
                    <jsp:attribute name="text"><fmt:message key="apollo.contact.mobile"/></jsp:attribute>
                </apollo:icon-prefix>
                <span class="ap-contact-value">
                    <a href="tel:${fn:replace(data.value.Mobile, ' ','')}" ${data.rdfa.Mobile}>
                        <span class="tel">${data.value.Mobile}</span>
                    </a>
                </span>
            </div>
        </c:if>
        <c:if test="${data.value.Fax.isSet}">
            <div class="ap-contact-fax ap-tablerow">
                <apollo:icon-prefix icon="fax" fragments="${labels}">
                    <jsp:attribute name="text"><fmt:message key="apollo.contact.fax"/></jsp:attribute>
                </apollo:icon-prefix>                
                <span class="ap-contact-value">
                    <a href="tel:${fn:replace(data.value.Fax, ' ','')}" ${data.rdfa.Fax}>
                        <span class="tel">${data.value.Fax}</span>
                    </a>
                </span>
            </div>
        </c:if>
    </c:if> 

    <c:if test="${showemail}">
        <div class="ap-contact-email ap-tablerow">
            <c:choose>
                <c:when test="${data.value.OpenEMail.isSet and data.value.OpenEMail == 'true'}">
                    <apollo:icon-prefix icon="at" fragments="${labels}" >
                        <jsp:attribute name="text"><fmt:message key="apollo.contact.openemail"/></jsp:attribute>
                    </apollo:icon-prefix>
                    <a class="ap-contact-value" href="mailto:${data.value.EMail}" title="${data.value.EMail}">
                        <span class="email">${data.value.EMail}</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <c:set var="emaillink">
                        <a class="ap-contact-email-obfuscated" 
                            href="javascript:descrambleContactEmail('<apollo:obfuscate-email text="${data.value.EMail}"/>');" 
                            id="apcontactemail${cms.element.id}" 
                            title="<fmt:message key='apollo.contact.email'/>">
                            <span><fmt:message key="apollo.contact.email"/></span>
                        </a>
                    </c:set>
                    <c:choose>
                        <c:when test="${fn:contains(labels, 'text') and fn:contains(labels, 'icon')}">
                            <apollo:icon-prefix icon="at" fragments="icon text" >
                                <jsp:attribute name="text"><c:out value="${emaillink}" escapeXml="false" /></jsp:attribute>
                                <jsp:attribute name="icontitle"><fmt:message key="apollo.contact.email"/></jsp:attribute>
                            </apollo:icon-prefix>
                        </c:when>
                        <c:when test="${fn:contains(labels, 'icon')}">
                            <apollo:icon-prefix icon="at" fragments="${labels}" >
                                <jsp:attribute name="text"><fmt:message key="apollo.contact.email"/></jsp:attribute>
                            </apollo:icon-prefix>
                            <c:out value="${emaillink}" escapeXml="false" />                        
                        </c:when>
                        <c:otherwise>
                            <c:out value="${emaillink}" escapeXml="false" />
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <apollo:tag test="${showphone or showemail}">/div</apollo:tag>

    <c:if test="${fn:contains(fragments, 'static-link')}">
        <apollo:link link="${link}" cssclass="btn btn-sm mt-10" />
    </c:if>

</apollo:image-animated>

</cms:bundle>