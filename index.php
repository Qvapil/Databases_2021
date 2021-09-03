<html>
<head>
  <style>
h1 {text-align: center;}

table{
     margin:0 10px;
}
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
td, th {
  padding: 3px;
  text-align: center;
}
th {
  background-color: #00008B;
  color: white;
}
tr:nth-child(odd){background-color: #f2f2f2}
table.center {
  margin-left: auto;
  margin-right: auto;
}
caption {font-size: 130%; font-weight: bold;}
</style>
</head>
<body style="background-color:powderblue;">
<h1>Hotel</h1>

<?php

//TYPE SERVER NAME, USERNAME AND PASSWORD FOR SQL AUTHENTICATION
$server_nm ="";
$connection = array("Database"=>"hotel","UID"=>"", "PWD"=>"");
$conn = sqlsrv_connect( $server_nm, $connection);

if( $conn ) {
  //echo "Connection established!";
} else {
  echo "Connection failed";
  die(print_r(sqlsrv_errors(),true));
}

//question 7 from this form
//get service from radio buttons and dates from text box
echo' <form method="post">
  <b>Select service and date interval</b> (for best results pick dates between 2021-05-05 and 2021-05-25)<br>
  <input type="radio" id="conf" name="serviceid" value="2">Conference rooms<br>
  <input type="radio" id="gym" name="serviceid" value="3">Gyms<br>
  <input type="radio" id="sauna" name="serviceid" value="4">Saunas<br>
  <input type="radio" id="hair" name="serviceid" value="5">Hair salons<br>
  <input type="radio" id="bar" name="serviceid" value="6">Bars<br>
  <input type="radio" id="food" name="serviceid" value="7">Restaurants<br>
  Starting date: <input type="text" name="date1"><br>
  Ending date: <input type="text" name="date2"><br>
  <input type="submit" value="Submit">
</form> ';
//a service is required to be selected
//dates have default values if empty
if (isset($_POST['serviceid'])) {
  if(empty($_POST['date1'])) {
    $_POST['date1']='2021-05-05';
  }
  if(empty($_POST['date2'])) {
    $_POST['date2']='2021-05-25';
  }
//query to get all visits to selected service in chosen date interval
  $q7="select distinct A.Area_name, C.Charge_amount,
  convert(varchar(25),V.Visit_datetime) as Visit_datetime,
  convert(varchar(25),V.Exit_datetime) as Exit_datetime
  from Provided_at as P, Visits as V, Charge as C, Area as A
  where A.Area_ID=V.Area_ID and
	  V.Area_ID=P.Area_ID and
	  C.Service_ID=P.Service_ID and
	  Visit_datetime between '".$_POST['date1']."' and '".$_POST['date2']."'
	  and P.Service_ID=".$_POST['serviceid']."
  order by Visit_datetime asc";

  $stmt7=sqlsrv_query($conn,$q7);

//table for all visits, including cost and date
  echo'
  <table class="center">
      <caption>All visits to this service</caption>
      <thead>
          <tr>
              <th>Area</th>
              <th>Charge</th>
              <th>Date and time of entry</th>
              <th>Date and time of exit</th>
          </tr>
      </thead>
      <tbody>';
          while ($row = sqlsrv_fetch_array($stmt7, SQLSRV_FETCH_ASSOC)) {
              echo'<tr>';
              echo'<td>'. $row['Area_name'].'</td>';
              echo'<td>'. $row['Charge_amount'].'</td>';
              echo'<td>'. $row['Visit_datetime'].'</td>';
              echo'<td>'. $row['Exit_datetime'].'</td>';
              echo'<tr>';
          }
     echo'</tbody>
  </table>';

}

//question 8 from this form
//Get view from radio buttons
echo'<br>
 <form method="post">
  <b>Select type of information</b> <br>
  <input type="radio" name="sinfo">Sales per service<br>
  <input type="radio" name="cinfo">Customer information<br>
  <input type="submit" value="Submit">
</form> ';

if (!empty($_POST['sinfo'])) {
  //query to see all sales by services
  $q81 = "select Revenue, Charge_description, Count
          from [Service Info]";
  $stmt81=sqlsrv_query($conn,$q81);

  if ($stmt81==false) {
    die( print_r( sqlsrv_errors(),true));
  }
  //table to see all sales by service
  echo'
  <table class="center">
    <caption>Sales per service</caption>
    <thead>
      <tr>
          <th>Total revenue</th>
          <th>Charge description</th>
          <th>Number of sales</th>
      </tr>
    </thead>
    <tbody>';
      while ($row = sqlsrv_fetch_array($stmt81, SQLSRV_FETCH_ASSOC)) {
          echo'<tr>';
          echo'<td>'. $row['Revenue'].'</td>';
          echo'<td>'. $row['Charge_description'].'</td>';
          echo'<td>'. $row['Count'].'</td>';
          echo'<tr>';
      }
      echo'</tbody>
    </table> <br>';
}

if (!empty($_POST['cinfo'])){
  //query to see all customer info
  $q82 = "select Surname, Name, convert(varchar(25),Birthdate) as Birthdate, Phone, Email
          from [Customer Info]";
  $stmt82=sqlsrv_query($conn,$q82);

  if ($stmt82==false) {
    die( print_r( sqlsrv_errors(),true));
  }

  //table to see all customer information
  echo'
  <table class="center">
      <caption>Customer information</caption>
      <thead>
          <tr>
              <th>Surname</th>
              <th>Name</th>
              <th>Date of birth</th>
              <th>Phone number</th>
              <th>Email</th>
          </tr>
      </thead>
      <tbody>';
          while ($row = sqlsrv_fetch_array($stmt82, SQLSRV_FETCH_ASSOC)) {
              echo'<tr>';
              echo'<td>'. $row['Surname']."</td>";
              echo'<td>'. $row['Name'].'</td>';
              echo'<td>'. $row['Birthdate'].'</td>';
              echo'<td>'. $row['Phone'].'</td>';
              echo'<td>'. $row['Email'].'</td>';
              echo'<tr>';
          }
          echo'</tbody>
        </table> <br>';
}

//questions 9,10 from this form
//give NFC ID of customer with covid and get all visits and possible infections
echo'<br>
<form method="post">
  <b>Write the NFC ID of the customer with Covid</b><br>
  <input type="text" id="nfcid" name="nfcid"><br>
  <input type="submit" value="Submit">
</form> ';
//check if integer was given
if(!empty($_POST['nfcid']) and is_numeric($_POST['nfcid'])) {
  //query to get all visits of infected customer
  $q9="select A.Area_name, convert(varchar(25),V.Visit_datetime) as Visit_datetime,
  convert(varchar(25),V.Exit_datetime) as Exit_datetime
  from Visits as V, Area as A
  where V.Area_ID=A.Area_ID and
	  V.NFC_ID=".$_POST['nfcid']."
    order by Visit_datetime";

  $stmt9=sqlsrv_query($conn,$q9);

  //table to see all visits of infected customer
  echo'
  <table style="float:left;">
      <caption>All visits by this customer</caption>
      <thead>
          <tr>
              <th>Area</th>
              <th>Date and time of entry</th>
              <th>Date and time of exit</th>
          </tr>
      </thead>
      <tbody>';
          while ($row = sqlsrv_fetch_array($stmt9, SQLSRV_FETCH_ASSOC)) {
              echo'<tr>';
              echo'<td>'. $row['Area_name'].'</td>';
              echo'<td>'. $row['Visit_datetime'].'</td>';
              echo'<td>'. $row['Exit_datetime'].'</td>';
              echo'<tr>';
          }
      echo'</tbody>
  </table>';

  //query to see all other customers possibly infected by said person
  $q10="select V2.NFC_ID, A.Area_name, convert(varchar(25),V2.Visit_datetime) as Visit_datetime,
      convert(varchar(25),V2.Exit_datetime) as Exit_datetime
      from Visits as V1, Area as A, Visits as V2
      where V1.Area_ID=A.Area_ID and
	     V2.Area_ID=V1.Area_ID and
	     V1.NFC_ID=".$_POST['nfcid']." and
	     V2.NFC_ID<>V1.NFC_ID and
	     V2.Exit_datetime between V1.Visit_datetime and V1.Exit_datetime+0.05
      order by V1.Visit_datetime";

    $stmt10=sqlsrv_query($conn,$q10);

    //table to see NFC ID of possibly infected customers
    //as well as the area and time in common with infected person
    echo'
    <table>
        <caption>Other customers with possibility of infection</caption>
        <thead>
            <tr>
                <th>NFC ID</th>
                <th>Area in common</th>
                <th>Date and time of entry</th>
                <th>Date and time of exit</th>
            </tr>
        </thead>
        <tbody>';
            while ($row = sqlsrv_fetch_array($stmt10, SQLSRV_FETCH_ASSOC)) {
                echo'<tr>';
                echo'<td>'. $row['NFC_ID'].'</td>';
                echo'<td>'. $row['Area_name'].'</td>';
                echo'<td>'. $row['Visit_datetime'].'</td>';
                echo'<td>'. $row['Exit_datetime'].'</td>';
                echo'<tr>';
            }
        echo'</tbody>
    </table>';
}

//question 11 from this form
echo'<br>
<form method="post">
  <b>Pick age group for service use statistics</b><br>
  <input type="radio" id="Over 60" name="age" value="Over 60">
  <label for="male">Over 60</label><br>
  <input type="radio" id="40-60" name="age" value="40-60">
  <label for="female">40-60</label><br>
  <input type="radio" id="Under 40" name="age" value="Under 40">
  <label for="other">Under 40</label>
  <br>
  <br>
  <input type="radio" id="last5" name="5days" value="yes">Only last 5 days<br>
  <br>
  <input type="submit" value="Submit">
</form>';

if (isset($_POST['age'])) {
  $answer=$_POST['age'];
  if(empty($_POST['5days'])){
  //--------------------------------------------------------------------
  if ($answer=="Over 60")  {
    $q1111 = "select top 15 count(A.Area_name) as Count, A.Area_name
              from Visits as V, Area as A, Customer as C
              where V.Area_ID=A.Area_ID and
     	            V.NFC_ID=C.NFC_ID and
    	            C.Birthdate <'1961'
              group by A.Area_name
              order by count(A.Area_name) desc";

    $stmt1111=sqlsrv_query($conn,$q1111);

    if ($stmt1111==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo '<table style="float:left;">
        <caption>15 most visited areas over 60yo</caption>
        <thead>
            <tr>
                <th>Area</th>
                <th>Number of visits</th>
            </tr>
        </thead>
        <tbody>';

            while ($row = sqlsrv_fetch_array($stmt1111, SQLSRV_FETCH_ASSOC)) {
                echo'<tr>';
                echo'<td>'. $row['Area_name']."</td>";
                echo'<td>'. $row['Count'].'</td>';
                echo'<tr>';
            }
    $q1121 = "select S.Service_description, count(S.Service_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
            	  V.NFC_ID=C.NFC_ID and
            	  P.Service_ID=S.Service_ID and
            	  S.Service_description<>'stay at room' and
            	  C.Birthdate <'1961'
              group by S.Service_description
              order by count(S.Service_ID) desc";

    $stmt1121=sqlsrv_query($conn,$q1121);

    if ($stmt1121==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo'
    <table style="float:left;">
        <caption>Most used services over 60yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Uses</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt1121, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }
    $q1131 = "select S.Service_description, count(distinct C.NFC_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
        	        V.NFC_ID=C.NFC_ID and
        	        P.Service_ID=S.Service_ID and
        	        S.Service_description<>'stay at room' and
        	        C.Birthdate <'1961'
              group by S.Service_description
              order by count(distinct C.NFC_ID) desc";

    $stmt1131=sqlsrv_query($conn,$q1131);

    if ($stmt1131==false) {
      die( print_r( sqlsrv_errors(),true));
    }
    echo'
    <table style="float:left;">
        <caption>Most popular services over 60yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Customers</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt1131, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }

  }
  //----------------------------------------------------------------------------
  if ($answer=="40-60")  {
    $q1112 = "select top 15 count(A.Area_name) as Count, A.Area_name
              from Visits as V, Area as A, Customer as C
              where V.Area_ID=A.Area_ID and
     	            V.NFC_ID=C.NFC_ID and
    	            C.Birthdate between '1961' and '1981'
              group by A.Area_name
              order by count(A.Area_name) desc";

    $stmt1112=sqlsrv_query($conn,$q1112);

    if ($stmt1112==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo '<table style="float:left;">
        <caption>15 most visited areas 40-60yo</caption>
        <thead>
            <tr>
                <th>Area</th>
                <th>Number of visits</th>
            </tr>
        </thead>
        <tbody>';

            while ($row = sqlsrv_fetch_array($stmt1112, SQLSRV_FETCH_ASSOC)) {
                echo'<tr>';
                echo'<td>'. $row['Area_name']."</td>";
                echo'<td>'. $row['Count'].'</td>';
                echo'<tr>';
            }
    $q1122 = "select S.Service_description, count(S.Service_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
            	  V.NFC_ID=C.NFC_ID and
            	  P.Service_ID=S.Service_ID and
            	  S.Service_description<>'stay at room' and
            	  C.Birthdate between '1961' and '1981'
              group by S.Service_description
              order by count(S.Service_ID) desc";

    $stmt1122=sqlsrv_query($conn,$q1122);

    if ($stmt1122==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo'
    <table style="float:left;">
        <caption>Most used services 40-60yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Uses</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt1122, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }
    $q1132 = "select S.Service_description, count(distinct C.NFC_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
        	        V.NFC_ID=C.NFC_ID and
        	        P.Service_ID=S.Service_ID and
        	        S.Service_description<>'stay at room' and
        	        C.Birthdate between '1961' and '1981'
              group by S.Service_description
              order by count(distinct C.NFC_ID) desc";

    $stmt1132=sqlsrv_query($conn,$q1132);

    if ($stmt1132==false) {
      die( print_r( sqlsrv_errors(),true));
    }
    echo'
    <table style="float:left;">
        <caption>Most popular services 40-60yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Customers</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt1132, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }

  }
  //----------------------------------------------------------------------------
  if ($answer=="Under 40")  {
    $q1113 = "select top 15 count(A.Area_name) as Count, A.Area_name
              from Visits as V, Area as A, Customer as C
              where V.Area_ID=A.Area_ID and
                  V.NFC_ID=C.NFC_ID and
                  C.Birthdate >'1981'
              group by A.Area_name
              order by count(A.Area_name) desc";

    $stmt1113=sqlsrv_query($conn,$q1113);

    if ($stmt1113==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo '<table style="float:left;">
        <caption>15 most visited areas under 40yo</caption>
        <thead>
            <tr>
                <th>Area</th>
                <th>Number of visits</th>
            </tr>
        </thead>
        <tbody>';

            while ($row = sqlsrv_fetch_array($stmt1113, SQLSRV_FETCH_ASSOC)) {
                echo'<tr>';
                echo'<td>'. $row['Area_name']."</td>";
                echo'<td>'. $row['Count'].'</td>';
                echo'<tr>';
            }
    $q1123 = "select S.Service_description, count(S.Service_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
                V.NFC_ID=C.NFC_ID and
                P.Service_ID=S.Service_ID and
                S.Service_description<>'stay at room' and
                C.Birthdate >'1981'
              group by S.Service_description
              order by count(S.Service_ID) desc";

    $stmt1123=sqlsrv_query($conn,$q1123);

    if ($stmt1123==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo'
    <table style="float:left;">
        <caption>Most used services under 40yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Uses</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt1123, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }
    $q1133 = "select S.Service_description, count(distinct C.NFC_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
                  V.NFC_ID=C.NFC_ID and
                  P.Service_ID=S.Service_ID and
                  S.Service_description<>'stay at room' and
                  C.Birthdate >'1981'
              group by S.Service_description
              order by count(distinct C.NFC_ID) desc";

    $stmt1133=sqlsrv_query($conn,$q1133);

    if ($stmt1133==false) {
      die( print_r( sqlsrv_errors(),true));
    }
    echo'
    <table style="float:left;">
        <caption>Most popular services under 40yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Customers</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt1133, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }

  }
  //----------------------------------------------------------------------------
  //------------------------------------------------------------------------------
}
else{
  ?>
  <h2>Results for last 5 days</h2>
  <?php
  if ($answer=="Over 60")  {
    $q11112 = "select top 15 count(A.Area_name) as Count, A.Area_name
              from Visits as V, Area as A, Customer as C
              where V.Area_ID=A.Area_ID and
     	            V.NFC_ID=C.NFC_ID and
                  V.Visit_datetime>'2021/05/20' and
    	            C.Birthdate <'1961'
              group by A.Area_name
              order by count(A.Area_name) desc";

    $stmt11112=sqlsrv_query($conn,$q11112);

    if ($stmt11112==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo '<table style="float:left;">
        <caption>15 most visited areas over 60yo</caption>
        <thead>
            <tr>
                <th>Area</th>
                <th>Number of visits</th>
            </tr>
        </thead>
        <tbody>';

            while ($row = sqlsrv_fetch_array($stmt11112, SQLSRV_FETCH_ASSOC)) {
                echo'<tr>';
                echo'<td>'. $row['Area_name']."</td>";
                echo'<td>'. $row['Count'].'</td>';
                echo'<tr>';
            }
    $q11212 = "select S.Service_description, count(S.Service_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
            	  V.NFC_ID=C.NFC_ID and
            	  P.Service_ID=S.Service_ID and
            	  S.Service_description<>'stay at room' and
                V.Visit_datetime>'2021/05/20' and
            	  C.Birthdate <'1961'
              group by S.Service_description
              order by count(S.Service_ID) desc";

    $stmt11212=sqlsrv_query($conn,$q11212);

    if ($stmt11212==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo'
    <table style="float:left;">
        <caption>Most used services over 60yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Uses</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt11212, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }
    $q11312 = "select S.Service_description, count(distinct C.NFC_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
        	        V.NFC_ID=C.NFC_ID and
        	        P.Service_ID=S.Service_ID and
        	        S.Service_description<>'stay at room' and
                  V.Visit_datetime>'2021/05/20' and
        	        C.Birthdate <'1961'
              group by S.Service_description
              order by count(distinct C.NFC_ID) desc";

    $stmt11312=sqlsrv_query($conn,$q11312);

    if ($stmt11312==false) {
      die( print_r( sqlsrv_errors(),true));
    }
    echo'
    <table style="float:left;">
        <caption>Most popular services over 60yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Customers</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt11312, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }

  }
  //----------------------------------------------------------------------------
  if ($answer=="40-60")  {
    $q11122 = "select top 15 count(A.Area_name) as Count, A.Area_name
              from Visits as V, Area as A, Customer as C
              where V.Area_ID=A.Area_ID and
     	            V.NFC_ID=C.NFC_ID and
                  V.Visit_datetime>'2021/05/20' and
    	            C.Birthdate between '1961' and '1981'
              group by A.Area_name
              order by count(A.Area_name) desc";

    $stmt11122=sqlsrv_query($conn,$q11122);

    if ($stmt11122==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo '<table style="float:left;">
        <caption>15 most visited areas 40-60yo</caption>
        <thead>
            <tr>
                <th>Area</th>
                <th>Number of visits</th>
            </tr>
        </thead>
        <tbody>';

            while ($row = sqlsrv_fetch_array($stmt11122, SQLSRV_FETCH_ASSOC)) {
                echo'<tr>';
                echo'<td>'. $row['Area_name']."</td>";
                echo'<td>'. $row['Count'].'</td>';
                echo'<tr>';
            }
    $q11222 = "select S.Service_description, count(S.Service_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
            	  V.NFC_ID=C.NFC_ID and
            	  P.Service_ID=S.Service_ID and
            	  S.Service_description<>'stay at room' and
                V.Visit_datetime>'2021/05/20' and
            	  C.Birthdate between '1961' and '1981'
              group by S.Service_description
              order by count(S.Service_ID) desc";

    $stmt11222=sqlsrv_query($conn,$q11222);

    if ($stmt11222==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo'
    <table style="float:left;">
        <caption>Most used services 40-60yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Uses</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt11222, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }
    $q11322 = "select S.Service_description, count(distinct C.NFC_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
        	        V.NFC_ID=C.NFC_ID and
        	        P.Service_ID=S.Service_ID and
        	        S.Service_description<>'stay at room' and
                  V.Visit_datetime>'2021/05/20' and
        	        C.Birthdate between '1961' and '1981'
              group by S.Service_description
              order by count(distinct C.NFC_ID) desc";

    $stmt11322=sqlsrv_query($conn,$q11322);

    if ($stmt11322==false) {
      die( print_r( sqlsrv_errors(),true));
    }
    echo'
    <table style="float:left;">
        <caption>Most popular services 40-60yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Customers</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt11322, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }

  }
  //----------------------------------------------------------------------------
  if ($answer=="Under 40")  {
    $q11132 = "select top 15 count(A.Area_name) as Count, A.Area_name
              from Visits as V, Area as A, Customer as C
              where V.Area_ID=A.Area_ID and
                  V.NFC_ID=C.NFC_ID and
                  V.Visit_datetime>'2021/05/20' and
                  C.Birthdate >'1981'
              group by A.Area_name
              order by count(A.Area_name) desc";

    $stmt11132=sqlsrv_query($conn,$q11132);

    if ($stmt11132==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo '<table style="float:left;">
        <caption>15 most visited areas under 40yo</caption>
        <thead>
            <tr>
                <th>Area</th>
                <th>Number of visits</th>
            </tr>
        </thead>
        <tbody>';

            while ($row = sqlsrv_fetch_array($stmt11132, SQLSRV_FETCH_ASSOC)) {
                echo'<tr>';
                echo'<td>'. $row['Area_name']."</td>";
                echo'<td>'. $row['Count'].'</td>';
                echo'<tr>';
            }
    $q11232 = "select S.Service_description, count(S.Service_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
                V.NFC_ID=C.NFC_ID and
                P.Service_ID=S.Service_ID and
                S.Service_description<>'stay at room' and
                V.Visit_datetime>'2021/05/20' and
                C.Birthdate >'1981'
              group by S.Service_description
              order by count(S.Service_ID) desc";

    $stmt11232=sqlsrv_query($conn,$q11232);

    if ($stmt11232==false) {
      die( print_r( sqlsrv_errors(),true));
    }

    echo'
    <table style="float:left;">
        <caption>Most used services under 40yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Uses</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt11232, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }
    $q11332 = "select S.Service_description, count(distinct C.NFC_ID) as Count
              from Visits as V, Customer as C, Provided_at as P, Service as S
              where V.Area_ID=P.Area_ID and
                  V.NFC_ID=C.NFC_ID and
                  P.Service_ID=S.Service_ID and
                  S.Service_description<>'stay at room' and
                  V.Visit_datetime>'2021/05/20' and
                  C.Birthdate >'1981'
              group by S.Service_description
              order by count(distinct C.NFC_ID) desc";

    $stmt11332=sqlsrv_query($conn,$q11332);

    if ($stmt11332==false) {
      die( print_r( sqlsrv_errors(),true));
    }
    echo'
    <table style="float:left;">
        <caption>Most popular services under 40yo</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Customers</th>
            </tr>
        </thead>
    <tbody>';

        while ($row = sqlsrv_fetch_array($stmt11332, SQLSRV_FETCH_ASSOC)) {
            echo'<tr>';
            echo'<td>'. $row['Service_description']."</td>";
            echo'<td>'. $row['Count'].'</td>';
            echo'<tr>';
        }

  }
}
}
