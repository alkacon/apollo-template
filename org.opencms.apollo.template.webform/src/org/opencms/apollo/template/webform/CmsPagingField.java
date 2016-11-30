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

import org.opencms.i18n.CmsEncoder;
import org.opencms.i18n.CmsMessages;
import org.opencms.util.CmsStringUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Represents a new page field.<p>
 *
 */
public class CmsPagingField extends A_CmsField {

    /** HTML field type: hidden field. */
    private static final String TYPE = "paging";

    /**
     * Appends the input field values from last pages as hidden values.<p>
     *
     * @param formHandler the form handler
     * @param messages the message bundle
     * @param position the position of the paging field
     *
     * @return the input field values from last pages as hidden values.
     */
    public static StringBuffer appendHiddenFields(CmsFormHandler formHandler, CmsMessages messages, int position) {

        StringBuffer buf = new StringBuffer(512);

        // loop through all form input field before that paging field, otherwise there are doubled parameter values
        // as input fields and hidden fields, for example if there are invalid inputs
        List<I_CmsField> fields = formHandler.getFormConfiguration().getFields();
        int page = CmsPagingField.getPageFromField(formHandler, position);
        for (int i = 0, n = fields.size(); i < n; i++) {
            // loop through all form input fields which are NOT in the current page
            I_CmsField field = fields.get(i);
            int fieldPage = CmsPagingField.getPageFromField(formHandler, i + 1);
            if ((fieldPage != page) || (field instanceof CmsFileUploadField)) {
                buf.append(createHiddenField(field));
                if (field.hasCurrentSubFields()) {
                    // check the sub fields of the field
                    Iterator<I_CmsField> it = field.getCurrentSubFields().iterator();
                    while (it.hasNext()) {
                        I_CmsField subField = it.next();
                        buf.append(createHiddenField(subField));
                    }
                }
            }
            if ((fieldPage != page) && (field instanceof CmsParameterField)) {
                buf.append(CmsParameterField.createHiddenFields(formHandler.getParameterMap(), field.getParameters()));
            }
        }

        return buf;
    }

    /**
    * Appends the input field values from last pages as hidden values.<p>
    *
    * @param formHandler the form handler
    * @param messages the message bundle
    *
    * @return the input field values from last pages as hidden values.
    */
    public static StringBuffer appendHiddenUploadFields(CmsFormHandler formHandler, CmsMessages messages) {

        StringBuffer buf = new StringBuffer(512);

        // loop through all form input field before that paging field, otherwise there are doubled parameter values
        // as input fields and hidden fields, for example if there are invalid inputs
        List<I_CmsField> fields = formHandler.getFormConfiguration().getFields();
        for (int i = 0, n = fields.size(); i < n; i++) {
            // loop through all form file upload fields
            I_CmsField field = fields.get(i);
            if (field instanceof CmsFileUploadField) {
                buf.append(createHiddenField(field));
                if (field.hasCurrentSubFields()) {
                    // check the sub fields of the field
                    Iterator<I_CmsField> it = field.getCurrentSubFields().iterator();
                    while (it.hasNext()) {
                        I_CmsField subField = it.next();
                        buf.append(createHiddenField(subField));
                    }
                }
            }
        }

        return buf;
    }

    /**
     * Returns the first input field position from the current page.<p>
     *
     * @param formHandler the form handler
     * @param page the current page
     *
     * @return the first input field position from the current page
     */
    public static int getFirstFieldPosFromPage(CmsFormHandler formHandler, int page) {

        // the first input field position from the current page
        int firstField = 0;
        // initialize the fields list
        List<Integer> pFields = CmsPagingField.initializeFields(formHandler);
        // get the first field
        if (page == 1) {
            firstField = 0;
        } else {
            firstField = (pFields.get(page - 2)).intValue() + 1;
        }
        return firstField;
    }

    /**
     * Returns the last input field position from the current page.<p>
     *
     * @param formHandler the form handler
     * @param page the current page
     *
     * @return the last input field position from the current page
     */
    public static int getLastFieldPosFromPage(CmsFormHandler formHandler, int page) {

        // the last input field position from the current page
        int lastField = 0;
        // initialize the fields list
        List<Integer> pFields = CmsPagingField.initializeFields(formHandler);
        // get the last field
        lastField = (pFields.get(page - 1)).intValue();
        return lastField;
    }

    /**
     * Returns the next page.<p>
     *
     * @param page the next page
     *
     * @return the next page
     */
    public static int getNextPage(int page) {

        return page + 1;
    }

    /**
     * Returns the previous page.<p>
     *
     * @param page the current page
     *
     * @return the previous page
     */
    public static int getPreviousPage(int page) {

        if (page == 1) {
            return 1;
        } else {
            return page - 1;
        }
    }

    /**
     * Returns the type of the input field, e.g. "text" or "select".<p>
     *
     * @return the type of the input field
     */
    public static String getStaticType() {

        return TYPE;
    }

    /**
     * Returns the HTML of a hidden field storing the field value.<p>
     *
     * @param field the input field to create a hidden field from
     *
     * @return the HTML of a hidden field storing the field value
     */
    private static StringBuffer createHiddenField(I_CmsField field) {

        StringBuffer buf = new StringBuffer(96);

        if (field.needsItems()) {
            if (field instanceof CmsTableField) {
                List<List<CmsFieldItem>> rwItems = ((CmsTableField)field).getRowsWithItems();
                Iterator<List<CmsFieldItem>> iter1 = rwItems.iterator();
                while (iter1.hasNext()) {
                    List<CmsFieldItem> items = iter1.next();
                    Iterator<CmsFieldItem> iter2 = items.iterator();
                    while (iter2.hasNext()) {
                        CmsFieldItem currItem = iter2.next();
                        // only create hidden fields for not empty values
                        if (CmsStringUtil.isNotEmpty(currItem.getValue())) {
                            // put the current value in a hidden field
                            buf.append("<input type=\"hidden\" name=\"").append(currItem.getName()).append(
                                "\" value=\"").append(CmsEncoder.escapeXml(currItem.getValue())).append("\" />").append(
                                    "\n");
                        }
                    }
                }

            } else {
                // specific handling for check boxes, radio buttons and select boxes: get the items of this field
                List<CmsFieldItem> items = ((A_CmsField)field).getSelectedItems();
                Iterator<CmsFieldItem> iter = items.iterator();
                while (iter.hasNext()) {
                    CmsFieldItem currItem = iter.next();
                    // only create hidden fields for not empty values
                    if (CmsStringUtil.isNotEmpty(currItem.getValue())) {
                        // put the current value in a hidden field
                        buf.append("<input type=\"hidden\" name=\"").append(field.getName()).append(
                            "\" value=\"").append(CmsEncoder.escapeXml(currItem.getValue())).append("\" />").append(
                                "\n");
                    }
                }
            }
        } else {
            // only create hidden fields for not empty values
            if (CmsStringUtil.isNotEmpty(field.getValue())) {
                // put the current value in a hidden field
                buf.append("<input type=\"hidden\" name=\"").append(field.getName()).append("\" value=\"").append(
                    CmsEncoder.escapeXml(field.getValue())).append("\" />").append("\n");
            }
        }

        return buf;
    }

    /**
     * Gets the page to the current field.<p>
     *
     * @param formHandler the form handler
     * @param fieldNr the current field number
     *
     * @return the page to the current field
     */
    private static int getPageFromField(CmsFormHandler formHandler, int fieldNr) {

        // the current page
        int page = 1;
        // the current field
        fieldNr -= 1;
        // the paging position from the last page
        int previousPos = -2;
        // initialize the fields list
        List<Integer> pFields = CmsPagingField.initializeFields(formHandler);
        // loop over the fields list
        Iterator<Integer> iter = pFields.iterator();
        while (iter.hasNext()) {
            int pos = (iter.next()).intValue();
            if ((fieldNr > previousPos) && (fieldNr <= pos)) {
                return page;
            }
            page += 1;
            previousPos = pos;
        }
        return page;
    }

    /**
     * Initialize the fields.<p>
     *
     * @param formHandler the form handler
     *
     * @return the initialized fields
     */
    private static List<Integer> initializeFields(CmsFormHandler formHandler) {

        // get the positions of all paging fields
        List<Integer> pfields = new ArrayList<Integer>();
        CmsForm formConfiguration = formHandler.getFormConfiguration();
        List<I_CmsField> fields = formConfiguration.getFields();
        for (int pos = 0, n = fields.size(); pos < n; pos++) {
            // loop through all form input fields
            I_CmsField field = fields.get(pos);
            // only use the paging fields
            if (field instanceof CmsPagingField) {
                pfields.add(new Integer(pos));
            }
        }
        // add the last element as end element
        pfields.add(new Integer(fields.size() - 1));
        return pfields;
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

        Map<String, Object> stAttributes = new HashMap<String, Object>();
        // set hidden fields as additional attribute
        stAttributes.put("hiddenfields", appendHiddenFields(formHandler, messages, getFieldNr()).toString());
        String prevButton = null;
        if (isNotFirstPage(CmsPagingField.getPageFromField(formHandler, getFieldNr()))) {
            prevButton = messages.key("form.button.prev");
        }
        // set previous and next button labels (if visible)
        stAttributes.put("prevbutton", prevButton);
        stAttributes.put("nextbutton", messages.key("form.button.next"));
        // set current form page
        stAttributes.put("page", new Integer(CmsPagingField.getPageFromField(formHandler, getFieldNr())));

        return createHtml(formHandler, messages, stAttributes, getType(), null, null, showMandatory);
    }

    /**
     * @see org.opencms.apollo.template.webform.I_CmsField#getType()
     */
    @Override
    public String getType() {

        return TYPE;
    }

    /**
     * Returns false, if the page is the first page, otherwise true.<p>
     *
     * @param page the current page
     *
     * @return false, if the page is the first page, otherwise true.
     */
    private boolean isNotFirstPage(int page) {

        if (page == 1) {
            return false;
        }
        return true;
    }
}
