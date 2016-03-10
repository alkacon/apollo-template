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

import org.opencms.util.CmsHtmlParser;
import org.opencms.util.CmsStringUtil;

import java.util.Iterator;
import java.util.List;

import org.htmlparser.Tag;
import org.htmlparser.Text;
import org.htmlparser.util.Translate;

/**
 * Removes HTML tags and replaces them by line breaks or blanks.<p>
 */
public class CmsHtmlToTextConverter extends CmsHtmlParser {

    /** Indicated to append or store the next line breaks. */
    private boolean m_appendBr;

    /** The last appended line break count. */
    private int m_brCount;

    /** The current indentation. */
    private int m_indent;

    /** The current line length. */
    private int m_lineLength;

    /** The marker String (for headlines, bullets etc.). */
    private String m_marker;

    /** The maximum line length. */
    private int m_maxLineLength;

    /** The last stored, but not appended line break count. */
    private int m_storedBrCount;

    /** Indicates if blanks should be added instead of line breaks. */
    private boolean m_useBlankForLinebreak;

    /**
     * Creates a new instance of the html converter.<p>
     */
    public CmsHtmlToTextConverter() {

        m_result = new StringBuffer(512);
        m_maxLineLength = 100;
    }

    /**
     * Extracts the text from the given html content, assuming the given html encoding.<p>
     *
     * @param html the content to extract the plain text from
     * @param encoding the encoding to use
     *
     * @return the text extracted from the given html content
     *
     * @throws Exception if something goes wrong
     */
    public static String htmlToText(String html, String encoding) throws Exception {

        // create the converter instance
        CmsHtmlToTextConverter visitor = new CmsHtmlToTextConverter();
        return visitor.process(html, encoding);
    }

    /**
     * Extracts the text from the given html content, assuming the given html encoding.<p>
     *
     * @param html the content to extract the plain text from
     * @param encoding the encoding to use
     * @param useBlankForLinebreak indicates if blanks should be added instead of line breaks
     *
     * @return the text extracted from the given html content
     *
     * @throws Exception if something goes wrong
     */
    public static String htmlToText(String html, String encoding, boolean useBlankForLinebreak) throws Exception {

        // create the converter instance
        CmsHtmlToTextConverter visitor = new CmsHtmlToTextConverter();
        visitor.setUseBlankForLinebreak(useBlankForLinebreak);
        return visitor.process(html, encoding);
    }

    /**
     * @see org.htmlparser.visitors.NodeVisitor#visitEndTag(org.htmlparser.Tag)
     */
    @Override
    public void visitEndTag(Tag tag) {

        m_appendBr = false;
        appendLinebreaks(tag, false);
    }

    /**
     * @see org.htmlparser.visitors.NodeVisitor#visitStringNode(org.htmlparser.Text)
     */
    @Override
    public void visitStringNode(Text text) {

        appendText(text.toPlainTextString());
    }

    /**
     * @see org.htmlparser.visitors.NodeVisitor#visitTag(org.htmlparser.Tag)
     */
    @Override
    public void visitTag(Tag tag) {

        m_appendBr = true;
        appendLinebreaks(tag, true);
    }

    /**
     * Sets if blanks should be added instead of line breaks.<p>
     *
     * @param useBlankForLinebreak <code>true</code> if blanks should be added instead of line breaks
     */
    protected void setUseBlankForLinebreak(boolean useBlankForLinebreak) {

        m_useBlankForLinebreak = useBlankForLinebreak;
    }

    /**
     * Appends an indentation to the result.<p>
     */
    private void appendIndentation() {

        if (m_lineLength <= m_indent) {
            int len = (m_marker != null) ? m_indent - (m_marker.length() + 1) : m_indent;
            for (int i = 0; i < len; i++) {
                m_result.append(' ');
            }
            if (m_marker != null) {
                m_result.append(m_marker);
                m_result.append(' ');
                m_marker = null;
            }
        }
    }

    /**
     * Appends line breaks to the result.<p>
     *
     * @param count the number of line breaks to append
     */
    private void appendLinebreak(int count) {

        appendLinebreak(count, false);
    }

    /**
     * Appends line breaks to the result.<p>
     *
     * @param count the number of line breaks to append
     * @param force if the number of line breaks should be forced
     */
    private void appendLinebreak(int count, boolean force) {

        if (m_appendBr) {
            if (m_storedBrCount > count) {
                count = m_storedBrCount;
            }
            m_storedBrCount = 0;
            if (force) {
                m_brCount = 0;
            }
            String brStr = "\r\n";
            if (m_useBlankForLinebreak) {
                brStr = " ";
            }
            while (m_brCount < count) {
                m_result.append(brStr);
                m_brCount++;
            }
            m_lineLength = m_indent;
        } else {
            while (m_storedBrCount < count) {
                m_storedBrCount++;
            }
        }
    }

    /**
     * Appends line breaks using the specified tag.<p>
     *
     * @param tag the tag name
     * @param open the open flag
     */
    private void appendLinebreaks(Tag tag, boolean open) {

        String name = tag.getTagName();
        int pos = TAG_LIST.indexOf(name);

        switch (pos) {
            case 0: // H1
            case 1: // H2
            case 2: // H3
            case 3: // H4
            case 4: // H5
            case 5: // H6
                appendLinebreak(2);
                break;
            case 6: // P
            case 7: // DIV
                appendLinebreak(2);
                break;
            case 8: // SPAN
                break;
            case 9: // BR
                appendLinebreak(1, true);
                break;
            case 10: // OL
            case 11: // UL
                appendLinebreak(2);
                break;
            case 12: // LI
                setMarker("*", open);
                setIndentation(5, open);
                appendLinebreak(1);
                break;
            case 13: // TABLE
                setIndentation(5, open);
                appendLinebreak(2);
                if (open) {
                    appendLinebreak(1);
                    appendText("-----");
                    appendLinebreak(1);
                }
                break;
            case 14: // TD
                setMarker("--", open);
                appendLinebreak(2);
                break;
            case 15: // TR
                if (!open) {
                    appendLinebreak(1);
                    appendText("-----");
                    appendLinebreak(1);
                }
                break;
            case 16: // TH
            case 17: // THEAD
            case 18: // TBODY
            case 19: // TFOOT
                appendLinebreak(1);
                break;
            default: // unknown tag (ignore)
        }
    }

    /**
     * Appends text.<p>
     *
     * @param text the text
     */
    private void appendText(String text) {

        if (CmsStringUtil.isNotEmptyOrWhitespaceOnly(text)) {
            text = Translate.decode(text);
            text = collapse(text);
        }
        if (CmsStringUtil.isNotEmptyOrWhitespaceOnly(text)) {

            if (m_storedBrCount > 0) {
                m_appendBr = true;
                appendLinebreak(m_storedBrCount);
            }
            appendIndentation();
            m_brCount = 0;

            List<String> wordList = CmsStringUtil.splitAsList(text, ' ');
            Iterator<String> i = wordList.iterator();
            while (i.hasNext()) {
                String word = i.next();
                boolean hasNbsp = ((word.charAt(0) == 160) || (word.charAt(word.length() - 1) == 160));
                if ((word.length() + 1 + m_lineLength) > m_maxLineLength) {
                    m_appendBr = true;
                    appendLinebreak(1);
                    appendIndentation();
                    m_brCount = 0;
                } else {
                    if (!hasNbsp
                        && (m_lineLength > m_indent)
                        && (m_result.charAt(m_result.length() - 1) != 160)
                        && (m_result.charAt(m_result.length() - 1) != 32)) {

                        m_result.append(' ');
                        m_lineLength++;
                    }
                }
                m_result.append(word);
                m_lineLength += word.length();
            }
        }
    }

    /**
     * Sets the indentation.<p>
     *
     * @param length the indentation length
     * @param open if the indentation should be increased or reduced
     */
    private void setIndentation(int length, boolean open) {

        if (open) {
            m_indent += length;
        } else {
            m_indent -= length;
            if (m_indent < 0) {
                m_indent = 0;
            }
        }
    }

    /**
     * Sets a marker.<p>
     *
     * @param marker the marker
     * @param open if the marker should be set
     */
    private void setMarker(String marker, boolean open) {

        if (open) {
            m_marker = marker;
        }
    }

}
