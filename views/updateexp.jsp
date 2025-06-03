<%@ page import="java.sql.*" %>
<%@ page import="connection.jdbc_con" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String errorMsg = "";
    String successMsg = "";
    String cat = "", pay = "", date = "", amount = "";
    String id = request.getParameter("id");

    if (id == null || id.isEmpty()) {
        response.sendRedirect("/pratice1/views/exp.jsp");
        return;
    }

    jdbc_con jd = new jdbc_con();
    Connection con = jd.getConnection();

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String a = request.getParameter("a");
        String b = request.getParameter("b");
        String c = request.getParameter("c");
        String d = request.getParameter("d");

        int e = 0, f = 0;

        if (a != null) e = Integer.parseInt(a.replace("c", ""));
        if (b != null) f = Integer.parseInt(b.replace("p", ""));

        if (e == 0 || f == 0 || c == null || c.isEmpty() || d == null || d.isEmpty()) {
            errorMsg = "All fields are required.";
        } else {
            String updateQuery = "UPDATE expence SET cat_id=?, payment_id=?, exp_date=?, amount=? WHERE exp_id=?";
            try (PreparedStatement ps = con.prepareStatement(updateQuery)) {
                ps.setInt(1, e);
                ps.setInt(2, f);
                ps.setString(3, c);
                ps.setDouble(4, Double.parseDouble(d));
                ps.setString(5, id);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    successMsg = "Expense updated successfully!";
                    response.sendRedirect("/pratice1/views/exp.jsp");
                    return;
                } else {
                    errorMsg = "Update failed.";
                }
            }
        }
    }

    // Fetching existing data
    String query = "SELECT * FROM expence WHERE exp_id=?";
    try (PreparedStatement ps = con.prepareStatement(query)) {
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            cat = rs.getString("cat_id");
            pay = rs.getString("payment_id");
            date = rs.getString("exp_date");
            amount = rs.getString("amount");
        } else {
            response.sendRedirect("/pratice1/views/exp.jsp");
            return;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Expense</title>
    <link rel="stylesheet" href="views/expud.css">
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
            margin-bottom: 30px;
        }

        label, select, input {
            display: block;
            width: 100%;
            margin-bottom: 15px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .message {
            text-align: center;
            margin-top: 10px;
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
        <li><a href="#">User</a></li>
        <li><a href="/pratice1/views/exp.jsp">Expenses</a></li>
        <li><a href="#">Income</a></li>
    </ul>
    <button id="logout-btn"><a href="/pratice1/" style="color: white; text-decoration: none;">Sign Out</a></button>
</nav>

<div class="container">
    <h2>Update Expense</h2>
    <form method="post">
        <label>Category:</label>
        <select name="a">
            <option value="c1" <%= cat.equals("1") ? "selected" : "" %>>Housing</option>
            <option value="c2" <%= cat.equals("2") ? "selected" : "" %>>Food</option>
            <option value="c3" <%= cat.equals("3") ? "selected" : "" %>>Transportation</option>
            <option value="c4" <%= cat.equals("4") ? "selected" : "" %>>Healthcare</option>
            <option value="c5" <%= cat.equals("5") ? "selected" : "" %>>Utilities</option>
            <option value="c6" <%= cat.equals("6") ? "selected" : "" %>>Entertainment</option>
            <option value="c7" <%= cat.equals("7") ? "selected" : "" %>>Debt Repayment</option>
            <option value="c8" <%= cat.equals("8") ? "selected" : "" %>>Education</option>
            <option value="c9" <%= cat.equals("9") ? "selected" : "" %>>Personal Care</option>
            <option value="c10" <%= cat.equals("10") ? "selected" : "" %>>Others</option>
        </select>

        <label>Payment Method:</label>
        <select name="b">
            <option value="p1" <%= pay.equals("1") ? "selected" : "" %>>UPI</option>
            <option value="p2" <%= pay.equals("2") ? "selected" : "" %>>Cash</option>
            <option value="p3" <%= pay.equals("3") ? "selected" : "" %>>Others</option>
        </select>

        <label>Date:</label>
        <input type="date" name="c" value="<%= date %>">

        <label>Amount:</label>
        <input type="number" name="d" value="<%= amount %>">

        <input type="submit" value="Update">
    </form>

    <% if (!errorMsg.isEmpty()) { %>
        <div class="message" style="color: red;"><%= errorMsg %></div>
    <% } %>
    <% if (!successMsg.isEmpty()) { %>
        <div class="message" style="color: green;"><%= successMsg %></div>
    <% } %>
</div>

</body>
</html>
