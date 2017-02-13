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
        elementId="${param.elementId}"
        instanceId="${param.instanceId}"

        source="${con.valueList.Folder}"
        types="${con.value.TypesToCollect}"
        count="${con.value.ItemsPerPage.isSet ? con.value.ItemsPerPage.toInteger : 5}"
        locale="${param.loc}"
        sort="${con.value.SortOrder}"
        categories="${con.readCategories}"
        formatterSettings="${formatterSettings}"
        ajaxCall="true"

        showfacets="${param.facets}"
        pageUri="${param.sitepath}"
        subsite="${param.subsite}"
        filterqueries="${con.value.FilterQueries}"
    />

    <%-- ####### Load pagination ######## --%>
    <c:choose>
        <c:when test="${param.option eq 'append'}">
            <c:set var="label">
                <c:choose>
                    <c:when test="${not empty formatterSettings.listButtonText}">
                        <c:out value="${formatterSettings.listButtonText}" />
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="pagination.loadmore" />
                    </c:otherwise>
                </c:choose>
            </c:set>
            <apollo:list-loadbutton
                search="${search}"
                label="${label}"
                onclickAction='ApolloList.update("${param.instanceId}", "$(LINK)", "false")'
            />
        </c:when>
        <c:otherwise>
            <apollo:list-pagination
                search="${search}"
                singleStep="false"
                onclickAction='ApolloList.update("${param.instanceId}", "$(LINK)", "true")'
            />
        </c:otherwise>
    </c:choose>

    <%-- ####### Provide information about search result for JavaScript ######## --%>
    <div id="resultdata" data-result='{<%--
    --%>"currentPage":"${search.controller.pagination.state.currentPage}", <%--
    --%>"pages":"${search.numPages}", <%--
    --%>"found":"${search.numFound}", <%--
    --%>"start":"${search.start}", <%--
    --%>"end":"${search.end}"<%--
--%>}'></div>
</c:if>

</cms:bundle>
