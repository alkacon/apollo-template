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

import org.opencms.i18n.A_CmsMessageBundle;
import org.opencms.i18n.I_CmsMessageBundle;

/**
 * Convenience class to access the localized messages of this OpenCms package.<p>
 */
public final class Messages extends A_CmsMessageBundle {

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERROR_DECRPYT_0 = "LOG_ERROR_DECRPYT_0";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERROR_ENCRYPT_0 = "LOG_ERROR_ENCRYPT_0";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERROR_CREATE_KEY_0 = "LOG_ERROR_CREATE_KEY_0";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_WARN_INVALID_DECRYPT_STRING_1 = "LOG_WARN_INVALID_DECRYPT_STRING_1";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_WARN_INVALID_ENCRYPT_STRING_1 = "LOG_WARN_INVALID_ENCRYPT_STRING_1";

    /** Message constant for key in the resource bundle. */
    public static final String DEBUG_CAPTCHA_ADD_FONT_1 = "DEBUG_CAPTCHA_ADD_FONT_1";

    /** Message constant for key in the resource bundle. */
    public static final String DEBUG_CAPTCHA_FONT_FILTERING_FINISH_1 = "DEBUG_CAPTCHA_FONT_FILTERING_FINISH_1";

    /** Message constant for key in the resource bundle. */
    public static final String DEBUG_CAPTCHA_FONT_FILTERING_START_0 = "DEBUG_CAPTCHA_FONT_FILTERING_START_0";

    /** Message constant for key in the resource bundle. */
    public static final String DEBUG_CAPTCHA_USE_FONT_0 = "DEBUG_CAPTCHA_USE_FONT_0";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_INIT_INPUT_FIELD_MISSING_ITEM_2 = "ERR_INIT_INPUT_FIELD_MISSING_ITEM_2";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_INIT_TABLE_FIELD_UNEQUAL_0 = "ERR_INIT_TABLE_FIELD_UNEQUAL_0";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_INIT_TABLE_FIELD_UNIQUE_1 = "ERR_INIT_TABLE_FIELD_UNIQUE_1";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_REPORT_NO_FORM_URI_0 = "ERR_REPORT_NO_FORM_URI_0";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_2 = "ERR_SELECTWIDGET_CONFIGURATION_2";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_FIND_2 = "ERR_SELECTWIDGET_CONFIGURATION_FIND_2";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_KEY_DUPLICATE_2 = "ERR_SELECTWIDGET_CONFIGURATION_KEY_DUPLICATE_2";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_KEY_MISSING_3 = "ERR_SELECTWIDGET_CONFIGURATION_KEY_MISSING_3";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_KEY_UNKNOWN_2 = "ERR_SELECTWIDGET_CONFIGURATION_KEY_UNKNOWN_2";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_KEYVALUE_LENGTH_1 = "ERR_SELECTWIDGET_CONFIGURATION_KEYVALUE_LENGTH_1";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_READ_1 = "ERR_SELECTWIDGET_CONFIGURATION_READ_1";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_RESOURCE_INVALID_2 = "ERR_SELECTWIDGET_CONFIGURATION_RESOURCE_INVALID_2";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_CONFIGURATION_RESOURCE_NOFOLDER_2 = "ERR_SELECTWIDGET_CONFIGURATION_RESOURCE_NOFOLDER_2";

    /** Message constant for key in the resource bundle. */
    public static final String ERR_SELECTWIDGET_INTERNAL_CONFIGURATION_2 = "ERR_SELECTWIDGET_INTERNAL_CONFIGURATION_2";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERR_CAPTCHA_CONFIG_IMAGE_SIZE_2 = "LOG_ERR_CAPTCHA_CONFIG_IMAGE_SIZE_2";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERR_FIELD_INSTANTIATION_1 = "LOG_ERR_FIELD_INSTANTIATION_1";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERR_PATTERN_SYNTAX_0 = "LOG_ERR_PATTERN_SYNTAX_0";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERR_READING_CUSTOM_FORM_FIELD_PROPERTIES_1 = "LOG_ERR_READING_CUSTOM_FORM_FIELD_PROPERTIES_1";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERR_SELECTWIDGET_NO_RESOURCES_FOUND_3 = "LOG_ERR_SELECTWIDGET_NO_RESOURCES_FOUND_3";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERR_SELECTWIDGET_XPATH_INVALID_4 = "LOG_ERR_SELECTWIDGET_XPATH_INVALID_4";

    /** Message constant for key in the resource bundle. */
    public static final String LOG_ERR_TABLEFIELD_REPLACE_0 = "LOG_ERR_TABLEFIELD_REPLACE_0";

    /** Message constant for key in the resource bundle. */
    public static final String PARAMETER_FIELD_SELECTBOX = "PARAMETER_FIELD_SELECTBOX";

    /** Name of the used resource bundle. */
    private static final String BUNDLE_NAME = "com.alkacon.opencms.v8.formgenerator.messages";

    /** Static instance member. */
    private static final I_CmsMessageBundle INSTANCE = new Messages();

    /**
     * Hides the public constructor for this utility class.<p>
     */
    private Messages() {

        // hide the constructor
    }

    /**
     * Returns an instance of this localized message accessor.<p>
     *
     * @return an instance of this localized message accessor
     */
    public static I_CmsMessageBundle get() {

        return INSTANCE;
    }

    /**
     * Returns the bundle name for this OpenCms package.<p>
     *
     * @return the bundle name for this OpenCms package
     */
    @Override
    public String getBundleName() {

        return BUNDLE_NAME;
    }
}