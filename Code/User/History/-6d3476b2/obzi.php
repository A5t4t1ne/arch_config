<!DOCTYPE html>
<html>
<head>
<style>
body {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin: 0;
  background-color: #f0f0f0;
}

.container {
  width: 300px;
  padding: 16px;
  background-color: white;
  border: 1px solid #ccc;
  border-radius: 4px;
}

input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
}

button:hover {
  opacity: 0.8;
}
</style>
</head>
<body>

<h2>Login</h2>
<?php

$uname = $_POST['uname'];
$psw = $_POST['psw'];

// Here you would typically check the username and password against a database
// For simplicity, we're just checking against hardcoded values
if($uname == 'admin' && $psw == 'password') {
    echo 'Login successful';
} else if ($uname != ''){
    echo 'Login failed';
}


?>
<form method="post" action="login.php">
  <div class="container">
    <label for="uname"><b>Username</b></label>
    <input type="text" placeholder="Enter Username" name="uname" required>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" required>

    <button type="submit">Login</button>
  </div>
</form>

</body>
</html>