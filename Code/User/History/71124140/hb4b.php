<?php

echo 'hello';

$directory = 'uploads/';
$files = scandir($directory);

echo '<div class="container">';
echo '<div class="row row-cols-2">';

foreach ($files as $file) {
    if ($file !== '.' && $file !== '..') {
        echo '<div class="col">';
        echo '<img src="' . $directory . $file . '" alt="' . $file . '" class="img-fluid" style="width: 33%; height: auto;">';
        echo '</div>';
    }
}

echo '</div>';
echo '</div>';

?>