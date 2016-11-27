<%@ tag 
    display-name="obfuscate"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    import="java.nio.charset.Charset"
    description="
        Obfuscates an Email address (or any other String).
        The Sting that can be revelad using the JavaScript function 'unobfuscateString()'." %>

<%@ attribute name="text" type="java.lang.String" required="true" 
    description="The String to obfuscate." %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%!
// Java method to obfuscate the Email.
// The obfucated email can be revealed using the JavaScript function 'unobfuscateString()'.
public String obfuscateContactEmail(String email) {
    StringBuilder encoded = new StringBuilder(email.length() * 6);
    // sort the input in reverse order
    email = new StringBuffer(email).reverse().toString();
    byte[] bytes = email.getBytes(Charset.forName("UTF-8"));
    for (int j = 0; j < bytes.length; j++) {
        String hex = String.format("%02X", bytes[j]);
        if (hex.equals("40")) hex = "7b;53;43;52;41;4d;42;4c;45;7d"; // the @ symbol
        if (hex.equals("2e")) hex = "5b;53;43;52;41;4d;42;4c;45;5d"; // the . symbol
        encoded.append(hex + ";");
    }
    return encoded.toString();
}
%>

<%= obfuscateContactEmail((String)getJspContext().getAttribute("text")) %>