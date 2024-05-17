<?php
session_start();

if(!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true){
    header('Location: login.php');
    exit;
}


if (isset($_FILES["pngToUpload"])) {
    $target_dir = "uploads/";
    $filename = basename($_FILES["pngToUpload"]["name"]);
    $ext = explode('.', $filename)[1];
    $target_file = $target_dir . $filename;
    $uploadOk = 1;

    if ($ext != 'png') {
        $msg = 'Sorry, only PNG files are allowed.';
        $uploadOk = 0;
    }else {
        if (move_uploaded_file($_FILES["pngToUpload"]["tmp_name"], $target_file)) {
            $msg = 'file uploaded successfully to ' . $target_file ;
            $uploadOk = 1;
        } else {
            $msg = 'Sorry, there was an error uploading your file.';
            $uploadOk = 0;
        }
    }
} else {
    $uploadOk = 0;
}
$color = $uploadOk ? 'green' : 'red';
?>

<!DOCTYPE html>
<html>
<body>

<h2>Upload File</h2>
<p style="color:$color;"><?php echo $msg; ?></p>
<form action="upload.php" method="post" enctype="multipart/form-data">
  Select picture to upload:
  <input type="file" name="pngToUpload" id="pngToUpload">
  <input type="submit" value="Upload File" name="submit">
</form>

</body>
</html>