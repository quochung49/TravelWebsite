<%-- Document : register Created on : Sep 8, 2023, 4:27:14 PM Author : FPT --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>

        <!-- CSS Files -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.2/components/logins/login-9/assets/css/login-9.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <style>
            input[type="checkbox"] {
                /* Define your default styles here */
            }

            input[type="checkbox"]:checked {
                background-color: #212529; /* Change this to your desired color */
            }

            th.empty-space {
                width: 20px; /* Set the width to your desired value */
                height: 20px; /* Set the height to your desired value */
            }
        </style>

        <link rel="stylesheet" href="../css/index_style.css"/>
    </head>

    <body style="background-image: url('../img/background.jpg'); background-size: cover; background-position: center;">
        <section class="py-3 py-md-5 py-xl-8">
            <div class="container">
                <div class="row gy-4 justify-content-center align-items-center">


                    <div class="col-12 col-md-6 col-xl-5 shadow p-0 rounded-4">
                        <div class="card border-0 rounded-4">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="mb-4">
                                            <h3>Sign in</h3>
                                            <p>Don't have an account? <a href="register.jsp" class="text-dark">Sign up</a></p>
                                        </div>
                                    </div>
                                </div>
                                <form action="../login" method="post">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required>
                                                <label for="email" class="form-label">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="password" id="password" value="" placeholder="Password" required>
                                                <label for="password" class="form-label">Password</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="rememberMe" id="remember">
                                                <label class="form-check-label text-secondary" for="remember">Remember me</label>
                                                <p>Go to store? <a href="../index.jsp" class="text-dark">Click here</a></p>

                                            </div>

                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid">
                                                <button class="btn btn-dark btn-lg" type="submit">Sign in</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="modal" id="errorModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Error</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h6 class="text-danger" id="errorModalBody">${sessionScope.loginFailMsg}</h6>
                        <div class="mb-4">
                            <p>Go to store without account? <a href="../index.jsp" class="text-dark">Click here</a></p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js">

        </script>
        <script>
            // Function to decrypt an AES-encrypted cookie value
            // Function to decrypt an AES-encrypted cookie value
            function decryptAESCookies(encryptedValue) {
                try {
                    var key = CryptoJS.enc.Utf8.parse("oAw0SYadOXTFfE7sI38a8Qq8z90YOWr8");
                    var decrypted = CryptoJS.AES.decrypt(encryptedValue, key, {
                        mode: CryptoJS.mode.ECB,
                        padding: CryptoJS.pad.Pkcs7
                    });
                    return decrypted.toString(CryptoJS.enc.Utf8);
                } catch (error) {
                    console.error("Decryption error:", error);
                }
                return null;
            }

            function getCookieValue(cookieName) {
                console.log(document.cookie);
                var cookies = document.cookie.split(';');
                for (var i = 0; i < cookies.length; i++) {
                    var cookie = cookies[i].trim();
                    if (cookie.startsWith(cookieName + '=')) {
                        return cookie.substring(cookieName.length + 1);
                    }
                }
                return null;
            }

// Check if the cookies exist and decrypt them
            var rememberedEmail = getCookieValue("rememberedEmail");
            var rememberedPassword = getCookieValue("rememberedPassword");

// Decrypt the stored email and password
            var decryptedEmail = decryptAESCookies(rememberedEmail);
            var decryptedPassword = decryptAESCookies(rememberedPassword);

// Populate the login form fields if the cookies exist and have been successfully decrypted
            if (decryptedEmail && decryptedPassword) {
                document.getElementById("email").value = decryptedEmail;
                document.getElementById("password").value = decryptedPassword;
            }

        </script>


        <script>
            $(document).ready(function () {
                // Trigger the modal display if loginFailMsg is not null
                if (<c:out value="${sessionScope.loginFailMsg != null}"/>) {
                    $('#errorModal').modal('show');
            <c:remove var="loginFailMsg" scope="session"/>
                }
            });


        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    </body>

</html>

