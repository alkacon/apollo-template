<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<cms:secureparams />

<%-- ####### Search and display the images ######################################## --%>

<apollo:imagegallery
    usecase="item"
    path="${param.path}"
    count="${param.items}"
    page="${param.page}"
    css="${param.css}"
    showtitle="${param.title}"
    showcopyright="${param.copyright}"
/>