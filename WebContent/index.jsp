<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<%@ page import="com.bookstore.db.BookDB, com.bookstore.models.Book, java.util.*, java.sql.*, java.text.NumberFormat" %>
<head>
	<title>Online Book Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
  font-family: Arial;
  font-size: 17px;
  padding: 8px;
}

* {
  box-sizing: border-box;
}

.row {
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
  margin: 0 -16px;
}

.col-25 {
  -ms-flex: 25%; /* IE10 */
  flex: 25%;
}

.col-50 {
  -ms-flex: 50%; /* IE10 */
  flex: 50%;
}

.col-75 {
  -ms-flex: 75%; /* IE10 */
  flex: 75%;
}

.col-25,
.col-50,
.col-75 {
  padding: 0 16px;
}

.container {
  background-color: #f2f2f2;
  padding: 5px 20px 15px 20px;
  border: 1px solid lightgrey;
  border-radius: 3px;
}

input[type=text] {
  width: 100%;
  margin-bottom: 20px;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

label {
  margin-bottom: 10px;
  display: block;
}

.icon-container {
  margin-bottom: 20px;
  padding: 7px 0;
  font-size: 24px;
}

.btn {
  background-color: #4CAF50;
  color: white;
  padding: 12px;
  margin: 10px 0;
  border: none;
  width: 100%;
  border-radius: 3px;
  cursor: pointer;
  font-size: 17px;
}

.btn:hover {
  background-color: #45a049;
}

a {
  color: #2196F3;
}

hr {
  border: 1px solid lightgrey;
}

span.price {
  float: right;
  color: grey;
}

/* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other (also change the direction - make the "cart" column go on top) */
@media (max-width: 800px) {
  .row {
    flex-direction: column-reverse;
  }
  .col-25 {
    margin-bottom: 20px;
  }
}
</style>
</head>
<h1><br> Available Books!</h1>
<br>

<%
	NumberFormat nf = NumberFormat.getCurrencyInstance();
	BookDB bk = new BookDB();
	ArrayList<Book> books = bk.selectAllBooks();
	
%>
<div class="row">

	<% 
	for(Book book : books) {
	%>	<div class="col-md-4" style="padding: 5px;">
			<div style="margin:3px; padding:10px; background-color: #eee;">
				<div class="row">
					<div class="col-md-4">
						<a href="./BookLookup?isbn=<%= book.getIsbn() %>" style="max-height: 130px; max-width: 110px;">
							<img src="./book_images/<%= book.getCoverImageFile()%>" alt="<%=book.getTitle()%> cover" style="max-width: inherit; max-height: inherit">
						</a>
					</div>
					<div class="col-md-8" style="text-align: left; padding-left:10px;">
						<h4><b><i><%=book.getTitle() %></i></b></h4>
						<h6><%=book.getAuthors() %></h6>
						<h5><b><%=nf.format(book.getPrice()) %></b></h5>
						<%if(book.getInventory()==0){ %>
						<h6><font color="red"><b>Out of Stock</b></font></h6>
						<%}else{ %>
						<h6>Quantity:&nbsp<%=book.getInventory() %></h6>
						<%} %>
					</div>
				</div>
			</div>
		</div>
	<%
	}
	%>
</div>

<%@ include file="footer.jsp" %>