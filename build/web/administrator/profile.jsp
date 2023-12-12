<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.OrderDAO"%>
<%@page import="DAO.BookDAO"%>
<%@page import="DAO.UserDAO"%>

<%@page import="entity.model.Order"%>
<%@page import="entity.user.User"%>
<%@page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">


    <head>
        <title>Admin Dashboard</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <!-- Font-icon CSS-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" 
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/index_style.css" rel="stylesheet" />


        <link rel="stylesheet" type="text/css" href="css/main.css">
    </head>

    <body onload="time()" class="app sidebar-mini rtl">
       

        <c:if test="${sessionScope.lowBooks == null || sessionScope.totalUsers == null || sessionScope.totalOrders == null}" >
            <c:redirect url="../GetAdminProfile"/>
        </c:if>


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
<!--            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><b>Dashboard</b></a></li>
                        </ul>
                        <div id="clock"></div>
                    </div>
                </div>
            </div>-->
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="row">
<!--                         col-6 
                        <div class="col-md-6">
                            <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Total Customers</h4>
                                    <p><b>${totalUsers} customers</b></p>
                                    <p class="info-tong">Total customers managed.</p>
                                </div>
                            </div>
                        </div>
                         col-6 
                        <div class="col-md-6">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-data fa-3x'></i>
                                <div class="info">
                                    <h4>Total Products</h4>
                                    <p><b>${totalBooks} products</b></p>
                                    <p class="info-tong">Total products managed.</p>
                                </div>
                            </div>
                        </div>
                         col-6 
                        <div class="col-md-6">
                            <div class="widget-small warning coloured-icon"><i class='icon bx bxs-shopping-bags fa-3x'></i>
                                <div class="info">
                                    <h4>Total Orders</h4>
                                    <p><b>${totalOrders} orders</b></p>
                                    <p class="info-tong">Total sales orders in the month.</p>
                                </div>
                            </div>
                        </div>
                         col-6 
                        <div class="col-md-6">
                            <div class="widget-small danger coloured-icon"><i class='icon bx bxs-error-alt fa-3x'></i>
                                <div class="info">
                                    <h4>Running Out of Stock</h4>
                                    <p><b>${lowBooks} products</b></p>
                                    <p class="info-tong">Number of products with low stock that need restocking.</p>
                                </div>
                            </div>
                        </div>-->
                        <!-- col-12 -->
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">Today's Orders</h3>
                                <div>
                                    <table class="table table-hover table-bordered" id="sampleTable">
                                        <thead>
                                            <tr>
                                                <th>User ID</th>
                                                <th>Order ID</th>
                                                <th>Description</th>
                                                <th>Total Amount</th>
                                                <th>Payment Status</th>
                                                <th>Purchase Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>



                                            <c:forEach items="${orders}" var="order">
                                                <tr>
                                                    <td>${order.userId}</td>
                                                    <td>${order.orderId}</td>
                                                    <td>${order.description}</td>
                                                    <td>$${order.total}</td>
                                                    <td><span class="badge bg-success">${order.status}</span></td>
                                                    <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>

                                                </tr>
                                            </c:forEach>


                                        </tbody>
                                    </table>
                                </div>
                                <!-- / div empty-->
                            </div>
                        </div>
                        <!-- / col-12 -->
                    </div>
                </div>
            </div>

<!--            <div class="text-center" style="font-size: 13px">
                <p><b>Copyright
                        <script type="text/javascript">
                            document.write(new Date().getFullYear());
                        </script> Website Management Software
                    </b></p>
            </div>-->
        </main>
        <script src="js/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="js/popper.min.js"></script>
        <script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
        <!--===============================================================================================-->
        <script src="js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="js/main.js"></script>
        <!--===============================================================================================-->
        <script src="js/plugins/pace.min.js">

        </script>
        <!--===============================================================================================-->
        <!--===============================================================================================-->
        <script type="text/javascript">
            var data = {
                labels: ["January", "February", "March", "April", "May", "June"],
                datasets: [{
                        label: "First Dataset",
                        fillColor: "rgba(255, 213, 59, 0.767), 212, 59)",
                        strokeColor: "rgb(255, 212, 59)",
                        pointColor: "rgb(255, 212, 59)",
                        pointStrokeColor: "rgb(255, 212, 59)",
                        pointHighlightFill: "rgb(255, 212, 59)",
                        pointHighlightStroke: "rgb(255, 212, 59)",
                        data: [20, 59, 90, 51, 56, 100]
                    },
                    {
                        label: "Second Dataset",
                        fillColor: "rgba(9, 109, 239, 0.651)  ",
                        pointColor: "rgb(9, 109, 239)",
                        strokeColor: "rgb(9, 109, 239)",
                        pointStrokeColor: "rgb(9, 109, 239)",
                        pointHighlightFill: "rgb(9, 109, 239)",
                        pointHighlightStroke: "rgb(9, 109, 239)",
                        data: [48, 48, 49, 39, 86, 10]
                    }
                ]
            };
            var ctxl = $("#lineChartDemo").get(0).getContext("2d");
            var lineChart = new Chart(ctxl).Line(data);

            var ctxb = $("#barChartDemo").get(0).getContext("2d");
            var barChart = new Chart(ctxb).Bar(data);
        </script>
        <script type="text/javascript">
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
        </script>
    </body>

</html>
