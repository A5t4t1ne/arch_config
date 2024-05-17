<?php
session_start();

if(!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true){
    header('Location: login.php');
    exit;
}


function isValidFileName($fileName) {
    return !preg_match('/[\/:*?"<>|]/', $fileName);
}

$fileName = "test.txt";

if(isValidFileName($fileName)) {
    echo "Valid file name";
} else {
    echo "Invalid file name";
}


?>

<!DOCTYPE html>
<html>
<body>

<h2>Upload File</h2>

<form action="upload.php" method="post" enctype="multipart/form-data">
  Select file to upload:
  <input type="file" name="fileToUpload" id="fileToUpload">
  <input type="submit" value="Upload File" name="submit">
</form>

</body>
</html>