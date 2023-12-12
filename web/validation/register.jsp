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
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.2/components/logins/login-9/assets/css/login-9.css" />

        <style>
            input[type="checkbox"] {
                /* Define your default styles here */
            }

            /* Styles for the checkbox when it is checked */
            input[type="checkbox"]:checked {
                background-color: #212529; /* Change this to your desired color */
            }
        </style>
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
                                            <h3>Sign up</h3>
                                            <p>Already a member? <a href="login.jsp" class="text-dark">Sign in</a></p>
                                        </div>
                                    </div>
                                </div>
                                <form action="../register" method="post">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required>
                                                <label for="loginEmail" class="form-label">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="password" id="password" value="" placeholder="Password" required>
                                                <label for="password" class="form-label">Password</label>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="firstname" id="firstname" value="" placeholder="" required>
                                                <label for="firstname" class="form-label">First Name</label>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="lastname" id="lastname" value="" placeholder="" required>
                                                <label for="lastname" class="form-label">Last Name</label>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="streetaddress" id="streetaddress" value="" placeholder="" required>
                                                <label for="streetaddress" class="form-label">Street Address</label>
                                            </div>
                                        </div>

<!--                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="zipcode" id="zipcode" value="" placeholder="" required>
                                                <label for="zipcode" class="form-label">Zip Code</label>
                                            </div>
                                        </div>-->

                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="city" id="city" value="" placeholder="" required>
                                                <label for="city" class="form-label">City</label>
                                            </div>
                                        </div>

<!--                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="country" id="country" value="" placeholder="" required>
                                                <label for="country" class="form-label">Country</label>
                                            </div>
                                        </div>-->

                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="text" class="form-control" name="phone" id="phone" value="" placeholder="" required>
                                                <label for="phone" class="form-label">Phone</label>
                                            </div>
                                        </div>


                                        <div class="col-12">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="loginCheck" id="loginCheck">
                                                <label class="form-check-label text-secondary" for="loginCheck">Agree term & Conditions</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid">
                                                <button class="btn btn-dark btn-lg" type="submit">Sign up</button>
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
                            <p id="errorModalBody" class="text-success">${sessionScope.signupSuccess}</p>
                            <p id="errorModalBody" class="text-danger">${sessionScope.signupFail}</p>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-dark" onclick="window.location.href='login.jsp'">Sign In</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

        <script>
            $(document).ready(function () {
                // Trigger the modal display if loginFailMsg is not null
                if (<c:out value="${sessionScope.signupSuccess != null}"/> || <c:out value="${sessionScope.signupFail != null}"/>) {
                    $('#errorModal').modal('show');
                    <c:remove var="signupSuccess" scope="session"/>;
                    <c:remove var="signupFail" scope="session"/>;
                }
            });

        </script>
    </body>

</html>

