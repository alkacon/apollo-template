/*
 * This program is part of the OpenCms Apollo Template.
 *
 * Copyright (c) Alkacon Software GmbH & Co. KG (http://www.alkacon.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package org.opencms.apollo.template.webform;

import org.opencms.file.CmsObject;
import org.opencms.xml.content.CmsXmlContent;
import org.opencms.xml.types.I_CmsXmlContentValue;

import java.util.List;
import java.util.Locale;

/**
 * Utility class for accessing form content elements.<p>
 */
public final class CmsFormContentUtil {

    /** Node name for a nested form. */
    public static final String NODE_NESTED_FORM = "Form";

    /**
     * Hidden constructor.<p>
     */
    private CmsFormContentUtil() {

        // noop
    }

    /**
     * Returns a content value from the given content, but from a nested path if a NODE_NESTED_FORM node
     * is present.<p>
     *
     * @param content the XML content
     * @param cms the CmsObject to be used for VFS operations
     * @param path the path of the content value
     * @param locale the locale to use
     * @return the content value from the given path, or a nested path if the NODE_NESTED_FORM content value is present.
     */
    public static String getContentStringValue(CmsXmlContent content, CmsObject cms, String path, Locale locale) {

        return content.getStringValue(cms, getNestedPathPrefix(content, NODE_NESTED_FORM, locale) + path, locale);
    }

    /**
     * Returns a content value from the given content, but from a nested path if a NODE_NESTED_FORM node is
     * present.<p>
     *
     * @param content the XML content
     * @param path the path of the content value
     * @param locale the locale to use
     * @return the content value from a given path, or a nested path if the NODE_NESTED_FORM content value is present.
     */
    public static I_CmsXmlContentValue getContentValue(CmsXmlContent content, String path, Locale locale) {

        return content.getValue(getNestedPathPrefix(content, NODE_NESTED_FORM, locale) + path, locale);
    }

    /**
     * Returns a list of content values from the given content, but from a nested path if a NODE_NESTED_FORM node
     * is present.<p>
     *
     * @param content
     * @param path
     * @param locale
     * @return a list of content values from the given content
     */
    public static List<I_CmsXmlContentValue> getContentValues(CmsXmlContent content, String path, Locale locale) {

        return content.getValues(getNestedPathPrefix(content, NODE_NESTED_FORM, locale) + path, locale);
    }

    /**
     * Creates an xpath prefix which is either empty or consists of a given parent node path, depending on
     * whether the parent node path exists in the XML content.<p>
     *
     * @param content the XML content
     * @param parentNode the parent node path
     * @param locale the locale to use
     * @return the path prefix (either the empty string or parentNode + "/")
     */
    public static String getNestedPathPrefix(CmsXmlContent content, String parentNode, Locale locale) {

        if (content.hasValue(parentNode, locale)) {
            return parentNode + "/";
        }
        return "";
    }

}
