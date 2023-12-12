<%@page import="DB.DBConnect" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" 
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/index_style.css" rel="stylesheet" />
    </head
    <body style="background-image: url('../img/background.jpg'); background-size: cover; background-position: center;">

        <div class="container-fluid p-3">
            <div class="row">
                <div class="col-md-3 text-dark">
                    <h3><i class="fa-solid fa-person-hiking"></i> Travel Website</h3>
                </div>
<!--                <div class="col-md-7">
                    <form action="../search" method="post" class="d-flex" role="search">
                        <input class="form-control me-2 w-50" type="search" name="searchInput" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-dark" type="submit">Search</button>
                    </form>
                </div>-->
                <div class="col-md-2"> 
                    <a href="viewcart.jsp" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Cart"><i class="fa-solid fa-cart-shopping"></i></a>

                    <c:if test="${user != null}" var="noUser" >
                        <c:if test="${user.role.id == 2}" >
                            <a href="../customer/profile.jsp?userId=${user.id}" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Profile"><i class="fa-solid fa-user"></i></a>

                        </c:if>
                        <c:if test="${user.role.id == 1}" >
                            <a href="../administrator/profile.jsp?userId=${user.id}" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Profile"><i class="fa-solid fa-user"></i></a>
                            </c:if>

                        <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-placement="top" title="Logout"><i class="fa-solid fa-right-from-bracket"></i>
                        </button>                       
                    </c:if>

                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Logout</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    Are you sure to logout?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="button" onclick="window.location.href = '../logout'" class="btn btn-primary">Logout</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <nav class="navbar navbar-expand-lg bg-transparent">
            <div class="container-fluid">
                <a class="navbar-brand" href="#"><i class="fa-solid fa-house"></i></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav">
                        <a class="nav-link" href="../index.jsp">Home</a>
                        <div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
                            <ul class="navbar-nav">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Category
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
                                        <c:forEach items="${categories}" var="cat">
                                            <li><a class="dropdown-item" href="../book_list_category?catId=${cat.id}">${cat.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <a class="nav-link active" aria-current="page" href="viewcart.jsp">View Cart</a>

                    </div>
                </div>
            </div>
        </nav>

        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <c:if test="${cart == null || cart.getCount() == 0}" >
                        <h2 class="display-4 fw-bolder text-danger">Cart is empty, please pick a item.</h2>
                    </c:if>
                    <c:if test="${cart != null && cart.getCount() > 0}" >
                        <h1 class="display-4 fw-bolder text-success">View Cart</h1>
                    </c:if>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5">

            <style>
                .truncate-text {
                    overflow: hidden;
                    white-space: nowrap;
                    text-overflow: ellipsis;
                    max-width: 40vw; /* Adjust this value to your desired maximum width */
                }

                .view-full-link {
                    cursor: pointer;
                    color: black;
                }
            </style>


            <div class="container px-4 px-lg-5 mt-5 ">
                <c:if test="${cart != null && cart.getCount() > 0}" >

                    <table class="table" border="2">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Product Image</th>
                                <th scope="col">Product Name</th>
                                <th scope="col" style="max-width: 40vw;">Description</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Price</th>
                                <th></th>
                            </tr>
                        </thead>
                        <c:forEach items="${cart.items}" var="item" varStatus="loop">
                            <tr>
                                <th scope="row">${loop.index + 1}</th>
                                <td><img src="../assets/books/${item.book.imageURL}" alt="alt" width="100px" height="120px" /></td>
                                <td>${item.book.title}</td>
                                <td style="max-width: 40vw;">
                                    <div class="truncate-text" id="description-${loop.index}">
                                        ${item.book.description}
                                    </div>
                                    <a class="view-full-link" id="view-full-link-${loop.index}" onclick="toggleDescription(${loop.index})">readmore</a>
                                </td>

                                <td>
                                    <input class="bg-transparent" type="number" name="quantity" value="${item.quantity}" min="0" 
                                           style="width: 20%;" onchange="updateItemQuantity(this, ${item.book.id})">
                                </td>
                                <td>
                                    <span id="total-${item.book.id}">$${item.getTotal()}</span>
                                </td>

                                <td>
                                    <button class="btn bg-transparent rounded" onclick="removeItem(this, ${item.book.id})">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                </td>
                            </tr>
                            <script>



                                function toggleDescription(index) {
                                    console.log(index);
                                    const descriptionElement = document.getElementById(`description-` + index);
                                    const link = document.getElementById(`view-full-link-` + index);

                                    const isTruncated = descriptionElement.classList.contains('truncate-text');
                                    if (isTruncated) {
                                        descriptionElement.classList.remove('truncate-text');
                                        link.textContent = "collapse";
                                    }

                                    if (!isTruncated) {
                                        descriptionElement.classList.add('truncate-text');
                                        link.textContent = "readmore";
                                    }

                                }
                            </script>


                            <div class="modal fade" id="outOfStockModal" tabindex="-1" role="dialog" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            Quantity is out of stock.
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        </tbody>
                    </table>

                    <div class="text-center">
                        <a class="btn btn-outline-dark mt-auto" href="../index.jsp">Continue Shopping</a>
                        <a class="btn btn-outline-dark mt-auto" href="checkout.jsp">Checkout</a>
                    </div>
                </c:if>

                <c:if test="${cart == null || cart.getCount() == 0}" >
                    <div class="text-center">
                        <a class="btn btn-outline-dark mt-auto" href="../index.jsp">Continue Shopping</a>
                    </div>
                </c:if>


            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
        crossorigin="anonymous"></script>

        <script src="../js/script.js"></script>
    </body>
</html>
