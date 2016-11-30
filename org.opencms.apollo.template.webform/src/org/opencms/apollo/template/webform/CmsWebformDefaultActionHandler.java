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
import org.opencms.main.CmsLog;

import org.apache.commons.logging.Log;

/**
 * Default action class which is executed after the webform was sent.<p>
 */
public class CmsWebformDefaultActionHandler implements I_CmsWebformActionHandler {

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsWebformDefaultActionHandler.class);

    /**
     * @see org.opencms.apollo.template.webform.I_CmsWebformActionHandler#afterWebformAction(org.opencms.file.CmsObject, org.opencms.apollo.template.webform.CmsFormHandler)
     */
    public void afterWebformAction(CmsObject cmsObject, CmsFormHandler formHandler) {

        if (LOG.isInfoEnabled()) {
            LOG.info("The after webform action is executed successfully.");
        }
    }

    /**
     * @see org.opencms.apollo.template.webform.I_CmsWebformActionHandler#beforeWebformAction(org.opencms.file.CmsObject, org.opencms.apollo.template.webform.CmsFormHandler)
     */
    public String beforeWebformAction(CmsObject cmsObject, CmsFormHandler formHandler) {

        if (LOG.isInfoEnabled()) {
            LOG.info("The before webform action is executed successfully.");
        }
        return null;
    }
}
