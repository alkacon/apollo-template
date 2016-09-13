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
<cms:formatter var="content" val="value">

<%-- #### Contact exposed in hCard microformat, see http://microformats.org/wiki/hcard #### --%>

<div class="ap-contact ap-contact-onecol vcard">

	<%-- ####### Init messages wrapper ################################## --%>
	<c:set var="textnew"><fmt:message key="apollo.contact.message.new" /></c:set>
	<apollo:init-messages textnew="${textnew}">

		<apollo:contact
			image="${value.Image}"
			link="${value.Link}"
			name="${value.Name}"
            position="${value.Position}"
            organisation="${value.Organisation}"
            description="${value.Description}"
            data="${value.Contact}"
            cols="1"
		/>

	</apollo:init-messages>

</div>

</cms:formatter>
</cms:bundle>