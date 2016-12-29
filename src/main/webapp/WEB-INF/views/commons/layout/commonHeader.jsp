<%@page pageEncoding="UTF-8" isELIgnored="false" session="false" errorPage="/WEB-INF/views/commons/errors/jsp_error.jsp"%>
<%@page import="org.support.project.knowledge.config.SystemConfig"%>
<%@page import="org.support.project.common.util.StringUtils"%>
<%@page import="org.support.project.web.util.JspUtil"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% JspUtil jspUtil = new JspUtil(request, pageContext); %>

<meta charset="UTF-8">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />

<meta http-equiv="expires" content="0" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache">

<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">

<meta content="<%= jspUtil.label("knowledge.header.meta.title") %>" name="title">
<meta content="<%= jspUtil.label("knowledge.header.meta.description") %>" name="description">
<meta content='ナレッジマネジメント,ナレッジベース,情報共有,オープンソース,KnowledgeBase,KnowledgeManagement,OSS,Markdown' name='keywords'>
<meta property="og:type" content="article"/>
<meta property="og:title" content="<%= jspUtil.label("knowledge.header.meta.title") %>"/>
<meta property="og:description" content="<%= jspUtil.label("knowledge.header.meta.description") %>" />
<%-- <meta property="og:image" content="" /> --%>
<meta property="og:url" content="https://support-project.org/knowledge/index" />
<meta property="og:site_name" content="Knowledge"/>

<base href="<%= request.getContextPath() %>/" />

<link rel="icon" href="favicon.ico" type="image/vnd.microsoft.icon" /> 

<% if (StringUtils.isNotEmpty(jspUtil.out("thema"))) { %>
<link rel="stylesheet" href="bower/bootswatch/<%= jspUtil.out("thema") %>/bootstrap.min.css" />
<% } else { %>
<link rel="stylesheet" href="bower/bootswatch/<%= jspUtil.cookie(SystemConfig.COOKIE_KEY_THEMA, "flatly") %>/bootstrap.min.css" />
<% } %>

<% if (StringUtils.isNotEmpty(jspUtil.out("highlight"))) { %>
<link rel="stylesheet" href="bower/highlightjs/styles/<%= jspUtil.out("highlight") %>.css" />
<% } else { %>
<link rel="stylesheet" href="bower/highlightjs/styles/<%= jspUtil.cookie(SystemConfig.COOKIE_KEY_HIGHLIGHT, "darkula") %>.css" />
<% } %>

<link rel="stylesheet" href="bower/font-awesome/css/font-awesome.min.css" />
<link rel="stylesheet" href="bower/flag-icon-css/css/flag-icon.min.css" />

<!-- build:css(src/main/webapp) css/vendor.css -->
<link rel="stylesheet" href="bower/jquery-oembed-all/jquery.oembed.css" />
<!-- endbuild -->

<!--[if lt IE 9]>
    <!-- build:js(src/main/webapp) css/regacy.js -->
    <script src="bower/html5shiv/dist/html5shiv.min.js"></script>
    <script src="bower/respond/dest/respond.min.js"></script>
    <!-- endbuild -->
<![endif]-->

<!-- build:css(src/main/webapp) css/app-common.css -->
<link rel="stylesheet" href="css/common.css" />
<!-- endbuild -->

<!-- Knowledge - <%= jspUtil.label("label.version") %> -->
