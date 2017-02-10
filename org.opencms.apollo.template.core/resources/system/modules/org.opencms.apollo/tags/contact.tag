<%@ tag
    display-name="contact"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Displays contact information from the given content with support for schema.org annotation." %>

<%@ attribute name="kind" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="Value wrapper for the contact kind. Standard string." %>

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
    position: Show the contact position.
    address: Show the contact address.
    organization: Show the contact organization.
    description: Show the contact description.
    phone: Show the contact phone numbers.
    email: Show the contact email.
    vcard: Show the vCard download option.
    static-link: Show the static link text.
    ]" %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<c:set var="labels">
    <c:if test="${fn:contains(fragments, 'label-text')}">
        text
        <c:set var="showtext">true</c:set>
    </c:if>
    <c:if test="${fn:contains(fragments, 'label-icon')}">
        icon
        <c:set var="showicons">true</c:set>
    </c:if>
    <c:if test="${fn:contains(fragments, 'label-min')}">
        text
        <c:set var="showtext">true</c:set>
        <c:set var="minlabels">true</c:set>
    </c:if>
</c:set>
<c:set var="animatedlink" value="${link.isSet and fn:contains(fragments, 'animated-link')}" />
<c:set var="showImage" value="${fn:contains(fragments, 'image')}" />

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.contact.messages">

<%-- #### Contact exposed as 'Person', see http://schema.org/Person #### --%>

<apollo:image-animated
    test="${showImage}"
    image="${image}"
    cssclass="
        ${animatedlink ? 'ap-button-animation' : ''}
        ${fn:contains(fragments, 'effect-kenburns') ? ' ap-kenburns-animation' : ''}
        ${fn:contains(fragments, 'effect-shadow') ? ' ap-raise-animation' : ''}"

    cssimage="photo"
    attr='itemprop="image"'
    >

    <c:if test="${animatedlink and showImage}">
        <div class="button-box">
            <apollo:link
                link="${link}"
                attr='itemprop="url"'
                cssclass="btn btn-xs" />
        </div>
    </c:if>

    <c:set var="showname" value="${fn:contains(fragments, 'name') and name.isSet}"/>
    <c:set var="showposition" value="${fn:contains(fragments, 'position')}"/>
    <c:set var="showorganization" value="${fn:contains(fragments, 'organization') and organization.isSet}"/>
    <c:set var="showdescription" value="${fn:contains(fragments, 'description') and description.isSet}"/>
    <c:set var="showaddress" value="${fn:contains(fragments, 'address') and data.isSet and data.value.Address.isSet}"/>
    <c:set var="showaddressalways" value="${showaddress and fn:contains(fragments, 'address-always')}"/>
    <c:set var="showphone" value="${fn:contains(fragments, 'phone') and data.isSet}"/>
    <c:set var="showemail" value="${fn:contains(fragments, 'email') and data.isSet and data.value.Email.isSet and data.value.Email.value.Email.isSet}"/>
    <c:set var="showstaticbutton" value="${fn:contains(fragments, 'static-link') and link.isSet}"/>
    <c:set var="showvcard" value="${fn:contains(fragments, 'vcard')}"/>

    <c:if test="${showname or showorganization or showdescription or showaddress or showphone or showemail or showstaticbutton}">
    <div class="text-box">

    <c:set var="personname">
        <c:if test="${name.value.Title.isSet}"><span itemprop="honorificPrefix" ${name.value.Title.rdfaAttr}>${name.value.Title} </span></c:if>
        <span itemprop="givenName" ${name.value.FirstName.rdfaAttr}> ${name.value.FirstName}</span>
        <c:if test="${name.value.MiddleName.isSet}"><span itemprop="additionalName" ${name.value.MiddleName.rdfaAttr}> ${name.value.MiddleName}</span></c:if>
        <span itemprop="familyName" ${name.value.LastName.rdfaAttr}> ${name.value.LastName}</span>
        <c:if test="${name.value.Suffix.isSet}"><span itemprop="honorificSuffix"  ${name.value.Suffix.rdfaAttr}> ${name.value.Suffix}</span></c:if>
    </c:set>

    <c:choose>
        <c:when test="${kind eq 'org'}">
            <c:if test="${showorganization}">
                <h3 class="fn n" ${organization.rdfaAttr} itemprop="name">
                    ${organization}
                </h3>
                <c:if test="${showposition and position.isSet}"><h4 itemprop="description" class="title" ${position.rdfaAttr}>${position}</h4></c:if>
            </c:if>
            <c:if test="${showname}">
                <div class="org" itemprop="employee" itemscope itemtype="http://schema.org/Person">${personname}</div>
            </c:if>
        </c:when>
        <c:otherwise>
            <c:if test="${showname}">
                <h3 class="fn n" itemprop="name">
                    ${personname}
                </h3>
                <c:if test="${showposition and position.isSet}"><h4 itemprop="jobTitle" class="title" ${position.rdfaAttr}>${position}</h4></c:if>
            </c:if>
            <c:if test="${showorganization}">
                <div class="org" itemprop="worksFor" ${organization.rdfaAttr}>${organization}</div>
            </c:if>
        </c:otherwise>
    </c:choose>

    <c:if test="${showdescription}"><div itemprop="description" class="note" ${description.rdfaAttr}>${description}</div></c:if>

    <c:if test="${showaddress}">
        <c:set var="animatedAddress" value="${not showaddressalways}" />
        <div ${animatedAddress ? 'class="clickme-showme"' : ''}>
            <div class="adr ${animatedAddress ? 'clickme' : ''}"
                itemprop="address" itemscope
                itemtype="http://schema.org/PostalAddress">
                <div itemprop="streetAddress" class="street-address" ${animatedAddress ? '' : data.value.Address.value.StreetAddress.rdfaAttr}>${data.value.Address.value.StreetAddress}</div>
                <c:if test="${data.value.Address.value.ExtendedAddress.isSet}">
                    <div itemprop="streetAddress" class="extended-address" ${animatedAddress ? '' : data.value.Address.value.ExtendedAddress.rdfaAttr}>${data.value.Address.value.ExtendedAddress}</div>
                </c:if>
                <div>
                    <span itemprop="postalCode" class="postal-code" ${animatedAddress ? '' : data.value.Address.value.PostalCode.rdfaAttr}>${data.value.Address.value.PostalCode}</span>
                    <span itemprop="addressLocality" class="locality" ${animatedAddress ? '' : data.value.Address.value.Locality.rdfaAttr}>${data.value.Address.value.Locality}</span>
                </div>
                <c:if test="${data.value.Address.value.Region.isSet or data.value.Address.value.Country.isSet}">
                    <div>
                        <c:if test="${data.value.Address.value.Region.isSet}">
                            <span itemprop="addressRegion" class="region" ${animatedAddress ? '' : data.value.Address.value.Region.rdfaAttr}>${data.value.Address.value.Region}</span>
                        </c:if>
                        <c:if test="${data.value.Address.value.Country.isSet}">
                            <span itemprop="addressCountry" class="country-name" ${animatedAddress ? '' : data.value.Address.value.Country.rdfaAttr}>${data.value.Address.value.Country}</span>
                        </c:if>
                    </div>
                </c:if>
            </div>
            <c:if test="${animatedAddress}">
                <div class="addresslink showme">
                    <c:choose>
                        <c:when test="${showicons}">
                            <apollo:icon-prefix icon="home" fragments="icon text" >
                                <jsp:attribute name="text">
                                    <span class="${showtext ? 'with-text' : 'only-icon'}"><a><%--
                                    --%><fmt:message key="apollo.contact.showaddress"/>
                                    </a></span>
                                </jsp:attribute>
                                <jsp:attribute name="icontitle">
                                    <fmt:message key="apollo.contact.showaddress"/>
                                </jsp:attribute>
                            </apollo:icon-prefix>
                        </c:when>
                        <c:otherwise>
                            <a class="adr"><fmt:message key="apollo.contact.showaddress"/></a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </c:if>

    <c:if test="${showphone}">
        <c:if test="${data.value.Phone.isSet}">
            <div class="phone tablerow">
                <apollo:icon-prefix icon="phone" fragments="${labels}">
                    <jsp:attribute name="text"><fmt:message key="apollo.contact.phone"/></jsp:attribute>
                </apollo:icon-prefix>
                <span>
                    <a href="tel:${fn:replace(data.value.Phone, ' ','')}" ${data.rdfa.Phone}>
                        <span itemprop="telephone" class="tel">${data.value.Phone}</span>
                    </a>
                </span>
            </div>
        </c:if>
        <c:if test="${data.value.Mobile.isSet}">
            <div class="mobile tablerow">
                <apollo:icon-prefix icon="mobile" fragments="${labels}">
                    <jsp:attribute name="text"><fmt:message key="apollo.contact.mobile"/></jsp:attribute>
                </apollo:icon-prefix>
                <span>
                    <a href="tel:${fn:replace(data.value.Mobile, ' ','')}" ${data.rdfa.Mobile}>
                        <span itemprop="telephone" class="tel">${data.value.Mobile}</span>
                    </a>
                </span>
            </div>
        </c:if>
        <c:if test="${data.value.Fax.isSet}">
            <div class="fax tablerow">
                <apollo:icon-prefix icon="fax" fragments="${labels}">
                    <jsp:attribute name="text"><fmt:message key="apollo.contact.fax"/></jsp:attribute>
                </apollo:icon-prefix>
                <span>
                    <a href="tel:${fn:replace(data.value.Fax, ' ','')}" ${data.rdfa.Fax}>
                        <span itemprop="faxNumber" class="tel">${data.value.Fax}</span>
                    </a>
                </span>
            </div>
        </c:if>
    </c:if>

    <c:if test="${showemail}">
        <div class="${minlabels ? 'mail' : 'mail tablerow'}" ${data.rdfa.Email}>
            <c:if test="${!minlabels}">
                <apollo:icon-prefix icon="at" fragments="${labels}" >
                    <jsp:attribute name="text"><fmt:message key="apollo.contact.email"/></jsp:attribute>
                </apollo:icon-prefix>
            </c:if>
            <apollo:email email="${data.value.Email}">
                <jsp:attribute name="placeholder"><fmt:message key="apollo.contact.obfuscatedemail"/></jsp:attribute>
            </apollo:email>
        </div>
    </c:if>

    <c:if test="${showvcard}">
        <div class="card">
            <a href="<cms:link>/system/modules/org.opencms.apollo/pages/contact.vcf?id=${cms.element.id}</cms:link>">
                <fmt:message key="apollo.contact.vcard.download"/>
            </a>
        </div>
    </c:if>

    <c:if test="${showstaticbutton}">
        <apollo:link link="${link}" cssclass="btn btn-sm button-static" attr='itemprop="url"' />
    </c:if>

    </div>
    </c:if>

</apollo:image-animated>

</cms:bundle>