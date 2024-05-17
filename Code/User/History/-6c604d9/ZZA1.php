<?php
session_start();

if (!isset ($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

$msg = 0;

if (isset ($_FILES["pngToUpload"])) {
    $target_dir = "images/";

    $filename = basename($_FILES["pngToUpload"]["name"]);
    $ext = explode('.', $filename)[1];
    $target_file = $target_dir . $filename;
    $uploadOk = 1;

    if ($ext != 'png') {
        $msg = 'Sorry, only .png files are allowed.';
        $uploadOk = 0;
    } else {
        if (move_uploaded_file($_FILES["pngToUpload"]["tmp_name"], $target_file)) {
            $msg = 'file uploaded successfully to ' . $target_file;
            $uploadOk = 1;
        } else {
            $msg = 'Sorry, there was an error uploading your file.';
            $uploadOk = 0;
        }
    }
} else {
    $uploadOk = 0;
}
$alertType = $uploadOk ? 'success' : 'danger';
?>

<!DOCTYPE html>
<html>

<head>
    <title>Guardians Gallery - Upload</title>
    <link rel="stylesheet" href="./bootstrap-5.3.3-dist/css/bootstrap.min.css">
</head>

<body>

<div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="text-center mt-5">Upload Picture</h2>
                <hr class="my-4">
                <?php if ($msg) { ?>
                    <p class="alert alert-<?php echo $alertType; ?>"><?php echo $msg; ?></p>
                <?php } ?>
                <form action="upload.php" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="pngToUpload">Select picture to upload:</label>
                        <input type="file" class="form-control-file" id="pngToUpload" name="pngToUpload">
                    </div>
                    <button type="submit" class="btn btn-primary" name="submit">Upload File</button>
                </form>
            </div>
        </div>
    </div>

    <script src="./bootstrap-5.3.3-dist/js/bootstrap.min.js"></script>
</body>

</html>