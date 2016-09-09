<%@page 
	buffer="none" 
	session="false" 
	import="java.nio.charset.Charset"
	trimDirectiveWhitespaces="true"%>
	
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.contact">
<cms:formatter var="content" val="value" rdfa="rdfa">

<%-- #### Contact exposed in hCard microformat, see http://microformats.org/wiki/hcard #### --%>

<div class="ap-contact ap-contact-onecol vcard">

	<%-- ####### Init messages wrapper ################################## --%>

	<c:set var="textnew"><fmt:message key="apollo.contact.message.new" /></c:set>
	<apollo:init-messages textnew="${textnew}">

	
		<apollo:image-kenburn-new
			image="${value.Image}"
			imagestyle="photo"
			divstyle="thumbnail-style"
			shadowanimation="${cms.element.setting.showShadow.value}"
			imageanimation="${cms.element.setting.showKenburn.value}"
		>

		<c:if test="${value.Link.isSet and cms.element.setting.showLink.value}">
			<div class="thumbnail-kenburn">
				<c:set var="linktext"><fmt:message key="apollo.link.frontend.more" /></c:set>
				<apollo:link link="${value.Link}" linkclass="btn-more hover-effect" linktext="${linktext}" />
			</div>
		</c:if>

		<div class="ap-contact-details">

			<c:if test="${value.Name.isSet}">
				<h3 class="fn n">
					<c:if test="${value.Name.value.Title.isSet}"><span class="honorific-prefix">${value.Name.value.Title} </span></c:if>
					<span class="given-name"> ${value.Name.value.FirstName}</span>
					<c:if test="${value.Name.value.MiddleName.isSet}"><span class="additional-name"> ${value.Name.value.MiddleName}</span></c:if>
					<span class="family-name"> ${value.Name.value.LastName}</span>
					<c:if test="${value.Name.value.Suffix.isSet}"><span class="honorific-suffix"> ${value.Name.value.Suffix}</span></c:if>
				</h3>
			</c:if>

			<c:if test="${value.Position.isSet}"><h4 class="title" ${rdfa.Position}>${value.Position}</h4></c:if>
			<c:if test="${value.Organisation.isSet and cms.element.setting.showOrganisation.value}"><div class="org" ${rdfa.Organisation}>${value.Organisation}</div></c:if>
			<c:if test="${value.Description.isSet and cms.element.setting.showDescription.value}"><div class="note" ${rdfa.Description}>${value.Description}</div></c:if>


			<c:if test="${value.Contact.isSet}">

				<c:if test="${cms.element.setting.showAddress.value}">
					<div class="ap-contact-address">
						<c:if test="${value.Contact.value.Address.isSet}">
							<div class="adr">
								<div class="street-address"> ${value.Contact.value.Address.value.StreetAddress}</div>
								<c:if test="${value.Contact.value.Address.value.ExtendedAddress.isSet}">
									<div class="extended-address"> ${value.Contact.value.Address.value.ExtendedAddress}</div>
								</c:if>
								<div class="ap-contact-city">
									<span class="locality"> ${value.Contact.value.Address.value.PostalCode}</span>
									<span class="region"> ${value.Contact.value.Address.value.Locality}</span>
								</div>
								<div class="ap-contact-street">
									<c:if test="${value.Contact.value.Address.value.Region.isSet}">
										<span class="postal-code"> ${value.Contact.value.Address.value.Region}</span>
									</c:if>     
									<c:if test="${value.Contact.value.Address.value.Country.isSet}">
										<span class="country-name"> ${value.Contact.value.Address.value.Country}</span>
									</c:if>     
								</div>
							</div>
						</c:if>         
					</div>
				</c:if>

				<c:if test="${cms.element.setting.showPhone.value}">
					<div class="ap-contact-phonenumbers">            
						<c:if test="${value.Contact.value.Phone.isSet}"> 
							<div class="ap-contact-phone">
								<span class="ap-contact-label">
									<fmt:message key="apollo.contact.phone"/>
								</span>
								<span class="ap-contact-value">
									<a href="tel:${fn:replace(value.Contact.value.Phone, ' ','')}" ${value.Contact.rdfa.Phone}>
										<span class="tel">${value.Contact.value.Phone}</span>
									</a>
								</span>
							</div>	                    
						</c:if>
						<c:if test="${value.Contact.value.Mobile.isSet}">
							<div class="ap-contact-mobile">
								<span class="ap-contact-label">
									<fmt:message key="apollo.contact.mobile"/>
								</span>
								<span class="ap-contact-value">
									<a href="tel:${fn:replace(value.Contact.value.Mobile, ' ','')}" ${value.Contact.rdfa.Mobile}>
										<span class="tel">${value.Contact.value.Mobile}</span>
									</a>
								</span>
							</div>
						</c:if>
						<c:if test="${value.Contact.value.Fax.isSet}">
							<div class="ap-contact-fax">
								<span class="ap-contact-label">
									<fmt:message key="apollo.contact.fax"/>
								</span>
								<span class="ap-contact-value" ${value.Contact.rdfa.Fax}>
									<span class="tel">${value.Contact.value.Fax}</span>
								</span>
							</div>
						</c:if>  
					</div>
				</c:if> 

				<c:if test="${cms.element.setting.showEmail.value and value.Contact.value.EMail.isSet}">
					<div class="ap-contact-email">
						<c:choose>
							<c:when test="${value.Contact.value.OpenEMail.isSet and value.Contact.value.OpenEMail == 'true'}">
								<div class="ap-contact-label">
									<fmt:message key="apollo.contact.openemail"/>
								</div>
								<a class="ap-contact-value" href="mailto:${value.Contact.value.EMail}" title="${value.Contact.value.EMail}">
									<span class="email">${value.Contact.value.EMail}</span>
								</a>
							</c:when>
							<c:otherwise>
								<a class="ap-contact-email-obfuscated" href="javascript:descrambleContactEmail('<apollo:obfuscate-email text="${value.Contact.value.EMail}"/>');" id="apcontactemail${cms.element.id}" title="<fmt:message key="apollo.contact.email"/>">
									<fmt:message key="apollo.contact.email"/>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</c:if>   

			</c:if>

		</div>	

		</apollo:image-kenburn-new>

	</apollo:init-messages>

</div>

</cms:formatter>
</cms:bundle>
