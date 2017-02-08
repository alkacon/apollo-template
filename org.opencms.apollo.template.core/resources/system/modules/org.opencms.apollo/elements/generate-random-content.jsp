<%@page
    import="org.opencms.file.*,org.opencms.file.types.*,org.opencms.jsp.*,org.opencms.main.*,java.util.*"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%!private final Random mRandom = new Random();

    private static final String[] THINGS = {"bottle", "bowl", "brick", "building", "bunny", "cake", "car", "cat", "cup",
            "desk", "dog", "duck", "elephant", "engineer", "fork", "glass", "griffon", "hat", "key", "knife", "lawyer",
            "llama", "manual", "meat", "monitor", "mouse", "tangerine", "paper", "pear", "pen", "pencil", "phone",
            "physicist", "planet", "potato", "road", "salad", "shoe", "slipper", "soup", "spoon", "star", "steak",
            "table", "terminal", "treehouse", "truck", "watermelon", "window"};

    private static final String[] ADJECTIVES = {"red", "green", "yellow", "gray", "solid", "fierce", "friendly",
            "cowardly", "convenient", "foreign", "national", "tall", "short", "metallic", "golden", "silver", "sweet",
            "nationwide", "competitive", "stable", "municipal", "famous"};

    private static final String[] VERBS_PAST = {"accused", "threatened", "warned", "spoke to", "has met with",
            "was seen in the company of", "advanced towards", "collapsed on", "signed a partnership with",
            "was converted into", "became", "was authorized to sell", "sold", "bought", "rented", "allegedly spoke to",
            "leased", "is now investing on", "is expected to buy", "is expected to sell",
            "was reported to have met with", "will work together with", "plans to cease fire against",
            "started a war with", "signed a truce with", "is now managing", "is investigating"};

    private static final String[] VERBS_PRESENT = {"accuses", "threatens", "warns", "speaks to", "meets with",
            "seen with", "advances towards", "collapses on", "signs partnership with", "converts into", "becomes",
            "is authorized to sell", "sells", "buys", "rents", "allegedly speaks to", "leases", "invests on",
            "expected to buy", "expected to sell", "reported to have met with", "works together with",
            "plans cease fire against", "starts war with", "signs truce with", "now manages"};

    private static String joinWords(List<String> words) {

        int i;
        if (words.size() == 0) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        sb.append(words.get(0));
        for (i = 1; i < words.size(); i++) {
            if (!words.get(i).startsWith(",")) {
                sb.append(" ");
            }
            sb.append(words.get(i));
        }
        return sb.toString();
    }

    /**
     * Produces a sentence.
     *
     * @param isHeadline
     *            whether the sentence should look like a headline or not.
     * @return the generated sentence.
     */
    public String makeSentence(boolean isHeadline) {

        List<String> words = new ArrayList<String>();
        generateSentence(words, isHeadline);
        words.set(0, String.valueOf(Character.toUpperCase(words.get(0).charAt(0))) + words.get(0).substring(1));
        return joinWords(words);
    }

    private void generateAgent(List<String> words, boolean isHeadline) {

        if (!isHeadline) {
            words.add(pickOneOf("a", "the"));
        }
        if (mRandom.nextInt(3) != 0) {
            words.add(pickOneOf(ADJECTIVES));
        }
        words.add(pickOneOf(THINGS));
    }

    private void generatePredicate(List<String> words, boolean isHeadline) {

        words.add(pickOneOf(isHeadline ? VERBS_PRESENT : VERBS_PAST));
        if (!isHeadline) {
            words.add(pickOneOf("a", "the"));
        }
        if (mRandom.nextInt(3) != 0) {
            words.add(pickOneOf(ADJECTIVES));
        }
        words.add(pickOneOf(THINGS));

        if (mRandom.nextInt(3) == 0) {
            words.add(isHeadline ? pickOneOf(", claims", ", says") : pickOneOf(", claimed", ", said", ", reported"));
            if (!isHeadline) {
                words.add(pickOneOf("a", "the"));
            }
            if (mRandom.nextInt(3) != 0) {
                words.add(pickOneOf(ADJECTIVES));
            }
            words.add(pickOneOf(THINGS));
        }
    }

    /**
     * Generates a sentence.
     *
     * @param words
     *            the list of words to which the sentence will be appended.
     * @param isHeadline
     *            whether the sentence must look like a headline or not.
     */
    private void generateSentence(List<String> words, boolean isHeadline) {

        if (!isHeadline && (mRandom.nextInt(4) == 0)) {
            generateTimeClause(words, isHeadline);
        }
        generateAgent(words, isHeadline);
        generatePredicate(words, isHeadline);
    }

    private void generateTimeClause(List<String> words, boolean isHeadline) {

        if (mRandom.nextInt(2) == 0) {
            words.add(pickOneOf("today", "yesterday", "this afternoon", "this morning", "last evening"));
        } else {
            words.add(pickOneOf("this", "last"));
            words.add(pickOneOf("Monday", "Tuesday", "Wednesday", "Thursday"));
            words.add(pickOneOf("morning", "afternoon", "evening"));
        }
    }

    private String pickOneOf(String... options) {

        return options[mRandom.nextInt(options.length)];
    }%>


<c:choose>
<c:when test="${not empty fn:trim(param.count) and not empty fn:trim(param.path)and not empty fn:trim(param.ext) and not empty fn:trim(param.prefix)}">

        <%
            String targetFolderSitePath = request.getParameter("path");
            targetFolderSitePath = targetFolderSitePath.startsWith("/")
                ? targetFolderSitePath
                : "/" + targetFolderSitePath;
            String prefix = request.getParameter("prefix");
            String ext = request.getParameter("ext");
            int fileCount = Integer.parseInt(request.getParameter("count"));

            CmsJspActionElement jAE = new CmsJspActionElement(pageContext, request, response);
            CmsObject cms = jAE.getCmsObject();

            if (!cms.existsResource(targetFolderSitePath)) {
                out.println("Creating folder " + targetFolderSitePath + " first<br />\n");
                cms.createResource(targetFolderSitePath,
                    OpenCms.getResourceManager().getResourceType(CmsResourceTypeFolder.getStaticTypeName()),
                    null,
                    new ArrayList<CmsProperty>(0));
            }
            for (int i = 1; i <= fileCount; i++) {

                String title = makeSentence(true);
                String navtext = makeSentence(false);
                String copyright = makeSentence(false);
                String cache = makeSentence(false);

                List<CmsProperty> properties = new ArrayList<CmsProperty>();
                properties.add(new CmsProperty(CmsPropertyDefinition.PROPERTY_TITLE, title, null));
                properties.add(new CmsProperty(CmsPropertyDefinition.PROPERTY_NAVTEXT, navtext, null));
                properties.add(new CmsProperty(CmsPropertyDefinition.PROPERTY_COPYRIGHT, copyright, null));
                properties.add(new CmsProperty(CmsPropertyDefinition.PROPERTY_CACHE, cache, null));

                String creationPath = targetFolderSitePath + "/" + prefix + "_" + String.format("%04d", Integer.valueOf(i)) + "." + ext;
                if (!cms.existsResource(creationPath)) {
                    out.println("Creating file " + creationPath + "<br />\n");
                    CmsResource createdResource =
                        cms
                        .createResource(creationPath, OpenCms.getResourceManager()
                        .getResourceType(CmsResourceTypeBinary.getStaticTypeName()), null, properties);
                } else {
                    out.println("File " + creationPath + " already exists<br />\n");
                }
            }
        %>
</c:when>


<c:otherwise>
<!DOCTYPE html>
<html>
<head>
<title>OpenCms | Random content generator</title>

<c:set var="colortheme"><cms:property name="apollo.theme" file="search" default="red" /></c:set>
<c:if test="${not fn:startsWith(colortheme, '/')}"><c:set var="colortheme">/system/modules/org.opencms.apollo.theme/resources/css/style-${colortheme}.min.css</c:set></c:if>
<link rel="stylesheet" href="<cms:link>${colortheme}</cms:link>" />

<style>
.centered {
    margin: 0 auto;
}

.col-centered {
    float: none;
    margin: 0 auto;
}

.rcg_log {
    background: #fff;
    height: 300px;
    overflow: auto;
    text-align: left;
}

</style>
</head>
<body class="wrapper">
    <div class="row">
        <div class=" mt-10 col-md-4 col-centered text-center">
            <h1>OpenCms Apollo Template</h1>
            <h3>Random content generator</h3>

            <form class="row bg-orange text-dark" method="get">
                <input name="count" class="mb-10 form-control col-xs-12"
                    type="number" placeholder="Count of pages" required="required" />

                <input class="mb-10 form-control col-xs-12" type="text" name="path"
                    placeholder="Path to files (recursive to active site)" required="required" />

                <input class="mb-10 form-control col-xs-12" type="text" name="prefix"
                    placeholder="Prefix of files" required="required" />

                <input class="mb-10 form-control col-xs-12" type="text" name="ext"
                    placeholder="file extension of files" required="required" />

                <button type="submit" class="color-red col-xs-12 btn submit">Submit</button>
            </form>
            <div id="log"></div>
        </div>
    </div>

    <script src="<cms:link>%(link.weak:/system/modules/org.opencms.apollo.theme/resources/js/scripts-all.min.js:0fc90357-5155-11e5-abeb-0242ac11002b)</cms:link>"></script>
    <script type="text/javascript">
        $("form").submit( function(e) {
            $('.submit').text("Working...");
            e.preventDefault();
            var str = $("form").serialize();

            $.get("?" + str, function(resultList) {
                $("#log").html(resultList);
            }).fail( function(error) {
                $("#log").html(
                    "I'm sorry, something went wrong. " +
                    "Perhaps the timeout was too small. " +
                    "Please take a look at the explorer if the files are created.");
            }).always( function() {
                $('.submit').text("Submit");
            });
        });
    </script>
</body>
</html>

</c:otherwise>
</c:choose>
