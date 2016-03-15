/*
 * File   : $Source: /alkacon/cvs/alkacon/com.alkacon.opencms.v8.feeder/src/com/alkacon/opencms/v8/feeder/CmsFeedGenerator.java,v $
 * Date   : $Date: 2008/12/13 13:23:24 $
 * Version: $Revision: 1.2 $
 *
 * This file is part of the Alkacon OpenCms Add-On Module Package
 *
 * Copyright (c) 2007 Alkacon Software GmbH (http://www.alkacon.com)
 *
 * The Alkacon OpenCms Add-On Module Package is free software:
 * you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * The Alkacon OpenCms Add-On Module Package is distributed
 * in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with the Alkacon OpenCms Add-On Module Package.
 * If not, see http://www.gnu.org/licenses/.
 *
 * For further information about Alkacon Software GmbH, please see the
 * company website: http://www.alkacon.com.
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org.
 */

package com.alkacon.opencms.v8.feeder;

import org.opencms.file.CmsFile;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.i18n.CmsEncoder;
import org.opencms.main.CmsException;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.util.CmsStringUtil;
import org.opencms.xml.content.CmsXmlContent;
import org.opencms.xml.content.CmsXmlContentFactory;
import org.opencms.xml.content.I_CmsXmlContentHandler;

import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.apache.commons.logging.Log;

import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.feed.synd.SyndFeedImpl;
import com.sun.syndication.feed.synd.SyndImage;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.SyndFeedOutput;

/**
 * Creates a syndication feed from a List of XML content resources.<p>
 *
 * @author Alexander Kandzior
 * @author Michael Moossen
 *
 * @version $Revision: 1.2 $
 */
public class CmsFeedGenerator {

    /** Place holder for content handler defined mappings. */
    private static final CmsFeedContentMapping EMPTY_MAPPING = new CmsFeedContentMapping();

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsFeedGenerator.class);

    /** This is a list of lists of XML content entries that make up the feed. */
    private List m_contentEntriesList;

    /** This id a list of default XML content mappings that apply in case the XML content does not use a special feed handler. */
    private List m_defaultMappingList;

    /** The feed copyright message. */
    private String m_feedCopyright;

    /** The feed description. */
    private String m_feedDescription;

    /** The encoding to use for the feed creation. */
    private String m_feedEncoding;

    /** The optional image for the feed. */
    private SyndImage m_feedImage;

    /** The base link to the feed source. */
    private String m_feedLink;

    /** The title of the feed. */
    private String m_feedTitle;

    /** The type of the feed. */
    private String m_feedType;

    /**
     * Creates a new, empty feed generator.<p>
     */
    public CmsFeedGenerator() {

        m_contentEntriesList = new ArrayList();
        m_defaultMappingList = new ArrayList();
    }

    /**
     * Creates a new feed generator with a default feed mapping.<p>
     *
     * @param defaultMapping the default feed mapping to use
     *
     * @deprecated use {@link #addResourceSet(List, CmsFeedContentMapping)} instead
     */
    @Deprecated
    public CmsFeedGenerator(CmsFeedContentMapping defaultMapping) {

        m_defaultMappingList.add(defaultMapping);
    }

    /**
     * Adds a new pair of resource list and default mapping.<p>
     *
     * @param contentEntries the list of XML content entries that make up the feed to set
     * @param defaultMapping the default feed mapping to use
     */
    public void addResourceSet(List contentEntries, CmsFeedContentMapping defaultMapping) {

        m_contentEntriesList.add(contentEntries);
        if (defaultMapping == null) {
            m_defaultMappingList.add(EMPTY_MAPPING);
        } else {
            m_defaultMappingList.add(defaultMapping);
        }
    }

    /**
     * Returns the list of XML content entries that make up the feed.<p>
     *
     * @return the list of XML content entries that make up the feed
     *
     * @deprecated use {@link #addResourceSet(List, CmsFeedContentMapping)} instead
     */
    @Deprecated
    public List getContentEntries() {

        return (List)m_contentEntriesList.get(0);
    }

    /**
     * Creates a feed using the current settings.<p>
     *
     * @param cms the OpenCms user context to generate the feed with
     * @param locale the currently selected locale to use for the feed
     *
     * @return a feed created using the current settings
     *
     * @throws CmsException in case of errors accessing the OpenCms VFS
     */
    public SyndFeed getFeed(CmsObject cms, Locale locale) throws CmsException {

        // create the feed instance
        SyndFeed feed = new SyndFeedImpl();
        // set the main feed parameters
        if (CmsStringUtil.isNotEmpty(m_feedType)) {
            feed.setFeedType(m_feedType);
        }
        if (CmsStringUtil.isNotEmpty(m_feedTitle)) {
            feed.setTitle(m_feedTitle);
        }
        if (CmsStringUtil.isNotEmpty(m_feedLink)) {
            feed.setLink(m_feedLink);
        }
        if (CmsStringUtil.isNotEmpty(m_feedDescription)) {
            feed.setDescription(m_feedDescription);
        }
        if (m_feedImage != null) {
            feed.setImage(m_feedImage);
        }
        if (CmsStringUtil.isNotEmpty(m_feedEncoding)) {
            feed.setEncoding(CmsEncoder.lookupEncoding(m_feedEncoding, OpenCms.getSystemInfo().getDefaultEncoding()));
        } else {
            // use OpenCms default if nothing is set
            feed.setEncoding(OpenCms.getSystemInfo().getDefaultEncoding());
        }
        if (CmsStringUtil.isNotEmpty(locale.getLanguage())) {
            feed.setLanguage(locale.getLanguage());
        }
        if (CmsStringUtil.isNotEmpty(m_feedCopyright)) {
            feed.setCopyright(m_feedCopyright);
        }

        List allEntries = new ArrayList();
        for (int k = 0; k < m_contentEntriesList.size(); k++) {
            List contentEntries = (List)m_contentEntriesList.get(k);
            CmsFeedContentMapping defaultMapping = (CmsFeedContentMapping)m_defaultMappingList.get(k);
            // now add the entries
            for (int i = 0; i < contentEntries.size(); i++) {
                // iterate over all content entries
                Object obj = contentEntries.get(i);
                CmsXmlContent content;
                if (obj instanceof CmsXmlContent) {
                    content = (CmsXmlContent)obj;
                } else {
                    CmsResource res = (CmsResource)obj;
                    CmsFile file = cms.readFile(res);
                    content = CmsXmlContentFactory.unmarshal(cms, file);
                }
                LOG.debug(
                    "RSS feed generation, processing content entry definition \""
                        + content.getFile().getRootPath()
                        + "\"");
                I_CmsXmlContentHandler handler = content.getContentDefinition().getContentHandler();
                CmsFeedContentMapping mapping = null;
                if (handler instanceof CmsFeedXmlContentHandler) {
                    // this content has a special feed handler
                    mapping = ((CmsFeedXmlContentHandler)handler).getFeedMapping();
                    LOG.debug("RSS Feed generation, using mapping " + mapping.getClass().getName());
                } else {
                    // check if default handler applies to the content
                    mapping = defaultMapping;
                    LOG.debug("RSS Feed generation, using default mapping");
                }

                if (mapping != null) {
                    allEntries.addAll(mapping.getRssEntries(cms, content, locale));
                    LOG.debug(
                        "RSS Feed generation, added RSS entries " + mapping.getRssEntries(cms, content, locale).size());
                }
            }
        }
        // set the feed entries
        feed.setEntries(allEntries);

        return feed;
    }

    /**
     * Returns the feed copyright message.<p>
     *
     * @return the feed copyright message
     */
    public String getFeedCopyright() {

        return m_feedCopyright;
    }

    /**
     * Returns the feed description.<p>
     *
     * @return the feed description
     */
    public String getFeedDescription() {

        return m_feedDescription;
    }

    /**
     * Returns the encoding to use for the feed creation.<p>
     *
     * @return the encoding to use for the feed creation
     */
    public String getFeedEncoding() {

        return m_feedEncoding;
    }

    /**
     * Returns the optional image for the feed.<p>
     *
     * @return the optional image for the feed
     */
    public SyndImage getFeedImage() {

        return m_feedImage;
    }

    /**
     * Returns the base link to the feed source.<p>
     *
     * @return the base link to the feed source
     */
    public String getFeedLink() {

        return m_feedLink;
    }

    /**
     * Returns the title of the feed.<p>
     *
     * @return the title of the feed
     */
    public String getFeedTitle() {

        return m_feedTitle;
    }

    /**
     * Returns the type of the feed.<p>
     *
     * @return the type of the feed
     */
    public String getFeedType() {

        return m_feedType;
    }

    /**
     * Sets the list of XML content entries that make up the feed.<p>
     *
     * @param contentEntries the list of XML content entries that make up the feed to set
     *
     * @deprecated use {@link #addResourceSet(List, CmsFeedContentMapping)} instead
     */
    @Deprecated
    public void setContentEntries(List contentEntries) {

        if (m_contentEntriesList.isEmpty()) {
            m_contentEntriesList.add(contentEntries);
        } else {
            m_contentEntriesList.set(0, contentEntries);
        }
    }

    /**
     * Sets the feed copyright message.<p>
     *
     * @param feedCopyright the feed copyright message to set
     */
    public void setFeedCopyright(String feedCopyright) {

        m_feedCopyright = feedCopyright;
    }

    /**
     * Sets the feed description.<p>
     *
     * @param feedDescription the feed description to set
     */
    public void setFeedDescription(String feedDescription) {

        m_feedDescription = feedDescription;
    }

    /**
     * Sets the encoding to use for the feed creation.<p>
     *
     * @param feedEncoding the encoding to use for the feed creation to set
     */
    public void setFeedEncoding(String feedEncoding) {

        m_feedEncoding = feedEncoding;
    }

    /**
     * Sets the optional image for the feed.<p>
     *
     * @param feedImage the optional image for the feed to set
     */
    public void setFeedImage(SyndImage feedImage) {

        m_feedImage = feedImage;
    }

    /**
     * Sets the base link to the feed source.<p>
     *
     * @param feedLink the base link to the feed source to set
     */
    public void setFeedLink(String feedLink) {

        m_feedLink = feedLink;
    }

    /**
     * Sets the title of the feed.<p>
     *
     * @param feedTitle the title of the feed to set
     */
    public void setFeedTitle(String feedTitle) {

        m_feedTitle = feedTitle;
    }

    /**
     * Sets the type of the feed.<p>
     *
     * @param feedType the type of the feed to set
     */
    public void setFeedType(String feedType) {

        m_feedType = feedType;
    }

    /**
     * Write the feed result to the provided output stream.<p>
     *
     * @param cms the current users OpenCms context
     * @param locale the locale to use
     * @param out the output stream to write the feed to
     *
     * @throws IOException in case of errors writing to the stream
     * @throws FeedException in case of errors generating the feed
     * @throws CmsException in case of errors accessing the OpenCms VFS
     */
    public void write(CmsObject cms, Locale locale, OutputStream out) throws IOException, FeedException, CmsException {

        Writer writer = new OutputStreamWriter(out);
        write(cms, locale, writer);
    }

    /**
     * Write the feed result to the provided writer.<p>
     *
     * @param cms the current users OpenCms context
     * @param locale the locale to use
     * @param writer the writer to write the feed to
     *
     * @throws IOException in case of errors writing to the stream
     * @throws FeedException in case of errors generating the feed
     * @throws CmsException in case of errors accessing the OpenCms VFS
     */
    public void write(CmsObject cms, Locale locale, Writer writer) throws IOException, FeedException, CmsException {

        SyndFeed feed = getFeed(cms, locale);
        SyndFeedOutput out = new SyndFeedOutput();
        out.output(feed, writer);
    }
}