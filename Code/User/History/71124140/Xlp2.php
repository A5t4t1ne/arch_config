<?php

echo 'hello';

$directory = 'uploads/';
$files = scandir($directory);

foreach ($files as $file) {
    if ($file !== '.' && $file !== '..') {
        echo '<img src="' . $directory . $file . '" alt="' . $file . '">';
    }
}
?>