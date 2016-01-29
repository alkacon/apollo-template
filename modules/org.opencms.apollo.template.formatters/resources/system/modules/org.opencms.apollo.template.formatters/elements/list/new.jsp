<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<cms:contentload collector="singleFile" param="%(param.listConfig)">
	<cms:contentaccess var="listConfig" />
</cms:contentload>
<c:set var="createType">${fn:substringBefore(listConfig.value.TypesToCollect.stringValue, ':')}</c:set>
<cms:edit createType="${createType}" create="true" >

	<div class="alert alert-warning fade in">
		<h3>
			<fmt:message key="apollo.list.message.empty" />
		</h3>
		<div>
			<fmt:message key="apollo.list.message.newentry" />
		</div>
	</div>
</cms:edit>