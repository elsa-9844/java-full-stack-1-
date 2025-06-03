<%@page import="java.sql.*"%>
<%@page import="connection.jdbc_con"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userId = (String) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("/pratice1/login");
        return;
    }

    String cat = request.getParameter("a");
    String pay = request.getParameter("b");
    String date = request.getParameter("c");
    String amount = request.getParameter("d");

    String errorm = "";
    String success = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int catId = 0, payId = 0;

        switch (cat) {
            case "c1": catId = 1; break;
            case "c2": catId = 2; break;
            case "c3": catId = 3; break;
            case "c4": catId = 4; break;
            case "c5": catId = 5; break;
            case "c6": catId = 6; break;
            case "c7": catId = 7; break;
            case "c8": catId = 8; break;
            case "c9": catId = 9; break;
            case "c10": catId = 10; break;
        }

        switch (pay) {
            case "p1": payId = 1; break;
            case "p2": payId = 2; break;
            case "p3": payId = 3; break;
        }

        if (catId == 0 || payId == 0 || date == null || date.isEmpty() || amount == null || amount.isEmpty()) {
            errorm = "All fields are required";
        } else {
            try {
                jdbc_con jd = new jdbc_con();
                Connection con = jd.getConnection();
                String sql = "INSERT INTO expence (user_id, cat_id, payment_id, exp_date, amount) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, userId);
                ps.setInt(2, catId);
                ps.setInt(3, payId);
                ps.setString(4, date);
                ps.setString(5, amount);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    success = "Expense record inserted successfully!";
                }
                con.close();
            } catch (Exception e) {
                errorm = "Database error: " + e.getMessage();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>New Expense</title>
    <link rel="stylesheet" href="/pratice1/welcome.css">
    <link rel="icon" href="/pratice1/images/f.png" type="image/x-icon">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url("/pratice1/images/R.jpg") no-repeat center center fixed;
            background-size: cover;
            color: white;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 80px;
            background: rgba(0, 0, 0, 0.6);
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            margin-left: auto;
            margin-right: auto;
            box-shadow: 0px 0px 10px #fffefe;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        select, input[type="date"], input[type="number"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: none;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        .success {
            color: lightgreen;
            text-align: center;
            margin-top: 10px;
        }

        nav {
            background: transparent;
            backdrop-filter: blur(1px);
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0px 0px 10px #000;
        }

        nav ul {
            display: flex;
            list-style: none;
        }

        nav ul li {
            margin: 0 15px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        #logout-btn {
            background-color: red;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<nav>
    <a href="/pratice1/login">
        <img src="/pratice1/images/f.png" alt="logo" style="width: 50px; height: 50px;">
    </a>
    <ul>
        <li><a href="/pratice1/login">Home</a></li>
        <li><a href="/pratice1/views/exp.jsp">Expenses</a></li>
        <li><a href="#">Income</a></li>
    </ul>
    <button id="logout-btn">
        <a href="/pratice1/" style="color: white; text-decoration: none;">Sign Out</a>
    </button>
</nav>

<div class="container">
    <h2>New Expense</h2>
    <form method="post">
        <label for="a">Category:</label>
        <select id="a" name="a">
            <option value="">Select Category</option>
            <option value="c1" title="Rent or mortgage payments.">Housing</option>
            <option value="c2">Food</option>
            <option value="c3">Transportation</option>
            <option value="c4">Healthcare</option>
            <option value="c5">Utilities</option>
            <option value="c6">Entertainment</option>
            <option value="c7">Debt Repayment</option>
            <option value="c8">Education</option>
            <option value="c9">Personal Care</option>
            <option value="c10">Others</option>
        </select>

        <label for="b">Payment Method:</label>
        <select id="b" name="b">
            <option value="">Select Payment</option>
            <option value="p1">UPI</option>
            <option value="p2">Cash</option>
            <option value="p3">Others</option>
        </select>

        <label for="c">Date:</label>
        <input type="date" id="c" name="c" required>

        <label for="d">Amount:</label>
        <input type="number" id="d" name="d" placeholder="Amount" required>

        <input type="submit" value="Submit">
    </form>

    <% if (!errorm.isEmpty()) { %>
        <div class="error"><%= errorm %></div>
    <% } %>

    <% if (!success.isEmpty()) { %>
        <div class="success"><%= success %></div>
    <% } %>
</div>

</body>
</html>
