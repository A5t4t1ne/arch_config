<?php
session_start();

if(!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true){
    header('Location: login.php');
    exit;
}


function isValidFileName($fileName) {
    return !preg_match('/[\/:*?"<>|]/', $fileName);
}

// $fileName = "test.txt";

// if(isValidFileName($fileName)) {
//     echo "Valid file name";
// } else {
//     echo "Invalid file name";
// }

if (isset($_PFILES["pngToUpload"])) {
    $target_dir = "uploads/";
    $target_file = $target_dir . basename($_FILES["pngToUpload"]["name"]);
    $uploadOk = 1;
    
    echo 'file ' . $target_file . ' uploaded successfully';
    // if (move_uploaded_file($_FILES["pngToUpload"]["tmp_name"], $target_file)) {
    //     echo "The file ". basename( $_FILES["pngToUpload"]["name"]). " has been uploaded.";
    // } else {
    //     echo "Sorry, there was an error uploading your file.";
    // }
    
}else {
    echo 'file not uploaded';
}
?>

<!DOCTYPE html>
<html>
<body>

<h2>Upload File</h2>

<form action="upload.php" method="post" enctype="multipart/form-data">
  Select picture to upload:
  <input type="file" name="pngToUpload" id="pngToUpload">
  <input type="submit" value="Upload File" name="submit">
</form>

</body>
</html>