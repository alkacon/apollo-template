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
 * Represents an additional text for an input field, with information in which column to show the text.<p>
 */
public class CmsFieldText {

    /** Indicates that the text should be shown in both columns. */
    public static final int COL_BOTH = 0;

    /** Indicates that the text should be shown in the left column. */
    public static final int COL_LEFT = 1;

    /** Indicates that the text should be shown in the right column. */
    public static final int COL_RIGHT = 2;

    /** The text to show below the input field. */
    private String m_text;

    /** The column where to show the text. */
    private int m_column;

    /**
     * Constructor, with parameters.<p>
     *
     * @param text the text to show below the input field
     * @param column the column where to show the text
     */
    public CmsFieldText(String text, int column) {

        m_text = text;
        m_column = column;
        if ((m_column < COL_BOTH) || (m_column > COL_RIGHT)) {
            m_column = COL_BOTH;
        }
    }

    /**
     * Constructor, with parameters.<p>
     *
     * @param text the text to show below the input field
     * @param column the column where to show the text
     */
    public CmsFieldText(String text, String column) {

        m_text = text;
        try {
            m_column = Integer.parseInt(column);
        } catch (Exception e) {
            // ignore
        }
        if ((m_column < COL_BOTH) || (m_column > COL_RIGHT)) {
            m_column = COL_BOTH;
        }
    }

    /**
     * Returns the column where to show the text.<p>
     *
     * @return the column where to show the text
     */
    public int getColumn() {

        return m_column;
    }

    /**
     * Returns the text to show below the input field.<p>
     *
     * @return the text to show below the input field
     */
    public String getText() {

        return m_text;
    }

    /**
     * Returns if the text should be shown in both columns.<p>
     *
     * @return <code>true</code> if the text should be shown in both columns, otherwise <code>false</code>
     */
    public boolean isColumnBoth() {

        return m_column == COL_BOTH;
    }

    /**
     * Returns if the text should be shown in the left column.<p>
     *
     * @return <code>true</code> if the text should be shown in the left column, otherwise <code>false</code>
     */
    public boolean isColumnLeft() {

        return m_column == COL_LEFT;
    }

    /**
     * Returns if the text should be shown in the right column.<p>
     *
     * @return <code>true</code> if the text should be shown in the right column, otherwise <code>false</code>
     */
    public boolean isColumnRight() {

        return m_column == COL_RIGHT;
    }
}
