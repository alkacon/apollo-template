<%@page buffer="none" session="false" import="java.nio.charset.Charset" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %><%!

public String obfuscateContactEmail(String email) {
    StringBuilder encoded = new StringBuilder(email.length() * 6);
    // reverse the input
    email = new StringBuffer(email).reverse().toString();
    byte[] bytes = email.getBytes(Charset.forName("UTF-8"));
    for (int j = 0; j < bytes.length; j++) {
        String hex = String.format("%02X ", bytes[j]);
        if (hex.equals("40")) hex = "7b;53;43;52;41;4d;42;4c;45;7d"; // the @ symbol
        if (hex.equals("2e")) hex = "5b;53;43;52;41;4d;42;4c;45;5d"; // the . symbol
        encoded.append(hex + ";");
    }
    return encoded.toString();
}
%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.contact">

<cms:formatter var="content" val="value" rdfa="rdfa">
    
    <div class="ap-contact ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : "mb-20" }">

        <c:if test="${value.Contact.isSet and value.Contact.value.EMail.isSet}">
            <c:set var="contactEmail" value="${value.Contact.value.EMail.stringValue}" />
            <c:set var="contactEmail"><%= obfuscateContactEmail((String)pageContext.getAttribute("contactEmail")) %></c:set> 
        </c:if>
    
        <%-- ####### Init messages wrapper ################################## --%>
		<c:set var="textnew"><fmt:message key="apollo.contact.message.new" /></c:set>
        <c:set var="textedit"><fmt:message key="apollo.contact.message.edit" /></c:set>
		<apollo:init-messages textnew="${textnew}" textedit="${textedit}">
            
            <c:if test="${cms.element.settings.hideTitle ne 'true'}">
                <apollo:headline headline="${value.Title}" />
            </c:if>
            
            <div class="row">
    
                <c:set var="imagePresent" value="false" />
                <c:if test="${value.Image.isSet}">
                    <c:set var="imagePresent" value="true" />
                    <div class="ap-contact-image col-xs-4 col-sm-3">
                        <apollo:image-simple image="${value.Image}" link="${value.Link}" />
                    </div>
                </c:if>
                
                <c:choose>
                    <c:when test="${imagePresent}">
                        <c:choose>
                            <c:when test="${value.Link.isSet or (value.Contact.isSet and value.Contact.value.EMail.isSet)}">
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
                            <c:when test="${value.Link.isSet or (value.Contact.isSet and value.Contact.value.EMail.isSet)}">
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
                
                <div class="${col1Classes} ap-contact-details">
                
                    <c:if test="${value.Name.isSet}">
                        <div class="ap-contact-name">
                            <c:if test="${value.Name.value.Title.isSet}">${value.Name.value.Title}${' '}</c:if>
                            ${value.Name.value.FirstName}
                            <c:if test="${value.Name.value.MiddleName.isSet}">${' '}${value.Name.value.MiddleName}</c:if>
                            ${' '}${value.Name.value.LastName}
                            <c:if test="${value.Name.value.Suffix.isSet}">${' '}${value.Name.value.Suffix}</c:if>
                        </div>
                    </c:if>
                    
                    <c:if test="${value.Organisation.isSet}"><div class="ap-contact-organisation" ${rdfa.Organisation}>${value.Organisation}</div></c:if>
                    <c:if test="${value.Position.isSet}"><div class="ap-contact-position" ${rdfa.Position}>${value.Position}</div></c:if>
                    <c:if test="${value.Description.isSet}"><div class="ap-contact-description" ${rdfa.Description}>${value.Description}</div></c:if>
                    
                    
                    <c:if test="${value.Contact.isSet}">
                        <div class="ap-contact-data">
                        <c:if test="${value.Contact.value.Address.isSet}">
                                <div class="ap-contact-address">
                                    <a id="ap-contact-adrlink-${cms.element.instanceId}" href="" onclick="$('#ap-contact-adr-${cms.element.instanceId}').slideDown();$('#ap-contact-adrlink-${cms.element.instanceId}').hide();return false;"><fmt:message key="apollo.contact.showaddress"/></a>
                                    <div id="ap-contact-adr-${cms.element.instanceId}" style="display: none;" onclick="$('#ap-contact-adr-${cms.element.instanceId}').slideUp();$('#ap-contact-adrlink-${cms.element.instanceId}').show();">${value.Contact.value.Address}</div>
                                </div>
                            </c:if> 
                        
                            <c:if test="${value.Contact.value.Phone.isSet}"> 
                                <div class="ap-contact-phone"><fmt:message key="apollo.contact.phone"/></div><div class="ap-contact-phone-value"><a href="tel:${fn:replace(value.Contact.value.Phone, ' ','')}" ${value.Contact.rdfa.Phone}>${value.Contact.value.Phone}</a></div>
                            </c:if>
                            <c:if test="${value.Contact.value.Mobile.isSet}">
                                <div class="ap-contact-mobile"><fmt:message key="apollo.contact.mobile"/></div><div class="ap-contact-mobile-value"><a href="tel:${fn:replace(value.Contact.value.Mobile, ' ','')}" ${value.Contact.rdfa.Mobile}>${value.Contact.value.Mobile}</a></div>
                            </c:if>
                            <c:if test="${value.Contact.value.Fax.isSet}">
                                <div class="ap-contact-fax"><fmt:message key="apollo.contact.fax"/></div><div class="ap-contact-fax-value" ${value.Contact.rdfa.Fax}>${value.Contact.value.Fax}</div>
                            </c:if> 
                        </div>
                    </c:if>
                
                </div>
                
                <c:if test="${col2Present}">
                
                    <div class="${col2Classes} ap-contact-links">
                        <c:if test="${value.Contact.isSet and value.Contact.value.EMail.isSet}">
                            <div class="ap-contact-email">
                                <c:choose>
                                    <c:when test="${value.Contact.value.OpenEMail.isSet and value.Contact.value.OpenEMail == 'true'}">
                                        <div class="ap-contact-email-label"><fmt:message key="apollo.contact.openemail"/></div><a href="mailto:${value.Contact.value.EMail}" title="${value.Contact.value.EMail}">${value.Contact.value.EMail}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:descrambleContactEmail('${contactEmail}');" id="apcontactemail${cms.element.id}" title="<fmt:message key="apollo.contact.email"/>"><fmt:message key="apollo.contact.email"/></a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>
                        
                        <c:if test="${value.Link.isSet}">
                            <apollo:link link="${value.Link}" linkclass="btn btn-sm mt-5" />
                        </c:if>
                    </div>
                
                </c:if>
            
            </div>
        
        </apollo:init-messages>
    
    </div>
</cms:formatter>

</cms:bundle>