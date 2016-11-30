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

public class CmsImgurDataItem implements I_CmsDataViewItem {

    String m_image;
    String m_id;
    String m_description;
    String m_title;
    String m_albumID;
    Boolean m_isAlbum;

    public CmsImgurDataItem(String id, String image, String description, String title, Boolean isAlbum, String aID) {
        this.m_description = description;
        this.m_id = id;
        this.m_image = image;
        this.m_title = title;
        this.m_isAlbum = isAlbum;
        this.m_albumID = aID;

    }

    public String getAlbumID() {

        return m_albumID;
    }

    public Object getColumnData(String colName) {

        switch (colName) {
            case "id":
                return getId();
            case "title":
                return getTitle();
            case "description":
                return getDescription();
            case "image":
                return m_image;
            default:
                return null;
        }
    }

    public String getData() {

        return "http://imgur.com/gallery/" + m_albumID;
    }

    public String getDescription() {

        if (m_description.equals("") | m_description.equals("null")) {
            return m_title;
        } else {
            if (m_description.length() > 540) {
                return m_description.substring(0, 540) + "...";
            } else {
                return m_description;
            }
        }
    }

    public String getId() {

        // TODO Auto-generated method stub
        return m_id;
    }

    public String getImage() {

        // TODO Auto-generated method stub
        return m_image;
    }

    public String getTitle() {

        // TODO Auto-generated method stub
        return m_title;
    }

    public Boolean isAlbum() {

        return m_isAlbum;
    }
}
