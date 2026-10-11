document.addEventListener("DOMContentLoaded", function () {

    console.log("BTVP HIGH SCHOOL Management System loaded.");

    /* Mobile menu / UI helper */
    const buttons = document.querySelectorAll(".btn");

    buttons.forEach(function (button) {

        button.addEventListener("click", function () {

            if (button.type === "submit") {
                button.style.opacity = "0.85";
            }

        });

    });

    /* Confirm delete buttons */
    const deleteButtons = document.querySelectorAll(".delete-btn");

    deleteButtons.forEach(function (button) {

        button.addEventListener("click", function (event) {

            const message =
                button.getAttribute("data-confirm") ||
                "Are you sure you want to delete this record?";

            if (!confirm(message)) {
                event.preventDefault();
            }

        });

    });

});