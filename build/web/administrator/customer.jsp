<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@page import="DAO.*"%>
<%@page import="entity.model.*"%>
<%@page import="entity.user.User"%>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Customer List | Admin</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

    </head>

    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
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
                <li><a class="app-menu__item" href="profile.jsp"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Dashboard</span></a></li>
                <li><a class="app-menu__item" href="update_information.jsp"
                       target="_blank"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Edit Information</span></a></li>

                <li><a class="app-menu__item" href="change_password.jsp"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Change Password</span></a>
                </li>

                <li><a class="app-menu__item" href="product.jsp"><i
                            class='app-menu__icon bx bxs-data'></i><span class="app-menu__label">Products Management</span></a>
                </li>
                <li><a class="app-menu__item" href="order.jsp"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Orders Management</span></a></li>

<!--                <li><a class="app-menu__item" href="customer.jsp"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Customer Management</span></a></li>-->
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Customer List</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">

                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file" type="button" title="Print" onclick="myApp.printTable()"><i
                                            class="fas fa-print"></i> Print Data</a>
                                </div>
                            </div>

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>Customer ID</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th width="70">Action</th>
                                    </tr>
                                </thead>
                                <tbody>

                                
                                    <c:forEach items="${users}" var="u">

                                        <tr>
                                            <td>${u.id}</td>
                                            <td>${u.firstName} ${u.lastName}</td>
                                            <td>${u.email}</td>
                                            <td>${u.role.name}</td>
                                            <td>
                                                <!--                                                <button class="btn btn-primary btn-sm" type="button" title="Edit Role" id="show-emp" data-toggle="modal"
                                                                                                        data-target="#ModalUP${u.id}"><i class="fas fa-edit"></i></button>-->

                                                <button class="btn btn-save btn-sm" type="button" title="View" id="show-emp" data-toggle="modal"
                                                        data-target="#ModalUP${u.id}edit"><i class="fas fa-search"></i></button>
                                            </td>
                                        </tr>


                                    <div class="modal fade" id="ModalUP${u.id}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                         data-keyboard="false">
                                        <div class="modal-dialog modal-dialog-centered " role="document">
                                            <div class="modal-content">
                                                <form method="POST" action="../updateRole?userId=${u.id}}">
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="form-group  col-md-12">
                                                                <span class="thong-tin-thanh-toan">
                                                                    <h5>Add to administrator</h5>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="form-group col-md-6">
                                                                <label for="exampleSelect1" class="control-label">Admin Role</label>
                                                                <input hidden name="user_id" value="${u.id}">
                                                                <select name="permission" class="form-control" id="exampleSelect1">
                                                                    <option value="True">Allow</option>
                                                                    <option value="False">Dismiss</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <BR>
                                                        <button class="btn btn-save" type="submit">Save</button>
                                                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Cancel</a>
                                                        <BR>
                                                    </div>
                                                </form>
                                                <div class="modal-footer">
                                                </div>
                                            </div>
                                        </div>
                                    </div>




                                    <div class="modal fade" id="ModalUP${u.id}edit" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                         data-keyboard="false">
                                        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="form-group  col-md-12">
                                                            <span class="thong-tin-thanh-toan">
                                                                <h5>User Information</h5>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-3">
                                                            <label for="firstName"><strong>First Name:</strong></label>
                                                            ${u.firstName}
                                                        </div>
                                                        <div class="form-group col-md-3">
                                                            <label for="lastName"><strong>Last Name:</strong></label>
                                                            ${u.lastName}
                                                        </div>

                                                        <div class="form-group col-md-12">
                                                            <label for="lastName"><strong>Address:</strong></label>
                                                            ${u.streetAddress}, ${u.city}, ${u.country}
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label for="email"><strong>Email:</strong></label>
                                                            ${u.email}
                                                        </div>
                                                        <c:set var="userId" value="${u.id}" />
                                                        <c:set var="orderDAO" value="<%= new DAO.OrderDAO() %>" />
                                                        <c:set var="orders" value="${orderDAO.getOrdersByUserId(userId)}" />
                                                        <div class="form-group col-md-6">
                                                            <label for="email"><strong>Number Order Placed:</strong></label>
                                                            ${orders.size()}

                                                            <a class="btn btn-save" href="../GetUserOrders?id=${u.id}">View</a>

                                                        </div>

                                                        <div class="form-group col-md-6">

                                                            <label for="email"><strong>Total Amount Purchased:</strong></label>
                                                            <c:set var="tot" value="0"/>
                                                            <c:forEach items="${orders}" var="ord" >
                                                                <c:set var="tot" value="${tot + ord.total}"/>
                                                            </c:forEach> 
                                                            $<fmt:formatNumber value="${tot}" type="number" pattern="#,##0.00" />
                                                        </div>

                                                    </div>
                                                    <BR>
                                                    <a class="btn btn-save" data-dismiss="modal" href="#">Exit</a>
                                                    <BR>
                                                </div>
                                                <div class="modal-footer">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </c:forEach>

                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/plugins/pace.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js">

        </script>
        <script type="text/javascript">
            $('#sampleTable').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/en-GB.json'
                }
            });
        </script>
        <script>
            function deleteRow(r) {
                var i = r.parentNode.parentNode.rowIndex;
                document.getElementById("myTable").deleteRow(i);
            }
            jQuery(function () {
                jQuery(".trash").click(function () {
                    swal({
                        title: "Warning",
                        text: "Are you sure you want to delete this employee?",
                        buttons: ["Cancel", "Confirm"]
                    })
                            .then((willDelete) => {
                                if (willDelete) {
                                    swal("Successfully deleted!", {

                                    });
                                }
                            });
                });
            });

            // Time
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

            //In dữ liệu
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('sampleTable');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                };
            };

        </script>
    </body>

</html>
