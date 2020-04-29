<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList, com.bookstore.db.ReviewDB, com.bookstore.db.BookDB, com.bookstore.models.Book, com.bookstore.models.Review" %>

<div class="jumbotron">
	<h1>Order Confirmation</h1>
	<p>Congratulations, your order has been placed. The confirmation number for your order is:</p>
	<p><strong><%= request.getAttribute("confirmId") %></strong>
</div>

<%@ include file="footer.jsp" %>