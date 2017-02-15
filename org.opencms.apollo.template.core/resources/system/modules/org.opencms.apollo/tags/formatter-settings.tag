<%@ tag
    display-name="formatter-settings"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    import="
    java.util.*,
    org.opencms.main.*,
    org.opencms.file.*,
    org.opencms.util.*,
    org.opencms.jsp.util.*,
    org.opencms.xml.content.*,
    org.opencms.xml.containerpage.*
    "
    description="Reads the default settings from a display formatter and merges these with the parameters from a list formatter."
%>


<%@ attribute name="type" type="java.lang.String" required="true"
    description="Display formatter type selection, taken from the XML content.
    Currently supports only ONE result type / display formatter setting per list." %>

<%@ attribute name="online" type="java.lang.Boolean" required="true"
    description="Must be 'true' if the current project is the Online project." %>

<%@ attribute name="parameters" type="java.util.List" required="false"
    description="Parameter list, usually read from the list formatter.
    Parameters override the default formatter settings." %>

<%@ variable
    name-given="formatterSettings"
    variable-class="java.util.Map"
    scope="AT_END"
    declare="true"
    description="Result Map[String,String] filled with the display formatter default settings,
    merged with the parameters from the list configuration." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${not cms.element.inMemoryOnly}">
    <%!
    // read the formatter bean for the given UUID
    public I_CmsFormatterBean getFormatterBean(CmsUUID structureId, boolean isOnline) {
        return OpenCms
            .getADEManager()
            .getCachedFormatters(isOnline)
            .getFormatters()
            .get(structureId);
    }

    // merge the default display formatter settings with the parameters
    @SuppressWarnings("unchecked")
    public Map<String, String> getFormatterSettings(
            String types,
            Object parameters,
            boolean isOnline) {
        Map<String, String> result = null;
        // get the UUID from the types String
        int p = types.indexOf(':');
        String t = types;
        // also support direct UUID without typename: prefix for testing
        if (p > 0) {
            t = types.substring(p+1);
        }
        CmsUUID uid = new CmsUUID(t);
        // read the formatter configuration
        I_CmsFormatterBean fb = getFormatterBean(uid, isOnline);
        if (fb != null) {
            // iterate all default settings values from the formatter
            result = new HashMap<String, String>();
            for (Map.Entry<String,CmsXmlContentProperty> prop:fb.getSettings().entrySet()) {
                String value = prop.getValue().getDefault();
                if (value != null) {
                    result.put(
                        prop.getKey().trim(),
                        prop.getValue().getDefault().trim());
                }
            }
        }
        if (parameters != null) {
            List<CmsJspContentAccessValueWrapper> list = (List<CmsJspContentAccessValueWrapper>)parameters;
            // merge the parameters from the list configuration over the default settings
            for (CmsJspContentAccessValueWrapper para: list) {
                result.put(
                    para.getValue().get("Key").getStringValue().trim(),
                    para.getValue().get("Value").getStringValue().trim());
            }
        }
        return result;
    }
    %><%
        getJspContext().setAttribute("formatterSettings",
            getFormatterSettings(
                // the display formatter type
                (String)getJspContext().getAttribute("type"),
                // the parameters from the list configuration
                getJspContext().getAttribute("parameters"),
                // indicates if we are in the Online project (true) or not (false)
                ((Boolean)getJspContext().getAttribute("online")).booleanValue()
            )
        );
    %>
</c:if>