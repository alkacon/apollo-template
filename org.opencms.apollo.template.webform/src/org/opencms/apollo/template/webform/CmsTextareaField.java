/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) Alkacon Software GmbH (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package org.opencms.apollo.template.webform;

import org.opencms.i18n.CmsEncoder;
import org.opencms.i18n.CmsMessages;
import org.opencms.util.CmsStringUtil;
import org.opencms.util.I_CmsMacroResolver;

/**
 * Represents a text area.<p>
 */
public class CmsTextareaField extends A_CmsField {

    /** HTML field type: text area. */
    private static final String TYPE = "textarea";

    /**
     * Returns the type of the input field, e.g. "text" or "select".<p>
     *
     * @return the type of the input field
     */
    public static String getStaticType() {

        return TYPE;
    }

    /**
     * @see org.opencms.apollo.template.webform.I_CmsField#buildHtml(CmsFormHandler, CmsMessages, String, boolean, String)
     */
    @Override
    public String buildHtml(
        CmsFormHandler formHandler,
        CmsMessages messages,
        String errorKey,
        boolean showMandatory,
        String infoKey) {

        String errorMessage = createStandardErrorMessage(errorKey, messages);
        String attributes = null;

        if (CmsStringUtil.isNotEmpty(errorKey)
            && !CmsFormHandler.ERROR_MANDATORY.equals(errorKey)
            && CmsStringUtil.isNotEmpty(getErrorMessage())
            && (getErrorMessage().indexOf(I_CmsMacroResolver.MACRO_DELIMITER) == 0)) {
            // there are additional field attributes defined in the error message of the field
            attributes = " " + getErrorMessage().substring(2, getErrorMessage().length() - 1);
            errorMessage = null;
        }

        String result = createHtml(formHandler, messages, null, getType(), attributes, errorMessage, showMandatory);
        // sets the cell numbers for the place holders in two column layout
        incrementPlaceholder(messages.key("form.html.multiline.placeholder"));
        return result;
    }

    /**
     * @see org.opencms.apollo.template.webform.I_CmsField#getType()
     */
    @Override
    public String getType() {

        return TYPE;
    }

    /**
     * Returns the XML escaped value of the field.<p>
     *
     * @see org.opencms.apollo.template.webform.A_CmsField#getValueEscaped()
     */
    @Override
    public String getValueEscaped() {

        return CmsEncoder.escapeXml(getValue());
    }

}
