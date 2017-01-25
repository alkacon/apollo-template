<%@ tag
    display-name="set-content-disposition"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Sets the response 'Content-Disposition' header." %>


<%@ attribute name="name" type="java.lang.String" required="true"
    description="The filename to set.
    Will be translated according to the OpenCms filename transltation rules.
    All dots '.' will be removed."%>

<%@ attribute name="suffix" type="java.lang.String" required="true"
    description="The suffix to append to the filename.
    Will not be translated or otherwise modified."%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%

    String name = (String)getJspContext().getAttribute("name");
    String suffix = (String)getJspContext().getAttribute("suffix");
    if (name.length() > 0) {
        name = name.replaceAll("[.]","");
        name = org.opencms.main.OpenCms.getResourceManager().getFileTranslator().translateResource(name);
    }
    response.setHeader("Content-Disposition","attachment; filename=" + name + suffix);

%>