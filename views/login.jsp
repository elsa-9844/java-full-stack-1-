<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Project</title>
    
    <link rel="icon" href="/pratice1/images/f.png" type="image/x-icon">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script>
        function setAction(action) {
            document.forms["form"].action = action;
        }
    </script>
    <style>
        *{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: "poppins" sans-serif;

}
#body{
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background: url("/pratice1/images/R.jpg") no-repeat;
    background-size: cover;
    background-position:center ;
    
}
#form{
    width: 420px;
    background: transparent;
    border: 2px solid #fff;
    backdrop-filter: blur(20px);
    box-shadow: 0,0,10px rgba(0, 0, 0, 0);
    color: #fff;
    border-radius: 10px;
    padding: 30px 40px;
}
#form h1{
    font-size: 36px;
    text-align: center;
}
#form .d1{
    position: relative;
    width: 98%;
    height: 50px;
    margin: 30px 0;
}

#i1{
    position: relative;
    width:90%;
    height: 1px;
    background: transparent;
    border: none;
    outline: none;
    border: 2px solid #fff;
    border-radius: 40px;

    font-size: 16px;
    color: #fff;
    padding: 20px 45px 20px 20px ;
}
#i1::placeholder{
    color: #fff;
}
#e{
    width: 49%;
    height: 45px;
    background: #fff;
    border: none;
    outline: none;
    border-radius: 40px;
    box-shadow: 0 0 10px #fff;
    cursor: pointer;
    font-size: 16px;
    font-weight: 600;
}
#d1 i{
    top: 50%;
    right: 40px;
    transform: translateY(5%);
    position:relative;
}
.error {
      color: red;
      text-align: center;
      margin-bottom: 10px;
    }
    </style>
</head>

<body id="body">
    <div id="form">
    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="error"><%= error %></div>
    <% } %>
        <form action="login" name="form" method="post">
            <h1>Login</h1>
            <hr><br>
            <div id="d1">
                <input id="i1" type="text" name="userid" placeholder="User ID :" required>
                <i id="i" class='bx bxs-user'></i><br><br>
            </div>
            <div id="d1">
                <input id="i1" type="password" name="password" placeholder="Password :" required>
                <i id="i9" class='bx bxs-lock-alt'></i><br><br>
            </div>
            <button id="e" type="submit">Login</button>
			<button id="e" type="button" onclick="window.location.href='views/sigin.jsp'">Signup</button>

        </form>
    </div>
</body>
</html>
