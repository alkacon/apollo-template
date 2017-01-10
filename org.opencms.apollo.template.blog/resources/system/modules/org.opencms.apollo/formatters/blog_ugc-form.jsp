<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<%@page import="java.lang.String"%>
<%@page import="org.opencms.file.CmsResource"%>

<c:set var="backlink" value="${cms.typeDetailPage['a-blog']}" />
<% pageContext.setAttribute("backlink", CmsResource.getParentFolder((String)pageContext.getAttribute("backlink"))); %>

<apollo:init-messages reload="true">
<cms:formatter var="content">

<div>
    <div id="error" class="alert alert-danger" style="display:none;">
    </div>
    <cms:ugc var="ugcId" editId="${param.fileId}" configPath="${content.filename}" />
    <div id="postFormLoading" style="display: none"></div>
    <form id="ugcForm" <c:out value='ugc-id="${ugcId}" back-link="${backlink}"' escapeXml="false" /> method="post" role="form">

        <div class="form-group">
            <label for="title">Title</label> <input type="text"
                class="form-control" name="title">
        </div>
        <div class="form-group">
            <label for="text">Text</label>
            <textarea class="form-control" rows="5" name="text"></textarea>
        </div>
        <div class="form-group">
            <label for="imagefile">Image</label> <span
                class="btn btn-warning btn-block btn-file"> Click here to
                select a new image for upload... <input type="file"
                name="imagefile" id="imagefile">
            </span>
        </div>

        <div id="imageOptions" style="display: none">
            <!-- Option to remove an image, will be displayed only if an image is available -->
            <div class="form-group">
                <label for="imageuri">Current image</label> <input disabled
                    type="text" class="form-control" name="imageuri">
            </div>
            <div class="checkbox">
                <label> <input type="checkbox" name="imageremove">
                    Remove current image
                </label>
            </div>
        </div>

        <div class="form-group">
            <label for="imagetitle">Image Title</label> <input
                class="form-control" type="text" name="imagetitle">
        </div>
        <div class="form-group">
            <label for="imagedescription">Image Description</label> <input
                class="form-control" type="text" name="imagedescription">
        </div>
        <div class="form-group">
            <label for="author">Author name</label> <input type="text"
                class="form-control" name="author">
        </div>
        <div class="form-group">
            <label for="authormail">Author email</label> <input type="email"
                class="form-control" name="authormail">
        </div>
        <div class="form-group">
            <label for="webpageurl">Link</label> <input type="text"
                class="form-control" name="webpageurl">
        </div>
        <div class="form-group">
            <label for="webpagenice">Link description</label> <input
                type="text" class="form-control" name="webpagenice">
        </div>
        <input type="submit" style="display: none;">
        <div class="form-group">
            <div class="row">
                <div class="col-sm-6">
                    <button id="saveButton" type="button"
                        class="btn btn-block btn-primary">Save</button>
                </div>
                <div class="col-sm-3">
                    <button id="validateButton" type="button"
                        class="btn btn-block btn-default">Validate</button>
                </div>
                <div class="col-sm-3">
                    <button id="cancelButton" type="button"
                        class="btn btn-block btn-default">Cancel</button>
                </div>
            </div>
        </div>
    </form>
</div>

</cms:formatter>
</apollo:init-messages>
