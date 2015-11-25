<div class="alert alert-warning fade in">
	<h3>
		<fmt:message key="apollo.list.message.empty" />
	</h3>
	<div>
		<c:choose>
			<c:when test='${con.value.TypesToCollect ne "a-blog" }'>
				<cms:edit createType="a-event">
					<fmt:message key="apollo.list.message.newevent" />
				</cms:edit>
			</c:when>
			<c:when test='${(con.value.TypesToCollect eq "a-blog") }'>
				<cms:edit createType="a-blog">
					<fmt:message key="apollo.list.message.newblog" />
				</cms:edit>
			</c:when>
		</c:choose>
	</div>
</div>