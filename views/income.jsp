<%@ page import="java.sql.*" %>
<%@ page import="connection.jdbc_con" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userId = (String) session.getAttribute("user_id");
    String message = "";
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String income = request.getParameter("income");
        String budget = request.getParameter("budget");

        if (income != null && budget != null && !income.isEmpty() && !budget.isEmpty()) {
            try {
                jdbc_con jd = new jdbc_con();
                Connection con = jd.getConnection();
                
                String query = "INSERT INTO income (user_id, u_income, b_limit) VALUES (?, ?, ?) " +
                               "ON DUPLICATE KEY UPDATE u_income = VALUES(u_income), b_limit = VALUES(b_limit)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, userId);
                ps.setString(2, income);
                ps.setString(3, budget);
                ps.executeUpdate();
                message = "Income details saved successfully!";
            } catch (Exception e) {
                e.printStackTrace();
                message = "Error saving income details.";
            }
        } else {
            message = "Please fill in all fields.";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Monthly Income</title>
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

        nav {
            background: transparent;
            backdrop-filter: blur(1px);
            padding: 15px;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0px 0px 10px #000;
        }

        nav ul {
            list-style: none;
            display: flex;
        }

        nav ul li {
            margin: 0 15px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
        }

        #logout-btn {
            background-color: red;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .container {
            background: rgba(0, 0, 0, 0.6);
            margin: 80px auto;
            padding: 40px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0px 0px 15px #fff;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 18px;
            margin-bottom: 5px;
        }

        input[type="number"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: none;
            outline: none;
        }

        .btn-submit {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn-submit:hover {
            background-color: #0056b3;
        }

        .message {
            margin-top: 15px;
            font-weight: bold;
            color: yellow;
        }
    </style>
</head>
<body>

<nav>
    <a href="/pratice1/views/home.jsp"><img src="/pratice1/images/f.png" alt="logo" style="width: 50px; height: 50px;"></a>
    <ul>
        <li><a href="/pratice1/views/home.jsp">Home</a></li>
        <li><a href="expenses.jsp">Expenses</a></li>
        <li><a href="#">Income</a></li>
    </ul>
    <button id="logout-btn"><a href="/pratice1/" style="color: white; text-decoration: none;">Sign Out</a></button>
</nav>

<div class="container">
    <h2>Enter Monthly Income</h2>
    <form method="post">
        <div class="form-group">
            <label for="income">Monthly Income (₹):</label>
            <input type="number" id="income" name="income" required>
        </div>
        <div class="form-group">
            <label for="budget">Budget Limit (₹):</label>
            <input type="number" id="budget" name="budget" required>
        </div>
        <input type="submit" class="btn-submit" value="Save">
    </form>
    <div class="message"><%= message %></div>
</div>

</body>
</html>
