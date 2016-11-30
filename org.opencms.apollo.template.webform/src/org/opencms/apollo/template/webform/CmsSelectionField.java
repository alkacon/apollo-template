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

/**
 * Represents a selection of options.<p>
 */
public class CmsSelectionField extends A_CmsField {

    /** HTML field type: select box. */
    private static final String TYPE = "select";

    /**
     * Returns the type of the input field, e.g. "text" or "select".<p>
     *
     * @return the type of the input field
     */
    public static String getStaticType() {

        return TYPE;
    }

    /**
     * @see org.opencms.apollo.template.webform.I_CmsField#getType()
     */
    @Override
    public String getType() {

        return TYPE;
    }

    /**
     * @see org.opencms.apollo.template.webform.A_CmsField#needsItems()
     */
    @Override
    public boolean needsItems() {

        return true;
    }

}
