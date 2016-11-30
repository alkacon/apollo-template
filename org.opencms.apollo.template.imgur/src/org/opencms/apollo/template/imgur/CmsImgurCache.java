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

package org.opencms.apollo.template.imgur;

import org.opencms.widgets.dataview.I_CmsDataViewItem;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class CmsImgurCache implements Serializable {

    public static Map<String, String> albumImages = new HashMap<String, String>();
    public static Map<String, String> albumDescription = new HashMap<String, String>();
    public static Map<String, ArrayList<I_CmsDataViewItem>> itemLists = new HashMap<String, ArrayList<I_CmsDataViewItem>>();
    public static Map<String, Long> itemListTime = new HashMap<String, Long>();
}
