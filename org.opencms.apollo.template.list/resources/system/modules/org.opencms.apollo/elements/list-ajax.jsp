<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:secureparams />

<fmt:setLocale value="${param.loc}" />
<cms:bundle basename="org.opencms.apollo.template.list.messages">

    <c:set var="con" value="${cms.vfs.readXml[param.contentpath]}" />
    <c:if test="${not empty con}">

        <%-- ####### Merge the list parameters with the default formatter settings ######## --%>
        <apollo:formatter-settings 
            type="${con.value.TypesToCollect}" 
            parameters="${con.valueList.Parameters}"
            online="${cms.isOnlineProject}" 
        />

        <%-- ####### List entries ######## --%>

        <apollo:list-main
            source="${con.value.Folder}" 
            types="${con.value.TypesToCollect}" 
            count="${con.value.ItemsPerPage.isSet ? con.value.ItemsPerPage.toInteger : 5}" 
            locale="${param.loc}"
            sort="${con.value.SortOrder}"
            categories="${con.readCategories}"
            formatterSettings="${formatterSettings}"
            ajaxCall="true"

            listid="${param.id}"

            showfacets="${param.facets}"
            pageUri="${param.sitepath}"
            subsite="${param.subsite}"
        />

        <%-- ####### Load pagination (dynamic or normal) ######## --%>
        <c:choose>
            <c:when test="${param.dynamic}">
                <c:set var="label"><fmt:message key="pagination.loadmore"/></c:set>
                <apollo:list-loadbutton 
                    search="${search}" 
                    label="${label}"
                />
            </c:when>
            <c:otherwise>
                <apollo:list-pagination 
                    search="${search}" 
                    singleStep="false"
                    onclickAction='reloadInnerList("$(LINK)", $(this).parents().filter(".ap-list-entries"))'
                />
            </c:otherwise>
        </c:choose>
    </c:if>

</cms:bundle>
