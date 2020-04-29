<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/OBS_MASTER"
     user="root"  password=""/>

<sql:query dataSource="${snapshot}" var="result">
SELECT genre_name from genres;
</sql:query>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" href="./favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- Optional theme -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">-->
</head>
<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button><br>
          <a class="navbar-brand" href="./">Old Town Books</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <form class="navbar-form navbar-left" action="./Search" method="get"><br>
            <input type="text" class="form-control" name="search-query" id="search-query" size="40" placeholder="ISBN, Title, Author, Keyword...">
          </form>
          <ul class="nav navbar-nav navbar-right">
          	<li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><br>Browse<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="./Search?search-query=">All</a></li>
                  <c:forEach var="row" items="${result.rows}">
                  <li><a href="./Search?search-query=${row.genre_name}">${row.genre_name}</a></li>
                  </c:forEach>
                </ul>
            </li>
          <% 
			Object userIn = session.getAttribute("user");
			String userLoggedIn = "";
			if (userIn != null) {
				userLoggedIn = (String) userIn;
				%>
				<li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false" style = "text-transform:capitalize;"><br><%=userLoggedIn %> <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="./CustomerAccount.jsp">Account</a></li>
                  <li class="divider"></li>
                  <li><a href="./logout.jsp">Logout</a></li>
                </ul>
                </li>
				<%
			} else {
			// Not logged in, show login prompt
			%>
	         <li><a href="./SignUp.jsp"><br>Sign in/Register</a></li> 
			<%
			}
		%>
		<%if(userLoggedIn.equalsIgnoreCase("admin")) {%>
			 <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><br>Manage<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="./generateReports">View Reports</a></li>
                  <li><a href="./AddBook.jsp">Add Book</a></li>
                  <li><a href="./UserLookup">View Users</a></li>
                </ul>
              </li>
              <%} %>
              <%if(!userLoggedIn.equalsIgnoreCase("admin")) {%>
		     <li><a href="./Checkout.jsp"><br>Cart</a></li>
		     <%} %>
		  </ul>
        </div>
      </div>
    </nav>
    <div style="padding: 70px 15px; text-align: center;">
    <div class="container">
    
