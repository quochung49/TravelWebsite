<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="DAO.*"%>
<%@page import="entity.model.*"%>
<%@page import="entity.user.*"%>
<%@page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <title>User Orders | Admin</title>
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
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="../index.jsp"><i class='bx bx-log-out bx-rotate-180'></i> </a></li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="images/user.png" width="50px"
                                                alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${user.firstName}</b></p>
                    <p class="app-sidebar__user-designation">Welcome</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="#"><i class='app-menu__icon bx bx-tachometer'></i><span
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
<!--            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Order List</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>-->
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
                            <table class="table table-hover table-bordered" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>User ID</th>
                                        <th>Order ID</th>
                                        <th>Description</th>
                                        <th>Total Amount</th>
                                        <th>Payment Status</th>
                                        <th>Purchase Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                          

                                    <c:forEach items="${sessionScope.userOrders}" var="order">
                                        <tr>
                                            <td>${order.userId}</td>
                                            <td>${order.orderId}</td>
                                            <td>${order.description}</td>
                                            <td>$${order.total}</td>
                                            <td><span class="badge bg-success">${order.status}</span></td>
                                            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
                                            <td>
                                                <c:set var="orderId" value="${order.orderId}" />
                                                <c:set var="userId" value="${order.userId}" />
                                                <c:set var="orderDetailDAO" value="<%= new DAO.OrderDetailDAO() %>" />
                                                <c:set var="orderDetail" value="${orderDetailDAO.getOrderDetailByOrderId(orderId)}" />
                                                <c:set var="userDAO" value="<%= new DAO.UserDAO() %>" />
                                                <c:set var="userDetail" value="${userDAO.getUserById(userId)}" />

                                                <button class="btn btn-primary btn-sm edit" type="button" title="Details" id="show-emp"
                                                        data-toggle="modal" data-target="#ModalUP${order.orderId}">Details</i>
                                                </button>
                                            </td>
                                        </tr>

                                    <div class="modal fade" id="ModalUP${order.orderId}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                         data-keyboard="false">

                                        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="form-group col-md-12">
                                                            <span class="thong-tin-thanh-toan">
                                                                <h5>Order Details</h5>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Items </label>
                                                            <c:forEach items="${orderDetail.items}" var="item" >
                                                                <div class="row">
                                                                    <div class="col-6">
                                                                        <strong> ${item.book.title}</strong>
                                                                    </div>
                                                                    <div class="col-2">
                                                                        ${item.quantity}
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>

                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Other Details </label>
                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <strong>Customer</strong>
                                                                </div>
                                                                <div class="col-8">
                                                                    ${userDetail.firstName} ${userDetail.lastName}
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <strong>Email</strong>
                                                                </div>
                                                                <div class="col-8">
                                                                    ${userDetail.email}
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <strong>Order Date</strong>
                                                                </div>
                                                                <div class="col-8">
                                                                    <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" />
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <strong>Total Amount</strong>
                                                                </div>
                                                                <div class="col-8">
                                                                    $${orderDetail.total}
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <strong>Status</strong>
                                                                </div>
                                                                <div class="col-8">
                                                                    ${order.status}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <br>
                                                    <a class="btn btn-save" data-dismiss="modal" href="#">Exit</a>
                                                    <br>
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
            //Thời Gian
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
