<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery</title>

    <link rel="stylesheet" href="./bootstrap-5.3.3-dist/css/bootstrap.min.css">
</head>

<body>

<h1 class="display-4 mt-5">Gallery!</h1>

    <?php

    $directory = 'uploads/';
    $files = scandir($directory);

    echo '<div class="container">';
    echo '<div class="row row-cols-2">';

    foreach ($files as $file) {
        if ($file !== '.' && $file !== '..') {
            echo '<div class="col">';
            echo '<img src="' . $directory . $file . '" alt="' . $file . '" class="img-fluid" style="width: 100%; height: auto;">';
            echo '</div>';
        }
    }

    echo '</div>';
    echo '</div>';

    ?>

    <script src="./bootstrap-5.3.3-dist/js/bootstrap.min.js"></script>

</body>

</html>