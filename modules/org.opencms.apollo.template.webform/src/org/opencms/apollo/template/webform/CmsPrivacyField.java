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

import org.opencms.i18n.CmsMessages;
import org.opencms.util.CmsStringUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * Represents a confirmation check box with a link.<p>
 */
public class CmsPrivacyField extends CmsCheckboxField {

    /** HTML field type: checkbox. */
    private static final String TYPE = "privacy";

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

        String fieldLabel = getLabel();
        String errorMessage = null;
        String mandatory = "";
        boolean showMandatoryLabel = false;

        if (CmsStringUtil.isNotEmpty(errorKey)) {
            if (CmsFormHandler.ERROR_MANDATORY.equals(errorKey)) {
                errorMessage = messages.key("form.error.mandatory");
            } else if (CmsStringUtil.isNotEmpty(getErrorMessage())) {
                errorMessage = getErrorMessage();
            } else {
                errorMessage = messages.key("form.error.validation");
            }
        }

        if (isMandatory() && showMandatory) {
            mandatory = messages.key("form.html.mandatory");
        }
        // show the text with the mandatory marker, if exists
        if (CmsStringUtil.isNotEmptyOrWhitespaceOnly(fieldLabel)) {
            fieldLabel = fieldLabel + mandatory;
            showMandatoryLabel = true;
        } else {
            fieldLabel = "&nbsp;";
        }

        Map<String, Object> stAttributes = new HashMap<String, Object>();
        // set special label as additional attribute
        stAttributes.put("label", fieldLabel);

        // set the item values
        if (getItems().size() > 0) {
            CmsFieldItem curOption = getItems().get(0);
            //check if an internal link should be generated
            String link = curOption.getLabel();
            if (link.startsWith("/")) {
                link = formHandler.link(link);
            }
            // set link and link text as additional attributes
            stAttributes.put("link", link);
            stAttributes.put("linktext", curOption.getValue() + (showMandatoryLabel ? "" : mandatory));
        }

        return createHtml(formHandler, messages, stAttributes, getType(), null, errorMessage, showMandatory);
    }

    /**
     * @see org.opencms.apollo.template.webform.I_CmsField#getType()
     */
    @Override
    public String getType() {

        return TYPE;
    }

    /**
     * @see org.opencms.apollo.template.webform.A_CmsField#toString()
     */
    @Override
    public String toString() {

        return getValue();
    }

}
