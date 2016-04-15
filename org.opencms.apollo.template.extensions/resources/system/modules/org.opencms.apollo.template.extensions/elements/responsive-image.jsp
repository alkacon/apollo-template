<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- First look if the parameters are available and if the image isn't scaled already, otherwise we can't do anything --%>
<c:if
	test="${not empty fn:trim(param.css) and not empty fn:trim(param.imagesrc)}">
	<c:set var="cssClass">${param.css}</c:set>
	<c:set var="imagesrc">${param.imagesrc}</c:set>
	<c:set var="imageClass">${param.imagecss}</c:set>
	<c:set var="title">${param.title}</c:set>
	<c:set var="scale">${param.scale}</c:set>
	<c:set var="xmlContent">${param.xmlcontent}</c:set>
	<c:set var="sameSize">${param.samesize}</c:set>
	<c:set var="additional">${param.additional}</c:set>

		<c:choose>
			<c:when test="${not fn:contains(imagesrc, '__scale')}">

				<%--  Some general settings (scale options, bootstrap sizes and corresponding image sizes --%>
				<c:set var="scaleOptions" scope="request">,t:${empty param.scale? '0': scale},q:0.7</c:set>
				<c:set var="bsFlagLg">-lg</c:set>
				<c:set var="bsFlagMd">-md</c:set>
				<c:set var="bsFlagSm">-sm</c:set>
				<c:set var="bsFlagXs">-xs</c:set>
				<c:set var="bsLarge">1200</c:set>
				<c:set var="bsMiddle">1000</c:set>
				<c:set var="bsSmall">768</c:set>
				<c:set var="imageWidthExtraLarge">2000</c:set>
				<c:set var="imageWidthLarge">${bsLarge}</c:set>
				<c:set var="imageWidthMiddle">${bsMiddle}</c:set>
				<c:set var="imageWidthSmall">${bsSmall}</c:set>
				<c:set var="imageHeight">2500</c:set>
				<c:set var="scaleParam">?__scale=</c:set>

				<%-- Calculate the sizes depending on the given bootstrap classes --%>
				<c:set var="sizeslg"></c:set>
				<c:set var="sizesmd"></c:set>
				<c:set var="sizessm"></c:set>
				<c:set var="sizesxs">200</c:set>
				<c:choose>
					<%--  In case the container is inside a template row and get a string with all inherited classes --%>
					<c:when
						test="${fn:contains(cssClass, '|') and fn:contains(cssClass, 'css')}">
						<c:forEach var="p" items="${fn:split(cssClass, '|')}">
							<c:if test="${fn:startsWith(p, 'css')}">
								<c:forEach var="css" items="${fn:split(p, ' ')}">
									<c:if
										test="${fn:contains(css, bsFlagLg) or fn:contains(css, bsFlagMd) or fn:contains(css, bsFlagSm) or fn:contains(css, bsFlagXs)}">
										<c:set var="arr" value="${fn:split(css, '-')}" />
										<c:set var="s" value="${arr[fn:length(arr)-1]/12*100}" />
										<c:choose>
											<c:when test="${fn:contains(css, bsFlagXs)}">
												<c:choose>
													<c:when test="${empty sizesxs}">
														<c:set var="sizesxs" value="${s}" />
													</c:when>
													<c:otherwise>
														<c:if test="${sizesxs ne s}">
															<c:set var="sizesxs" value="${sizesxs/(100/s)}" />
														</c:if>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:when test="${fn:contains(css, bsFlagSm)}">
												<c:choose>
													<c:when test="${empty sizessm}">
														<c:set var="sizessm" value="${s}" />
													</c:when>
													<c:otherwise>
														<c:if test="${sizessm ne s}">
															<c:set var="sizessm" value="${sizessm/(100/s)}" />
														</c:if>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:when test="${fn:contains(css, bsFlagMd)}">
												<c:choose>
													<c:when test="${empty sizesmd}">
														<c:set var="sizesmd" value="${s}" />
													</c:when>
													<c:otherwise>
														<c:if test="${sizesmd ne s}">
															<c:set var="sizesmd" value="${sizesmd/(100/s)}" />
														</c:if>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:when test="${fn:contains(css, bsFlagLg)}">
												<c:choose>
													<c:when test="${empty sizeslg}">
														<c:set var="sizeslg" value="${s}" />
													</c:when>
													<c:otherwise>
														<c:if test="${sizeslg ne s}">
															<c:set var="sizeslg" value="${sizeslg/(100/s)}" />
														</c:if>
													</c:otherwise>
												</c:choose>
											</c:when>
										</c:choose>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
					</c:when>
					<%-- Otherwise we just parse the simpleboostrap classes  --%>
					<c:otherwise>
						<c:forEach var="css" items="${fn:split(cssClass, ' ')}">
							<c:if
								test="${fn:contains(css, bsFlagLg) or fn:contains(css, bsFlagMd) or fn:contains(css, bsFlagSm) or fn:contains(css, bsFlagXs)}">
								<c:set var="arr" value="${fn:split(css, '-')}" />
								<c:set var="s" value="${arr[fn:length(arr)-1]/12*100}" />
								<c:choose>
									<c:when test="${fn:contains(css, bsFlagXs)}">
										<c:set var="sizesxs" value="${s}" />
									</c:when>
									<c:when test="${fn:contains(css, bsFlagSm)}">
										<c:set var="sizessm" value="${s}" />
									</c:when>
									<c:when test="${fn:contains(css, bsFlagMd)}">
										<c:set var="sizesmd" value="${s}" />
									</c:when>
									<c:when test="${fn:contains(css, bsFlagLg)}">
										<c:set var="sizeslg" value="${s}" />
									</c:when>
								</c:choose>
							</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>

				<c:set var="sizes"></c:set>
				<c:if test="${not empty sizeslg}">
					<c:set var="sizes">(min-width: ${bsLarge}px)${' '}${sizeslg}vw,</c:set>
				</c:if>
				<c:if test="${not empty sizesmd}">
					<c:set var="sizes">${sizes}(min-width: ${bsMiddle}px)${' '}${sizesmd}vw,</c:set>
				</c:if>
				<c:if test="${not empty sizessm}">
					<c:set var="sizes">${sizes}(min-width: ${bsSmall}px)${' '}${sizessm}vw,</c:set>
				</c:if>
				<c:if test="${not empty sizesxs}">
					<c:set var="sizes">${sizes}${sizesxs}vw</c:set>
				</c:if>
				<c:set var="sizes">${sizes}</c:set>
				<c:set var="scaleExtraLarge">${scaleParam}w:${imageWidthExtraLarge},h:${sameSize eq 'true'?imageWidthExtraLarge:imageHeight}${scaleOptions}</c:set>
				<c:set var="scaleLarge">${scaleParam}w:${imageWidthLarge},h:${sameSize eq 'true'?imageWidthLarge:imageHeight}${scaleOptions}</c:set>
				<c:set var="scaleMiddle">${scaleParam}w:${imageWidthMiddle},h:${sameSize eq 'true'?imageWidthMiddle:imageHeight}${scaleOptions}</c:set>
				<c:set var="scaleSmall">${scaleParam}w:${imageWidthSmall},h:${sameSize eq 'true'?imageWidthSmall:imageHeight}${scaleOptions}</c:set>

				<%-- Generate the correspoimagecssnding image links --%>
				<c:set var="imgsrcExtraLarge">
					<cms:link>${imagesrc}${scaleExtraLarge}</cms:link>
				</c:set>
				<c:set var="imgsrcLarge">
					<cms:link>${imagesrc}${scaleLarge}</cms:link>
				</c:set>
				<c:set var="imgsrcMiddle">
					<cms:link>${imagesrc}${scaleMiddle}</cms:link>
				</c:set>
				<c:set var="imgsrcSmall">
					<cms:link>${imagesrc}${scaleSmall}</cms:link>
				</c:set>
				<c:set var="srcset">
		${imgsrcExtraLarge}${' '}${imageWidthExtraLarge}w, ${imgsrcLarge}${' '}${imageWidthLarge}w,${imgsrcMiddle}${' '}${imageWidthMiddle}w, ${imgsrcSmall}${' '}${imageWidthSmall}w
	</c:set>
				<%-- And finally the image tag, with or without the OpenCms Dran'n'Drop feature. --%>
				<c:choose>
					<c:when test="${not empty xmlContent}">
						<cms:formatter var="content">
							<div>
								<img  ${content.imageDnd[xmlContent]}
									src="${imgsrcSmall}" alt="${title}" title="${title}"
									srcset="${srcset}"  sizes="${sizes}" class="${imageClass}"
									${additional} />
							</div>
						</cms:formatter>
					</c:when>
					<c:otherwise>
						<img src="${imgsrcSmall}" alt="${title}"
							title="${title}" srcset="${srcset}" sizes="${sizes}"
							class="${imageClass}" ${additional} />
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<%-- In case the image is already scaled, we just take it like it is. --%>
				<c:choose>
					<c:when test="${not empty xmlContent}">
						<cms:formatter var="content">
							<img  ${content.imageDnd[xmlContent]}
								src="<cms:link>${imagesrc}</cms:link>" alt="${title}"
								title="${title}" class="${imageClass}" ${additional} />

						</cms:formatter>
					</c:when>
					<c:otherwise>
						<img src="<cms:link>${imagesrc}</cms:link>"
							alt="${title}" title="${title}" class="${imageClass}"
							${additional} />
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
</c:if>