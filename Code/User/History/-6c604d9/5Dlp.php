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
    

    $msg = 'file ' . $target_file . ' uploaded successfully';
    $msg += 'file extension: ' . $ext;
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
<?php if($uploadOk): ?>
    <p style="color:green;"><?php echo $msg; ?></p>
<?php endif; ?>
<form action="upload.php" method="post" enctype="multipart/form-data">
  Select picture to upload:
  <input type="file" name="pngToUpload" id="pngToUpload">
  <input type="submit" value="Upload File" name="submit">
</form>

</body>
</html>