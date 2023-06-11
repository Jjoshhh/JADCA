const passwordInput = document.getElementById("password");
		const confirmPasswordInput = document.getElementById("confirm-password");
		const alertContainer = document.getElementById("alertContainer");

		function checkPasswordMatch() {
			const password = passwordInput.value;
			const confirmPassword = confirmPasswordInput.value;

			if (password !== confirmPassword) {
				alertContainer.classList.remove("hidden");
				alertContainer.innerText = "Password and Confirm Password do not match.";
			} else {
				alertContainer.classList.add("hidden");
				alertContainer.innerText = "";
			}
		}

		passwordInput.addEventListener("input", checkPasswordMatch);
		confirmPasswordInput.addEventListener("input", checkPasswordMatch);