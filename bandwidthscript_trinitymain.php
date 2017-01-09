#!/usr/bin/php
<?php

/* Input values for mysql server, username, password, and database. */
$server = "";
$username = "";
$password = "";
$database = "";

/* Connect to mysql server */
$mysqli = new mysqli("$server", "$username", "$password", "$database");

/* check connection */
if ($mysqli->connect_errno) {
    printf("Connect failed: %s\n", $mysqli->connect_error);
    exit();
}

/* This query joins the ntopv15 table with the mac_name table when the mac column in mac_name is equal to the ethAddressString column in ntopv15. It then selects the information in the descr column from mac_name and the ipv4BytesRcvd, ethAddressString, and created columns from ntopv15 when the ipv4BytesRcvd column has a value greater than 1000000000 and the created column has a timestamp between 12 hours ago and now. This also selects the information in the ipv4BytesRcvd, ethAddressString, and created columns from ntopv15 when the ip4BytesRcvd column has a value greater than 1000000000 and the created column has a timestamp between 12 hours ago and now and the mac address is not in the mac_name table. */ 
$query = "SELECT descr, bandwidth, MAC, created FROM (SELECT mac_name.descr as descr, ntopv15.ipv4BytesRcvd as bandwidth, ntopv15.ethAddressString as MAC, ntopv15.created as created FROM mac_name LEFT OUTER JOIN ntopv15 ON mac_name.mac = ntopv15.ethAddressString WHERE ntopv15.ipv4BytesRcvd > 1000000000 AND ntopv15.created > DATE_SUB(NOW(), INTERVAL 12 HOUR) UNION ALL SELECT null as descr, ntopv15.ipv4BytesRcvd as bandwidth, ntopv15.ethAddressString as MAC, ntopv15.created as created FROM ntopv15 WHERE (ntopv15.ipv4BytesRcvd > 1000000000 AND ntopv15.created > DATE_SUB(NOW(), INTERVAL 12 HOUR) AND NOT EXISTS (SELECT mac FROM mac_name WHERE mac_name.mac = ntopv15.ethAddressString))) as tmp ORDER BY created ASC";

/* Input your email address, the subject of the email, and starting message for information. Adds a return at the end. */
$email = 'julianrseidel@gmail.com';
$subject = 'Computers Exceeding Bandwidth';
$message = 'One or more computers have been exceeding the bandwidth for 15 minutes:' . "\xA";

/* Pull result of query. */
$result = $mysqli->query($query);

/* If you get a result and the result gives at least 1 row then do the following. */
if($result && $result->num_rows>=1) {
    /* fetch the associated row and if the same mac address shows up for 15 minutes, then add the descr, mac_address, and bandwidth values to the message. */
    $futMAC = NULL;
    $futDATE = NULL;
    $a = 1;
    while ($row = $result->fetch_assoc()) {
        $currentDate = strtotime($row["created"]);
        $curDATE = date("Y-m-d H:i", $currentDate);
        if ($row["MAC"] == $futMAC && $curDATE == $futDATE && $a < 4) {
                $a++;
        }
        if ($a == 4) {
                $message .= sprintf("Name: %s.\n  MAC Address: %s.\n  Bandwidth: %s.\n  Date: %s.\n\n", $row["descr"], $row["MAC"], $row["bandwidth"], $curDATE);
                $a = 1;
        }
        $futMAC = $row["MAC"];
        $futureDate = $currentDate+(60*5);
        $futDATE = date("Y-m-d H:i", $futureDate);
   }

   /* email the result to your email address. If a mac address shows up but didn't occur 3 times, you will get a blank email just so you know. */
 mail($email, $subject, $message);

    /* free result set */
    $result->free();
}

/* close connection */
$mysqli->close();

/* put the date that the script finished running into badwidthscript-endtime.txt */
$date = date("d/m : H:i :");
file_put_contents('/home/ntopv15/bandwidthscript-endtime.txt', $date);
?>
