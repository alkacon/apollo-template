<%@page buffer="none" session="false" import="org.opencms.file.*, org.opencms.main.*, org.opencms.util.*" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.disqus.messages">

    <div class="ap-disqus ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : 'mb-20' }">
        <c:set var="clickToLoad" value="false"/>
        <c:if test="${param.clicktoload == 'true'}"><c:set var="clickToLoad" value="true"/></c:if>

        <c:choose>
            <c:when test="${not empty cms.element.settings.disqus}">
                <c:set var="disqusSite">${cms.element.settings.disqus}</c:set>
            </c:when>
            <c:otherwise>
                <c:set var="disqusSite"><cms:property name="apollo.disqus" file="search" default=""/></c:set>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${empty disqusSite}">
                <div class="alert alert-danger"><fmt:message key="apollo.disqus.message.notset" /></div>
            </c:when>
            <c:when test="${cms.edited}">
                <div>${cms.enableReload}</div>
                <div class="alert alert-warning"><fmt:message key="apollo.disqus.message.edited" /></div>
            </c:when>
            <c:otherwise>

                <c:set var="cmsObject" value="${cms.vfs.cmsObject}"/>
                <c:choose>
                    <c:when test="${cms.detailRequest}">
                        <c:set var="fileName">${cms.requestContext.uri}</c:set>
                        <c:set var="pageId" value="${cms.detailContentId}" />
                        <c:set var="pageUrl"><%= OpenCms.getLinkManager().getPermalink((CmsObject)pageContext.getAttribute("cmsObject"),(String)pageContext.getAttribute("fileName"), (CmsUUID)pageContext.getAttribute("pageId")) %></c:set>
                        <c:set var="pageId" value="${cms.locale}-${pageId}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="fileName">${cms.requestContext.uri}</c:set>
                        <c:set var="pageId">${cms.locale}-${cms.vfs.readResource[fileName].structureId}</c:set>
                        <c:set var="pageUrl"><%= OpenCms.getLinkManager().getOnlineLink((CmsObject)pageContext.getAttribute("cmsObject"),(String)pageContext.getAttribute("fileName")) %></c:set>
                    </c:otherwise>
                </c:choose>

                <c:if test="${clickToLoad}">
                    <button type="button" class="btn-block btn" onclick="toggleComments();this.blur();">
                        <span class="pull-left"><fmt:message key="apollo.disqus.message.comments" /></span>
                        <i id="disqus_toggle" class="fa fa-chevron-down pull-right"></i>
                    </button>
                </c:if>

                <div id="disqus_thread" <c:if test="${clickToLoad}">style="display: none;"</c:if>></div>
                <script type="text/javascript">

                    var disqus_loaded = false;
                    var disqus_open = false;
                    var disqus_config = function () {
                        this.page.url = '${pageUrl}';  
                        this.page.identifier = '${pageId}';
                    };

                    function loadComments() {
                        var d = document, s = d.createElement('script');
                        s.src = '//${disqusSite}.disqus.com/embed.js';
                        s.setAttribute('data-timestamp', + new Date());
                        (d.head || d.body).appendChild(s);
                    }

                    <c:choose>
                        <c:when test="${clickToLoad}">
                            function toggleComments() {
                                if (disqus_open) {
                                    $("#disqus_toggle").toggleClass("open");
                                    $("#disqus_thread").slideUp();
                                } else {
                                    $("#disqus_toggle").toggleClass("open");
                                    if (!disqus_loaded) {
                                        $("#disqus_thread").show();
                                        disqus_loaded = true;
                                        loadComments();
                                    } else {
                                        $("#disqus_thread").slideDown();
                                    }
                                }
                                disqus_open = !disqus_open;
                            }
                        </c:when>
                        <c:otherwise>
                            loadComments();
                        </c:otherwise>
                    </c:choose>

                </script>
                <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
            </c:otherwise>
        </c:choose>
    </div>
</cms:bundle>