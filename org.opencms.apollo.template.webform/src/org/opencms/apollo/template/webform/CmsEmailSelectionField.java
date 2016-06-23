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

/**
 * Selection field which does not send the actual option values to the client, but only their MD5 hashes.
 */
public class CmsEmailSelectionField extends CmsSelectionField implements I_CmsHasHiddenFieldHtml {

    /**
     * Gets the static type.<p>
     * 
     * @return the type 
     */
    public static final String getStaticType() {

        return "email_select";
    }

    /**
     * @see org.opencms.apollo.template.webform.A_CmsField#setValue(java.lang.String)
     */
    @Override
    public void setValue(String value) {

        if (value == null) {
            super.setValue(null);
        } else {
            for (CmsFieldItem item : getItems()) {
                item.setSelected(false);
            }
            for (CmsFieldItem item : getItems()) {
                if (item.getValue().equals(value)) {
                    item.setSelected(true);
                }
            }
            super.setValue(value);
        }
    }

    /**
     * @see org.opencms.apollo.template.webform.A_CmsField#decodeValue(java.lang.String)
     */
    @Override
    public String decodeValue(String value) {

        if (value != null) {
            for (CmsFieldItem item : getItems()) {
                if (value.equals(item.getValueHash())) {
                    return item.getValue();
                }
            }
        }
        return null;
    }

    /**
     * @see org.opencms.apollo.template.webform.CmsSelectionField#getType()
     */
    @Override
    public String getType() {

        return getStaticType();
    }

    /**
     * @see org.opencms.apollo.template.webform.I_CmsHasHiddenFieldHtml#getHiddenFieldHtml()
     */
    public String getHiddenFieldHtml() {

        StringBuffer result = new StringBuffer();
        result.append("<input type=\"hidden\" name=\"");
        result.append(getName());
        result.append("\" value=\"");
        result.append(CmsFieldItem.getHash(getValue()));
        result.append("\" />\n");
        return result.toString();

    }
}
