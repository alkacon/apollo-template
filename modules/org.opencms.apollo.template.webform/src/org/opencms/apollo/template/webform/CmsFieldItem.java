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

import org.opencms.util.CmsStringUtil;

/**
 * Represents a single input field item object.<p>
 *
 * This object is needed to create checkboxes, radio buttons, selectboxes and table fields
 * and represents an item for these types.<p>
 */
public class CmsFieldItem {

    /** The label of the item in the database. */
    private String m_dbLabel;

    /** A flag indicating if the item is selected. */
    private boolean m_isSelected;

    /** The label of the item. */
    private String m_label;

    /** The optional item name. */
    private String m_name;

    /** The flag indicating if the items should be shown in one row. */
    private boolean m_showInRow;

    /** The value of the item. */
    private String m_value;

    /**
     * Empty constructor creates an empty field item.<p>
     */
    public CmsFieldItem() {

        m_label = "";
        m_value = "";
    }

    /**
     * Constructor that creates an initialized field item.<p>
     *
     * @param value the value of the field item
     * @param label the label of the field item
     * @param isSelected true if the current item is selected, otherwise false
     * @param showInRow true if the items should be shown in a row, otherwise false
     */
    public CmsFieldItem(String value, String label, boolean isSelected, boolean showInRow) {

        m_label = label;
        m_dbLabel = label;
        m_isSelected = isSelected;
        m_value = value;
        m_showInRow = showInRow;
    }

    /**
     * Constructor that creates an initialized field item.<p>
     *
     * @param value the value of the field item
     * @param label the label of the field item
     * @param dblabel if the label for the database (only use for {@link CmsTableField})
     * @param isSelected true if the current item is selected, otherwise false
     * @param showInRow true if the items should be shown in a row, otherwise false
     */
    public CmsFieldItem(String value, String label, String dblabel, boolean isSelected, boolean showInRow) {

        m_label = label;
        m_dbLabel = dblabel;
        m_isSelected = isSelected;
        m_value = value;
        m_showInRow = showInRow;
    }

    /**
     * Returns the dbLabel.<p>
     *
     * @return the dbLabel
     */
    public String getDbLabel() {

        return m_dbLabel;
    }

    /**
     * Returns the label text of the field item.<p>
     *
     * @return the label text of the field item
     */
    public String getLabel() {

        return m_label;
    }

    /**
     * Returns the optional name of the field item.<p>
     *
     * This is used by the special table field type {@link CmsTableField}.<p>
     *
     * @return the optional name of the field item
     */
    public String getName() {

        return m_name;
    }

    /**
     * Returns the value of the field item.<p>
     *
     * @return the value of the field item
     */
    public String getValue() {

        return m_value;
    }

    /**
     * Returns the escaped value of the field, or <code>null</code> if the value is empty.<p>
     *
     * This is necessary to avoid XSS or other exploits on the webform output pages.<p>
     *
     * @return the escaped value of the field
     */
    public String getValueEscaped() {

        if (CmsStringUtil.isEmptyOrWhitespaceOnly(getValue())) {
            return null;
        }
        return CmsStringUtil.escapeHtml(getValue());
    }

    /**
     * Returns if the current item is selected or not.<p>
     *
     * @return true if the current item is selected, otherwise false
     */
    public boolean isSelected() {

        return m_isSelected;
    }

    /**
     * Returns if the items should be shown in a row.<p>
     *
     * @return true if the items should be shown in a row, otherwise false
     */
    public boolean isShowInRow() {

        return m_showInRow;
    }

    /**
     * Sets the dbLabel.<p>
     *
     * @param dbLabel the dbLabel to set
     */
    public void setDbLabel(String dbLabel) {

        m_dbLabel = dbLabel;
    }

    /**
     * Sets if the items should be shown in a row.<p>
     *
     * @param showInRow the flag indicating if the items should be shown in a row
     */
    public void setShowInRow(boolean showInRow) {

        m_showInRow = showInRow;
    }

    /**
     * Sets the label text of the field item.<p>
     *
     * @param label the description text of the field item
     */
    protected void setLabel(String label) {

        m_label = label;
    }

    /**
     * Sets the name of the field item.<p>
     *
     * @param name the name of the field item
     */
    protected void setName(String name) {

        m_name = name;
    }

    /**
     * Sets if the current item is selected or not.<p>
     *
     * @param isSelected true if the current item is selected, otherwise false
     */
    protected void setSelected(boolean isSelected) {

        m_isSelected = isSelected;
    }

    /**
     * Sets the value of the field item.<p>
     *
     * @param value the value of the field item
     */
    protected void setValue(String value) {

        m_value = value;
    }
}
