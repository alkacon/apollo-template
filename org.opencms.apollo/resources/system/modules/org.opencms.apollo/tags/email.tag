<%@ tag 
    display-name="email"
    trimDirectiveWhitespaces="true" 
    description="Formats an email as link with optional obfuscation" %>

<%@ attribute name="email" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="Value wrapper for the email. Has to use the nested schema of type email." %>

<%@ attribute name="placeholder" fragment="true" required="true" 
    description="Text to show in case the Email is obfuscated." %>

<%@ attribute name="cssclass" type="java.lang.String" required="false" 
    description="CSS class added to the a tag surrounding the email address."%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:set var="css"><c:if test="not empty ${cssclass}"> class="${cssclass}"</c:if></c:set>
<c:choose>
    <c:when test="${email.value.ObfuscateEmail.stringValue}">
        <c:set var="href">javascript:unobfuscateString('<apollo:obfuscate text="${email.value.Email}"/>', true);</c:set>
        <c:set var="address"><jsp:invoke fragment='placeholder' /></c:set>
    </c:when>
    <c:otherwise>
        <c:set var="href">mailto:${email.value.Email}</c:set>
        <c:set var="address">${email.value.Email}</c:set>
    </c:otherwise>
</c:choose>

<a ${css}
    href="${href}"
    title="${address}">
    <%-- Set class="email" so that hCard microformat can be supported --%>
    <span class="email">${address}</span>
</a>