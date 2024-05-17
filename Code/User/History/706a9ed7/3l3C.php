<?php
session_start();

$uname = $_POST['uname'];
$psw = $_POST['psw'];

// check hardcoded credentials
if($uname == 'guest' && $psw == 'Ju57_4_R4nd0m_1337_57r1n9!') {
    echo 'Login successful';
    $_SESSION['loggedin'] = true;
    header('Location: upload.php');
} else if ($uname != ''){
    $error = 'Invalid credentials or insufficient permissions';
}
?>


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
<form method="post" action="login.php">
  <div class="container">
    <?php if($error): ?>
        <p style="color:red;"><?php echo $error; ?></p>
    <?php endif; ?>
    <label for="uname"><b>Username</b></label>
    <input type="text" placeholder="Enter Username" name="uname" required>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" required>

    <button type="submit">Login</button>
  </div>
</form>

</body>
</html>