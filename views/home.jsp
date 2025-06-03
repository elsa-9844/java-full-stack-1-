<%@page import="java.sql.*"%>
<%@page import="connection.jdbc_con"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Welcome</title>
    <link rel="stylesheet" type="text/css" href="welcome.css">
    <link rel="icon" href="/pratice1/images/f.png" type="image/x-icon">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url("/pratice1/images/R.jpg") no-repeat center center fixed;
            background-size: cover;
            color: white;
            margin: 0;
            padding: 0;
            text-align: center;
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
            padding: 0;
            display: flex;
        }

        nav ul li {
            margin: 0 15px;
            position: relative;
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
            margin-top: 50px;
            background: rgba(0, 0, 0, 0.6);
            padding: 30px;
            border-radius: 10px;
            display: inline-block;
            box-shadow: 0px 0px 10px #fffefe;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid white;
        }

        th {
            background: rgba(255, 255, 255, 0.3);
        }

        tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.2);
        }

        .user-tooltip {
            display: none;
            position: absolute;
            background-color: rgba(0, 0, 0, 0.9);
            color: #fff;
            padding: 15px;
            border-radius: 10px;
            top: 35px;
            left: 0;
            white-space: nowrap;
            z-index: 1;
            font-size: 14px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
        }

        .nav-user:hover .user-tooltip {
            display: block;
        }
    </style>
</head>
<body>

<%
    String userId = (String) session.getAttribute("user_id");
    String user_name = "", ph_no = "", email = "";

    if (userId == null) {
        response.sendRedirect("/pratice1/login");
        return;
    }

    jdbc_con jd = new jdbc_con();
    Connection con = null;
    String query = "SELECT * FROM user WHERE user_id = ?";

    try {
        con = jd.getConnection();
        try (PreparedStatement pstm = con.prepareStatement(query)) {
            pstm.setString(1, userId);
            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                user_name = rs.getString("user_name");
                ph_no = rs.getString("ph_no");
                email = rs.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<nav>
    <a href="/pratice1/login">
        <img src="/pratice1/images/f.png" alt="logo" style="width: 50px; height: 50px;">
    </a>
    <ul>
        <li><a href="/pratice1/login">Home</a></li>
        <li class="nav-user">
            <a href="#">User</a>
            <div class="user-tooltip">
                <strong>Name:</strong> <%= user_name %><br>
                <strong>Phone:</strong> <%= ph_no %><br>
                <strong>Email:</strong> <%= email %>
            </div>
        </li>
        <li><a href="/pratice1/views/exp.jsp">Expenses</a></li>
        <li><a href="/pratice1/views/income.jsp">Income</a></li>
    </ul>
    <button id="logout-btn">
        <a href="/pratice1/" style="color: white; text-decoration: none;">Sign Out</a>
    </button>
</nav>

<div class="container">
    <h2>Welcome to Your Dashboard</h2>
    <table>
        <tr>
            <th>User ID</th>
            <th>User Name</th>
            
        </tr>
        <tr>
            <td><%= userId %></td>
            <td><%= user_name %></td>
            
        </tr>
    </table>
</div>

</body>
</html>
