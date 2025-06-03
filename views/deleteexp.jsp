<%@ page import="java.sql.*" %>
<%@ page import="connection.jdbc_con" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userId = (String) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("/pratice1/login");
        return;
    }

    String idParam = request.getParameter("id");
    String errorm = "";
    String success = "";

    if (idParam == null || idParam.trim().isEmpty()) {
        response.sendRedirect("/pratice1/views/exp.jsp");
        return;
    }

    int expId = Integer.parseInt(idParam);

    try {
        jdbc_con jd = new jdbc_con();
        Connection con = jd.getConnection();

        // Check if record exists
        PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM expence WHERE exp_id = ?");
        checkStmt.setInt(1, expId);
        ResultSet rs = checkStmt.executeQuery();

        if (!rs.next()) {
            response.sendRedirect("/pratice1/views/exp.jsp");
            return;
        }

        // Delete record
        PreparedStatement deleteStmt = con.prepareStatement("DELETE FROM expence WHERE exp_id = ?");
        deleteStmt.setInt(1, expId);

        int rowsAffected = deleteStmt.executeUpdate();
        if (rowsAffected > 0) {
            success = "Expense record deleted successfully.";
            response.sendRedirect("/pratice1/views/exp.jsp");
            return;
        } else {
            errorm = "Error deleting expense.";
        }

        con.close();
    } catch (Exception e) {
        errorm = "Database error: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Expense</title>
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
            margin-top: 100px;
            background: rgba(0, 0, 0, 0.6);
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            margin-left: auto;
            margin-right: auto;
            text-align: center;
            box-shadow: 0px 0px 10px #fffefe;
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        .success {
            color: lightgreen;
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
    <h2>Delete Expense</h2>
    <% if (!errorm.isEmpty()) { %>
        <div class="error"><%= errorm %></div>
    <% } %>

    <% if (!success.isEmpty()) { %>
        <div class="success"><%= success %></div>
    <% } %>
</div>

</body>
</html>
