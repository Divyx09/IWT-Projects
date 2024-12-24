<?php
// Database connection details
$host = "localhost";
$user = "root";
$password = "";
$database = "testdb";

// Create a connection
$conn = mysqli_connect($host, $user, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Check if 'city' is set in POST data
if (isset($_POST['city'])) {
    $city = $_POST['city'];

    // Insert data into database
    $sql = "INSERT INTO `city` (`city_name`) VALUES ('$city')";
    $result = mysqli_query($conn, $sql);

    if ($result) {
        echo "Data submitted successfully";
    } else {
        echo "Failed to store data: " . mysqli_error($conn);
    }
} else {
    echo "City name not provided!";
}

// Close the connection
mysqli_close($conn);
?>
