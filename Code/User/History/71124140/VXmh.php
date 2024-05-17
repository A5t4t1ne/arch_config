<?php

echo 'hello';

$directory = 'uploads/';
$files = scandir($directory);

echo '<div class="container">';
echo '<div class="row">';

foreach ($files as $file) {
    if ($file !== '.' && $file !== '..') {
        echo '<div class="col-md-6">';
        echo '<img src="' . $directory . $file . '" alt="' . $file . '" class="img-fluid" style="width: 100%; height: auto;">';
        echo '</div>';
    }
}

echo '</div>';
echo '</div>';

?>