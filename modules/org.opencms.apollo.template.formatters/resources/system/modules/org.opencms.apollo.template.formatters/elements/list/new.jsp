<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>

<cms:edit createType="${cms.vfs.property[param.typesToCollect]['list.type']}" create="true" >

	<div class="alert alert-warning fade in">
		<h3>
			<fmt:message key="apollo.list.message.empty" />
		</h3>
		<div>
			<fmt:message key="apollo.list.message.newentry" />
		</div>
	</div>
</cms:edit>