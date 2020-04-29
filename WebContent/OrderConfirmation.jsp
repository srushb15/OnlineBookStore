<%@ include file="header.jsp" %>
<%@ page import="java.util.ArrayList, com.bookstore.db.ReviewDB, com.bookstore.db.BookDB, com.bookstore.models.Book, com.bookstore.models.Review" %>

<div class="jumbotron">
	<h1>Order Confirmation</h1>
	<p>Congratulations, your order has been placed</p>
	<p>Transaction ID:<strong><%= request.getAttribute("confirmId") %></strong></p><br>
	<p>User:<strong><%= request.getAttribute("getUserName") %></strong></p><br>
	<p>Purchase Date:<strong><%= request.getAttribute("getPurchaseDate") %></strong></p><br>
	<p>
		<table style="width:100%;border: 1px solid black;text-align: center;">
		  <tr>
		    <th style="text-align: center;">ISBN Number</th>
		    <th style="text-align: center;">Quantity</th>
		    <th style="text-align: center;">Book Title</th>
		  </tr>
		  <c:forEach items="${itemList}" var="item">
		    <tr>
		      <td><c:out value="${item.isbn}" /></td>
		      <td><c:out value="${item.quantity}" /></td>
		      <td><c:out value="${item.title}" /></td>
		    </tr>
		  </c:forEach>
		</table>
	</p>
	<p>Total Price:<strong><%= request.getAttribute("getTotalPrice") %></strong></p>
	<br>
	<p>
    	<button onclick="javascript:window.print();" >Print</button>
	</p>
</div>

<%@ include file="footer.jsp" %>