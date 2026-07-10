<%@page pageEncoding="UTF-8" isELIgnored="false" session="false" errorPage="/WEB-INF/views/commons/errors/jsp_error.jsp"%>

<%@page import="org.support.project.web.config.AppConfig"%>
<%@page import="org.support.project.web.util.JspUtil"%>
<%@page import="org.support.project.knowledge.control.Control"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% JspUtil jspUtil = new JspUtil(request, pageContext); %>

<script src="<%= request.getContextPath() %>/js/page-common-15cba9b9b5.js"></script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.11.1/build/highlight.min.js"></script>

<% if (jspUtil.is(Boolean.TRUE, "desktopNotify")) { %>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/notification.js"></script>
<% } %>


<script type="text/javascript">
var _LOGGING_NOTIFY_DESKTOP = false;
var _CONTEXT = '<%= request.getContextPath() %>';
<% if (jspUtil.logined()) { %>
var _LOGIN_USER_ID = <%= jspUtil.id() %>;
<% } else { %>
var _LOGIN_USER_ID = null;
<% } %>
var _LANG = '<%= jspUtil.locale().getLanguage()%>';

setCookie('<%= AppConfig.get().getSystemName() %>_<%= JspUtil.TIME_ZONE_OFFSET %>', (new Date()).getTimezoneOffset(), 60);
setCookie('<%= AppConfig.get().getSystemName() %>_TIMEZONE', jstz.determine().name(), 60);

<% 

java.util.List<String> successes = (java.util.List<String>) request.getAttribute(Control.MSG_SUCCESS);
if (successes != null) {
    for (String msg : successes) {
%>
$.notify('<%= msg %>', 'success');
<%
    }
}

java.util.List<String> infos = (java.util.List<String>) request.getAttribute(Control.MSG_INFO);
if (infos != null) {
    for (String msg : infos) {
%>
$.notify('<%= msg %>', 'info');
<%
    }
}

java.util.List<String> warns = (java.util.List<String>) request.getAttribute(Control.MSG_WARN);
if (warns != null) {
    for (String msg : warns) {
%>
$.notify('<%= msg %>', 'warn');
<%
    }
}

java.util.List<String> errors = (java.util.List<String>) request.getAttribute(Control.MSG_ERROR);
if (errors != null) {
    for (String msg : errors) {
%>
$.notify('<%= msg %>', 'error');
<%
    }
}

%>

</script>

<!-- /scripts -->
