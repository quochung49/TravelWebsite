<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="entity.user.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Update Information</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <!-- Font-icon CSS-->
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/index_style.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="css/main.css">
    </head>
    <body onload="time()" class="app sidebar-mini rtl">
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="../index.jsp"><i class='bx bx-log-out bx-rotate-180'></i> </a></li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user">
                <img class="app-sidebar__user-avatar" src="images/user.png" width="50px" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${user.firstName}</b></p>
                    <p class="app-sidebar__user-designation">Welcome</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="profile.jsp"><i class='app-menu__icon bx bx-tachometer'></i><span class="app-menu__label">Dashboard</span></a></li>
                <li><a class="app-menu__item " href="update_information.jsp" target="_blank"><i class='app-menu__icon bx bx-task'></i><span class="app-menu__label">Edit Information</span></a></li>
                <li><a class="app-menu__item active" href="change_password.jsp"><i class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Change Password</span></a></li>
                <li><a class="app-menu__item" href="order.jsp"><i class='app-menu__icon bx bx-task'></i><span class="app-menu__label">My Orders</span></a></li>
            </ul>
        </aside>
        <main class="app-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><b>Change Password</b></a></li>
                        </ul>
                        <div id="clock"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="tile">
                        <div class="tile-body">
                            <form action="../change_password?userId=${user.id}" method="post">
                                <div class="form-group">
                                    <label for="currentPassword">Current Password</label>
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                </div>
                                <div class="form-group">
                                    <label for="newPassword">New Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="toggleNewPassword">
                                                <i class="fas fa-eye-slash"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">Confirm New Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="toggleConfirmPassword">
                                                <i class="fas fa-eye-slash"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="passwordMismatchWarning" style="color: red; display: none;">
                                    Passwords do not match.
                                </div>
                                <button type="submit" class="btn btn-primary" id="changePasswordBtn" disabled>Change Password</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <c:if test="${sessionScope.passwordChangeSuccess != null && sessionScope.passwordChangeSuccess}">
            <div class="modal" tabindex="-1" role="dialog" id="passwordChangeModal">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Password Changed Successfully</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Your password has been successfully changed.
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>


        <!-- Essential javascripts for application to work-->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">$('#sampleTable').DataTable();</script>
        <script type="text/javascript">
            function time() {
                var today = new Date();
                var weekday = new Array(7);
                weekday[0] = "Sunday";
                weekday[1] = "Monday";
                weekday[2] = "Tuesday";
                weekday[3] = "Wednesday";
                weekday[4] = "Thursday";
                weekday[5] = "Friday";
                weekday[6] = "Saturday";
                var day = weekday[today.getDay()];
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();
                var h = today.getHours();
                var m = today.getMinutes();
                m = checkTime(m);
                nowTime = h + ":" + m + "";
                if (dd < 10) {
                    dd = '0' + dd;
                }
                if (mm < 10) {
                    mm = '0' + mm;
                }
                today = day + ', ' + dd + '/' + mm + '/' + yyyy;
                tmp = '<span class="date"> ' + today + ' - ' + nowTime +
                        '</span>';
                document.getElementById("clock").innerHTML = tmp;
                clocktime = setTimeout("time()", "1000", "Javascript");

                function checkTime(i) {
                    if (i < 10) {
                        i = "0" + i;
                    }
                    return i;
                }
            }
        </script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const newPasswordInput = document.getElementById('newPassword');
                const confirmNewPasswordInput = document.getElementById('confirmPassword');
                const currentPasswordInput = document.getElementById('currentPassword');
                const passwordMismatchWarning = document.getElementById('passwordMismatchWarning');
                const changePasswordBtn = document.getElementById('changePasswordBtn');
                const toggleNewPassword = document.getElementById('toggleNewPassword');
                const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');

                // Get the current password from the session (assuming it's stored as 'sessionPassword')
                const sessionPassword = '<%= ((User)session.getAttribute("user")).getPassword() %>';

                function handlePasswordChange() {
                    const newPassword = newPasswordInput.value;
                    const confirmPassword = confirmNewPasswordInput.value;
                    const currentPassword = currentPasswordInput.value;

                    const newPasswordsMatch = newPassword === confirmPassword;
                    const currentPasswordCorrect = currentPassword === sessionPassword;

                    if (newPasswordsMatch && currentPasswordCorrect) {
                        passwordMismatchWarning.style.display = 'none';
                        changePasswordBtn.disabled = false;
                    } else {
                        passwordMismatchWarning.style.display = 'block';
                        changePasswordBtn.disabled = true;
                    }
                }

                function togglePasswordVisibility(inputElement, toggleElement) {
                    const type = inputElement.getAttribute('type');
                    if (type === 'password') {
                        inputElement.setAttribute('type', 'text');
                        toggleElement.innerHTML = '<i class="fas fa-eye"></i>';
                    } else {
                        inputElement.setAttribute('type', 'password');
                        toggleElement.innerHTML = '<i class="fas fa-eye-slash"></i>';
                    }
                }

                newPasswordInput.addEventListener('input', handlePasswordChange);
                confirmNewPasswordInput.addEventListener('input', handlePasswordChange);
                currentPasswordInput.addEventListener('input', handlePasswordChange);

                toggleNewPassword.addEventListener('click', () => togglePasswordVisibility(newPasswordInput, toggleNewPassword));
                toggleConfirmPassword.addEventListener('click', () => togglePasswordVisibility(confirmNewPasswordInput, toggleConfirmPassword));
            });
        </script>



        <!-- Your existing change_password.jsp content here -->

        <script>
            // Add this script at the end of your change_password.jsp
            // Show the modal if the passwordChangeSuccess session attribute is set
            var passwordChangeModal = document.getElementById('passwordChangeModal');
            if (passwordChangeModal) {
                new bootstrap.Modal(passwordChangeModal).show();
            }
        </script>


    </body>
</html>
