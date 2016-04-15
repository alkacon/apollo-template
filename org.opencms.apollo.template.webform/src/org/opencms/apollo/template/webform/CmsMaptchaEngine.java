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

import com.octo.captcha.CaptchaFactory;
import com.octo.captcha.engine.CaptchaEngineException;
import com.octo.captcha.engine.GenericCaptchaEngine;

/**
 * A captcha engine using a Maptcha factory to create mathematical captchas.<p>
 */
public class CmsMaptchaEngine extends GenericCaptchaEngine {

    /** The configured mathematical captcha factory. */
    private CmsMaptchaFactory m_factory;

    /**
     * Creates a new Maptcha engine.<p>
     *
     * @param captchaSettings the settings to create mathematical captchas
     */
    public CmsMaptchaEngine(CmsCaptchaSettings captchaSettings) {

        super(new CaptchaFactory[] {new CmsMaptchaFactory()});
        initMathFactory();
    }

    /**
     * Returns the hardcoded factory (array of length 1) that is used.<p>
     *
     * @return the hardcoded factory (array of length 1) that is used
     *
     * @see com.octo.captcha.engine.CaptchaEngine#getFactories()
     */
    @Override
    public CaptchaFactory[] getFactories() {

        return new CaptchaFactory[] {m_factory};
    }

    /** This method build a Maptcha Factory.<p>
     *
     * @return a Maptcha Factory
     */
    public CmsMaptchaFactory getFactory() {

        return m_factory;
    }

    /**
     * This does nothing.<p>
     *
     * A hardcoded factory is used.<p>
     *
     * @see com.octo.captcha.engine.CaptchaEngine#setFactories(com.octo.captcha.CaptchaFactory[])
     */
    @Override
    public void setFactories(CaptchaFactory[] arg0) throws CaptchaEngineException {

        // TODO Auto-generated method stub

    }

    /**
     * Initializes a Maptcha Factory.<p>
     */
    protected void initMathFactory() {

        m_factory = new CmsMaptchaFactory();
    }

}
