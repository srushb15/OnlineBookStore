<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<head>
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

input[type=text],select {
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
<script>
function validateForm() {
  if (document.getElementById("cname").value == "") {
    alert("Card Name must be filled out");
    return false;
  }
  if (document.getElementById("ccnum").value == "") {
	    alert("Card Number must be filled out");
	    return false;
	}
  if (document.getElementById("cvv").value == "") {
	    alert("CVV must be filled out");
	    return false;
	}
}
</script>
</head>

<jsp:useBean id="cart" scope="session" class="com.bookstore.models.Cart"></jsp:useBean>
<h1>Bookstore Checkout/Cart Page</h1>
	<%
	if (request.getParameter("quanErr") != null) {
		%>
	<div class="alert alert-danger" style="max-width: 330px; margin: 0 auto" role="alert">There wasn't enough inventory to process your order. Please review your updated cart and proceed.</div>
		<%
	}
	%>
	<c:if test="${not empty cart.items}">
	<table class="table table-striped">
		<thead>
			<th>Qty</th>
			<th>Title</th>
			<th>Price</th>
			<th>Total Price</th>
			<th></th>
		</thead>
		<tbody>
		<c:forEach var="item" items="${cart.items}">
		<form action="./cartUpdate" method="post">
		<tr style="text-align: left">
			<td>
					<input type="hidden" name="isbn" value="${item.isbn}">
					<input type="text" size="2" name="quantity" value="${item.quantity}">
					<input type="submit" value="Update">
			</td>
			<td>${item.title}</td>
			<td>${item.price}</td>
			<td>${item.totalPrice}</td>
			<td><input type="submit" name="remove" value="Remove"></td>
		</tr>
	</form>
	</c:forEach>
	</tbody>
	</table>
	
	<div class="col-50">
         <h3>Payment</h3>
         <label for="fname">Accepted Cards</label>
         <div class="icon-container">
            <i class="fa fa-cc-visa" style="color:navy;"></i>
            <i class="fa fa-cc-amex" style="color:blue;"></i>
            <i class="fa fa-cc-mastercard" style="color:red;"></i>
            <i class="fa fa-cc-discover" style="color:orange;"></i>
         </div>
         <label for="cname">Name on Card</label>
         <input type="text" id="cname" name="cardname" placeholder="John More Doe" required maxlength="50">
         <label for="ccnum">Credit card number</label>
         <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444" required maxlength="16">
         <label for="expmonth">Exp Month</label>
         <!-- <input type="text" id="expmonth" name="expmonth" placeholder="September" required="required"> -->
         <select type="text" placeholder="September" required>
             <option selected value='1'>January</option>
    <option value='2'>February</option>
    <option value='3'>March</option>
    <option value='4'>April</option>
    <option value='5'>May</option>
    <option value='6'>June</option>
    <option value='7'>July</option>
    <option value='8'>August</option>
    <option value='9'>September</option>
    <option value='10'>October</option>
    <option value='11'>November</option>
    <option value='12'>December</option>
    </select><br><br>
         
            <div class="col-50">
               <label for="expyear">Exp Year</label>
               <!-- <input type="text" id="expyear" name="expyear" placeholder="2018" required="required"> -->
               <select type="text" placeholder="2018" required>
               		<% for(int y=2020; y<=2035; y++){%>
  					<option><%=y%></option>
					<%}%>
               </select>
            </div><br><br>
            <div class="col-50">
               <label for="cvv">CVV</label>
               <input type="text" id="cvv" name="cvv" placeholder="352" required maxlength="3">
            </div>
        
      </div>
	
	<form action="./submitOrder" method="post" onsubmit="return validateForm()">
		<input type="submit" class="btn btn-default" value="Checkout">
	</form>	
	</c:if>
	<c:if test="${empty cart.items}">
		<h2>Cart is empty</h2>
	</c:if>
<form action="./index.jsp" method="post">
	<input type="submit" class="btn btn-default" value="Continue Shopping">
</form>
<%@ include file="footer.jsp" %>