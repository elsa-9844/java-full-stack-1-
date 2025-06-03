<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up</title>
  <link rel="icon" href="/pratice1/images/f.png" type="image/x-icon">

  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: Arial, Helvetica, sans-serif;
      background: url("/pratice1/images/R.jpg") no-repeat center center fixed;
      background-size: cover;
      color: white;
      text-align: center;
    }

    .form-container {
      width: 40%;
      margin: 100px auto;
      background: transparent;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0px 0px 10px #000;
      backdrop-filter: blur(3px);
    }

    h2 {
      margin-bottom: 20px;
    }

    form {
      max-width: 400px;
      margin: auto;
      text-align: left;
    }

    label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
      color: white;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"],
    input[type="tel"] {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: none;
      border-radius: 5px;
      background: rgba(255, 255, 255, 0.8);
      color: black;
    }

    .gender-group {
      margin-top: 10px;
    }

    .gender-group label {
      font-weight: normal;
      margin-right: 15px;
      color: white;
    }

    .submit-btn {
      margin-top: 20px;
      width: 100%;
      padding: 12px;
      background-color: #4caf50;
      color: white;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }

    .submit-btn:hover {
      background-color: #45a049;
    }

    .error {
      color: red;
      text-align: center;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>

  <div class="form-container">
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="error"><%= error %></div>
    <% } %>

    <h2>Sign Up</h2>
    <form action="<%=request.getContextPath() %>/sigin" method="post">
      <label for="name">Full Name</label>
      <input type="text" id="name" name="name" required>

      <label for="userid">User ID</label>
      <input type="text" id="userid" name="userid" required>

      <label for="password">Password</label>
      <input type="password" id="password" name="password" required>

      <label for="phone">Phone Number</label>
      <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required>

      <label for="email">Email ID</label>
      <input type="email" id="email" name="email" required>

      <label>Gender</label>
      <div class="gender-group">
        <label><input type="radio" name="gender" value="Male" required> Male</label>
        <label><input type="radio" name="gender" value="Female" required> Female</label>
        <label><input type="radio" name="gender" value="Other" required> Other</label>
      </div>

      <button type="submit" class="submit-btn">Register</button>
    </form>
  </div>

</body>
</html>
