<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.util.Random" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
	String[] arr = new String[] {"Apple", "GameStop", "AMC", "NOK"};
	Random ran = new Random();
	String holder = arr[ran.nextInt(4)];
	pageContext.setAttribute("holder", holder); 
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <title></title>
    <link rel="stylesheet" href="styles/styles.css" type="text/css" media="screen">
</head>
<body>
    <div id="content" class="container">
		<p>Using JSTL: <c:out value="${holder}"/></p>
		<p>Using JSP: <%=holder%></p>
    </div>
</body>
</html>