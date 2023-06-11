/**
 * 
 */

// Get the reference to the toast element
var toastElement = document.getElementById("toast-simple");

// Check if errCode is not null
if (errCode != null) {
    // Add 'active' class to display the toast
    toastElement.classList.add("active");
    
    // Set a timeout to hide the toast after 3 seconds (3000 milliseconds)
    setTimeout(function() {
        // Remove 'active' class to hide the toast
        toastElement.classList.remove("active");
    }, 3000);
}
