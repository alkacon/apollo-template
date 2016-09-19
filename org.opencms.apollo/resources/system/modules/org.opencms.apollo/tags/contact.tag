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
    <c:if test="${fn:contains(fragments, 'label-icon')}">
        icon
        <c:set var="showicons">true</c:set>
    </c:if>
</c:set>
<c:set var="animatedlink" value="${link.isSet and fn:contains(fragments, 'animated-link')}" />

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.contact">

<%-- #### Contact exposed in hCard microformat, see http://microformats.org/wiki/hcard #### --%>

<apollo:image-animated
    test="${fn:contains(fragments, 'image')}"
    image="${image}"
    cssclass="
        ${animatedlink ? 'ap-button-animation' : ''}
        ${fn:contains(fragments, 'effect-kenburns') ? ' ap-kenburns-animation' : ''}
        ${fn:contains(fragments, 'effect-shadow') ? ' ap-raise-animation' : ''}"

    cssimage="photo"
    >

    <c:if test="${animatedlink}">
        <div class="button-box">
            <apollo:link 
                link="${link}"
                cssclass="btn btn-xs" />
        </div>
    </c:if>

    <c:set var="showname" value="${fn:contains(fragments, 'name') and name.isSet}"/>
    <c:set var="showorganization" value="${fn:contains(fragments, 'organization') and organization.isSet}"/>
    <c:set var="showdescription" value="${fn:contains(fragments, 'description') and description.isSet}"/>
    <c:set var="showaddress" value="${fn:contains(fragments, 'address') and data.isSet and data.value.Address.isSet}"/>
    <c:set var="showphone" value="${fn:contains(fragments, 'phone') and data.isSet}"/>
    <c:set var="showemail" value="${fn:contains(fragments, 'email') and data.isSet and data.value.Email.isSet and data.value.Email.value.Email.isSet}"/>
    <c:set var="showstaticbutton" value="${fn:contains(fragments, 'static-link') and link.isSet}"/>

    <c:if test="${showname or showorganization or showdescription or showaddress or showphone or showemail or showstaticbutton}">
    <div class="text-box">

    <c:if test="${showname}">
        <h3 class="fn n">
            <c:if test="${name.value.Title.isSet}"><span class="honorific-prefix">${name.value.Title} </span></c:if>
            <span class="given-name"> ${name.value.FirstName}</span>
            <c:if test="${name.value.MiddleName.isSet}"><span class="additional-name"> ${name.value.MiddleName}</span></c:if>
            <span class="family-name"> ${name.value.LastName}</span>
            <c:if test="${name.value.Suffix.isSet}"><span class="honorific-suffix"> ${name.value.Suffix}</span></c:if>
        </h3>

        <c:if test="${position.isSet}"><h4 class="title" ${position.rdfaAttr}>${position}</h4></c:if>
    </c:if>

    <c:if test="${showorganization}"><div class="org" ${organization.rdfaAttr}>${organization}</div></c:if>
    <c:if test="${showdescription}"><div class="note" ${description.rdfaAttr}>${description}</div></c:if>

    <c:if test="${showaddress}">
        <div class="ap-contact-address">
            <c:if test="${showicons}">
                <div id="ap-contact-adrlink-${cms.element.instanceId}">
                    <apollo:icon-prefix icon="home" fragments="icon text" >
                        <jsp:attribute name="text">
                            <a  href=""
                                onclick="
                                    $('#ap-contact-adr-${cms.element.instanceId}').slideDown();
                                    $('#ap-contact-adrlink-${cms.element.instanceId}').hide();
                                    return false;">
                                <fmt:message key="apollo.contact.showaddress"/>
                            </a>
                        </jsp:attribute>
                        <jsp:attribute name="icontitle"><fmt:message key="apollo.contact.showaddress"/></jsp:attribute>
                    </apollo:icon-prefix>
                </div>
            </c:if>
            <div class="adr"
                <c:if test="${showicons}">
                    id="ap-contact-adr-${cms.element.instanceId}" 
                    style="display: none;" 
                    onclick="$('#ap-contact-adr-${cms.element.instanceId}').slideUp();$('#ap-contact-adrlink-${cms.element.instanceId}').slideDown();"
                </c:if>>
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
        </div>
    </c:if>

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
            <apollo:icon-prefix icon="at" fragments="${labels}" >
                <jsp:attribute name="text"><fmt:message key="apollo.contact.email"/></jsp:attribute>
            </apollo:icon-prefix>
            <apollo:email email="${data.value.Email}" cssclass="ap-contact-value">
                <jsp:attribute name="placeholder"><fmt:message key="apollo.contact.obfuscatedemail"/></jsp:attribute>
            </apollo:email>
        </div>
    </c:if>

    <c:if test="${showstaticbutton}">
        <apollo:link link="${link}" cssclass="btn btn-sm button-static" />
    </c:if>

    </div>
    </c:if>

</apollo:image-animated>

</cms:bundle>