<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="DAO.*"%>

<%@page import="entity.model.*"%>
<%@page import="entity.user.User"%>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Travel Website | Admin</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .Choicefile {
                display: block;
                background: #14142B;
                border: 1px solid #fff;
                color: #fff;
                width: 150px;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                padding: 5px 0px;
                border-radius: 5px;
                font-weight: 500;
                align-items: center;
                justify-content: center;
            }

            .Choicefile:hover {
                text-decoration: none;
                color: white;
            }

            #uploadfile,
            .removeimg {
                display: none;
            }

            #thumbbox {
                position: relative;
                width: 100%;
                margin-bottom: 20px;
            }

            .removeimg {
                height: 25px;
                position: absolute;
                background-repeat: no-repeat;
                top: 5px;
                left: 5px;
                background-size: 25px;
                width: 25px;
                /* border: 3px solid red; */
                border-radius: 50%;

            }

            .removeimg::before {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                content: '';
                border: 1px solid red;
                background: red;
                text-align: center;
                display: block;
                margin-top: 11px;
                transform: rotate(45deg);
            }

            .removeimg::after {
                /* color: #FFF; */
                /* background-color: #DC403B; */
                content: '';
                background: red;
                border: 1px solid red;
                text-align: center;
                display: block;
                transform: rotate(-45deg);
                margin-top: -2px;
            }
        </style>
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
                <li><a class="app-menu__item" href="profile.jsp"><i class='app-menu__icon bx bx-tachometer'></i><span class="app-menu__label">Dashboard</span></a></li>
                <li><a class="app-menu__item" href="update_information.jsp" target="_blank"><i class='app-menu__icon bx bx-task'></i><span class="app-menu__label">Edit Information</span></a></li>
                <li><a class="app-menu__item" href="change_password.jsp"><i class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Change Password</span></a></li>
                <li><a class="app-menu__item" href="product.jsp"><i class='app-menu__icon bx bxs-data'></i><span class="app-menu__label">Products Management</span></a></li>
                <li><a class="app-menu__item" href="order.jsp"><i class='app-menu__icon bx bx-task'></i><span class="app-menu__label">Orders Management</span></a></li>
<!--                <li><a class="app-menu__item" href="customer.jsp"><i class='app-menu__icon bx bx-user-voice'></i><span class="app-menu__label">Customer Management</span></a></li>-->
            </ul>
        </aside>
        <main class="app-content">

<!--            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Book List</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>-->

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" href="productinsert.jsp" title="Add"><i class="fas fa-plus"></i>
                                        Add new product</a>
                                </div>
<!--                                <div class="col-sm-2">
                                    <a class="btn btn-delete btn-sm print-file" type="button" title="Print" onclick="myApp.printTable()"><i
                                            class="fas fa-print"></i> Print Data</a>
                                </div>-->
                            </div>
                            <table class="table table-hover table-bordered js-copytextarea" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>Product ID</th>
                                        <th>Category</th>
                                        <th>Product Name</th>
                                        <th>Brand</th>
                                        <th>Description</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Image</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${sessionScope.bookListAdmin == null || sessionScope.categories == null}" >
                                        <c:redirect url="../GetBookList" />
                                    </c:if>
                                    <c:forEach items="${bookListAdmin}" var="b">

                                        <tr <c:if test="${b.quantityInStock == 0}">
                                                class="bg-danger"
                                            </c:if>>
                                            <td>${b.id}</td>
                                            <td>${b.category.name}</td>
                                            <td>${b.title}</td>
                                            <td>${b.author}</td>
                                            <td>${b.description}</td>
                                            <td class="text-warning">$${b.price}</td>              
                                            <td>${b.quantityInStock}</td>
                                            <td><img src="../assets/books/${b.imageURL}" alt="" width="100px;"></td>

                                            <td>

                                                <button class="btn btn-primary btn-sm edit" type="button" title="Edit" id="show-emp"
                                                        data-toggle="modal" data-target="#ModalUP${b.id}"><i class="fas fa-edit"></i>
                                                </button>
                                            </td>
                                        </tr>

                                        <!--
                                        MODAL
                                        -->

                                    <div class="modal fade" id="ModalUP${b.id}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
                                         data-keyboard="false">
                                        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="form-group  col-md-12">
                                                            <span class="thong-tin-thanh-toan">
                                                                <h5>Edit Book Information</h5>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <form action="../updatebook" method="POST" enctype="multipart/form-data">

                                                        <div class="row">
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Product ID </label>
                                                                <input class="form-control" type="text" readonly name="bookId" value="${b.id}">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label for="exampleSelect1" class="control-label">Category</label>
                                                                <select name="categoryId" class="form-control" id="exampleSelect1">
                                                                    <option value="${b.category.id}">${b.category.name}</option>

                                                                    <c:forEach items="${categories}" var="cat">
                                                                        <option value="${cat.id}">${cat.name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Product Name</label>
                                                                <input class="form-control" type="text" name="title" required value="${b.title}">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Price</label>
                                                                <input class="form-control" type="text" name="price" required value="${b.price}">
                                                            </div>

                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Brand</label>
                                                                <input class="form-control" type="text" name="author" value="${b.author}">
                                                            </div>



                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Quantity</label>
                                                                <input class="form-control" type="number" name="quantity" value="${b.quantityInStock}" min="0">
                                                            </div>

                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Description</label>    
                                                                <textarea class="form-control" name="description" id="describe" >${b.description}</textarea>
                                                            </div>
                                                            <!--anh san pham-->
                                                            <div class="form-group col-md-12">
                                                                <label class="control-label">Picture</label>
                                                                <div id="myfileupload">
                                                                    <input type="file" id="uploadfile" name="imageURL" value="../assets/books/${b.imageURL}" onchange="readURL(this);" />
                                                                </div>
                                                                <div id="thumbbox">
                                                                    <img height="450" width="400" alt="Thumb image" src="../assets/books/${b.imageURL}" id="thumbimage" style="display:none" />
                                                                    <a class="removeimg" href="javascript:"></a>
                                                                </div>
                                                                <div id="boxchoice">
                                                                    <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Choose picture</a>
                                                                    <p style="clear:both"></p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <BR>
                                                        <button class="btn btn-save" type="submit">Save</button>
                                                        <a class="btn btn-cancel" data-dismiss="modal" href="#">Cancel</a>
                                                        <BR>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--
                                  MODAL
                                    -->
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="http://code.jquery.com/jquery.min.js" type="text/javascript">

        </script>

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/plugins/pace.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/dataTables.bootstrap.min.js">

        </script>


        <script>
            function readURL(input, thumbimage) {
                if (input.files && input.files[0]) { //Sử dụng  cho Firefox - chrome
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#thumbimage").attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                } else { // Sử dụng cho IE
                    $("#thumbimage").attr('src', input.value);

                }
                $("#thumbimage").show();
                $('.filename').text($("#uploadfile").val());
                $('.Choicefile').css('background', '#14142B');
                $('.Choicefile').css('cursor', 'default');
                $(".removeimg").show();
                $(".Choicefile").unbind('click');

            }
            $(document).ready(function () {
                $(".Choicefile").bind('click', function () {
                    $("#uploadfile").click();

                });
                $(".removeimg").click(function () {
                    $("#thumbimage").attr('src', '').hide();
                    $("#myfileupload").html('<input type="file" id="uploadfile"  onchange="readURL(this);" />');
                    $(".removeimg").hide();
                    $(".Choicefile").bind('click', function () {
                        $("#uploadfile").click();
                    });
                    $('.Choicefile').css('background', '#14142B');
                    $('.Choicefile').css('cursor', 'pointer');
                    $(".filename").text("");
                });
            });
        </script>
        <script type="text/javascript" >
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
        </script>

        <script>
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

        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
        <script src="js/plugins/pace.min.js"></script>
        <script>
            const inpFile = document.getElementById("inpFile");
            const loadFile = document.getElementById("loadFile");
            const previewContainer = document.getElementById("imagePreview");
            const previewImage = previewContainer.querySelector(".image-preview__image");
            const previewDefaultText = previewContainer.querySelector(".image-preview__default-text");
            const object = new ActiveXObject("Scripting.FileSystemObject");
            inpFile.addEventListener("change", function () {
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    previewDefaultText.style.display = "none";
                    previewImage.style.display = "block";
                    reader.addEventListener("load", function () {
                        previewImage.setAttribute("src", this.result);
                    });
                    reader.readAsDataURL(file);
                }
            });


        </script>
    </body>
</html>