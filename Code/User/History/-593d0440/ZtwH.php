<?php

// $UNAMES = array('Starlord', 'user2');
// $USERS = array($UNAMES[0] => 'MyDadIsAFrickingCelestial', $UNAMES[1] => 'password2');

// header($UNAMES[0] . $USERS[$UNAMES[0]]);


// # catch GET requests
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    # display simple message
    echo '<h1>Hello Guardians of the Galaxy</h1>';
    echo '<p>I created this website so we can share all the images of all the adventures we\'ve been through</p>';
    exit;
}

?>

