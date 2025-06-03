<%@ page import="java.sql.*" %>
<%@ page import="connection.jdbc_con" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Expense Table</title>
    <link rel="stylesheet" href="expud.css">
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
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            width: 90%;
            box-shadow: 0px 0px 10px #fff;
            color: white;
        }

        h2 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid white;
            text-align: center;
        }

        th {
            background: rgba(255, 255, 255, 0.3);
        }

        tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.2);
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .button-container a {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .button-container a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%
    String userId = (String) session.getAttribute("user_id");
%>

<nav>
    <a href="/pratice1/views/home.jsp"><img src="/pratice1/images/f.png" alt="logo" style="width: 50px; height: 50px;"></a>
    <ul>
        <li><a href="/pratice1/views/home.jsp">Home</a></li>
        <li><a href="#">User</a></li>
        <li><a href="expenses.jsp">Expenses</a></li>
        <li><a href="#">Income</a></li>
    </ul>
    <button id="logout-btn"><a href="/pratice1/" style="color: white; text-decoration: none;">Sign Out</a></button>
</nav>

<div class="container">
    <h2>Expense Table</h2>
    <div class="button-container">
        <a href="/pratice1/views/home.jsp">Home</a>
        <a href="/pratice1/views/newexp.jsp">New Expense</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>Expense ID</th>
                <th>Category</th>
                <th>Payment Method</th>
                <th>Date</th>
                <th>Amount</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                jdbc_con jd = new jdbc_con();
                Connection con = null;
                try {
                    con = jd.getConnection();
                    String query = "SELECT * FROM expence WHERE user_id=?;";
                    try (PreparedStatement ps = con.prepareStatement(query)) {
                        ps.setString(1, userId);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            String expId = rs.getString("exp_id");
                            String catId = rs.getString("cat_id");
                            String payId = rs.getString("payment_id");
                            String date = rs.getString("exp_date");
                            String amount = rs.getString("amount");
            %>
            <tr>
                <td><%= expId %></td>
                <td><%= catId %></td>
                <td><%= payId %></td>
                <td><%= date %></td>
                <td><%= amount %></td>
                <td>
                    <a href="/pratice1/views/updateexp.jsp?id=<%= expId %>" class="button" style="color: white;">Update</a>
                    <a href="/pratice1/views/deleteexp.jsp?id=<%= expId %>" class="button" style="color: white;">Delete</a>
                </td>
            </tr>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>
