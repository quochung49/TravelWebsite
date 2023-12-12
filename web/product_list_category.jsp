<%@page import="DB.DBConnect" %>
<%@page import="entity.user.User" %>
<%@page import="entity.model.UserRole" %>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="/WEB-INF/tlds/pager" prefix="pager" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Category Page</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" 
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/index_style.css" rel="stylesheet" />
        <style>
            #cart-icon {
                position: fixed;
                bottom: 60px; /* Adjust the distance from the bottom as needed */
                right: 20px; /* Adjust the distance from the left as needed */
                z-index: 1000; /* Ensure it's above other content on the page */
                border-radius: 50%; /* Make it a circle */
                padding: 10px;
                background-color: white;

                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Add a subtle shadow */
            }

            #cart-icon img {
                width: 40px; /* Adjust the icon size */
                height: 40px;
                display: block;
                margin: 0 auto; /* Center the icon inside the circle */
            }
            .item-count {
                font-size: 12px;
                font-weight: bold;
                margin-left: 5px;
                color: red;
            }

            #cart-icon:hover {
                background-color: #0056b3; /* Change background color on hover */
            }
        </style>
    </head>
    <body>

        <div class="container-fluid p-3 myhearder">
            <div class="row">
                <div class="col-md-3 text-dark">
                    <h3><i class="fa-solid fa-person-hiking"></i> Travel Website</h3>
                </div>
                <div class="col-md-7">
                    <form action="search" method="post" class="d-flex" role="search">
                        <input class="form-control me-2 w-50" type="search" name="searchInput" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-dark" type="submit">Search</button>
                    </form>
                </div>


                <div class="col-md-2"> 
                    <a href="cart/viewcart.jsp" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Cart"><i class="fa-solid fa-cart-shopping"></i></a>

                    <c:if test="${user == null}" var="noUser" >
                        <a href="validation/login.jsp" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Sign In"><i class="fa-solid fa-right-to-bracket"></i></a>
                        <a href="validation/register.jsp" class="btn btn-dark"  data-bs-toggle="tooltip" data-bs-placement="top" title="Sign Up"><i class="fa-solid fa-user-plus"></i></a>
                        </c:if>

                    <c:if test="${user != null}" var="noUser" >
                        <c:if test="${user.role.id == 2}" >
                            <a href="customer/profile.jsp?userId=${user.id}" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Profile"><i class="fa-solid fa-user"></i></a>

                        </c:if>
                        <c:if test="${user.role.id == 1}" >
                            <a href="administrator/profile.jsp?userId=${user.id}" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Profile"><i class="fa-solid fa-user"></i></a>
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
                                    <button type="button" onclick="window.location.href = 'logout'" class="btn btn-primary">Logout</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <nav class="navbar navbar-expand-lg bg-transparent mynavbar">
            <div class="container-fluid">
                <a class="navbar-brand" href="#"><i class="fa-solid fa-house"></i></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <div class="navbar-nav">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                        <div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
                            <ul class="navbar-nav">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Category
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
                                        <c:forEach items="${categoriesCat}" var="cat">
                                            <li><a class="dropdown-item" href="book_list_category?catId=${cat.id}">${cat.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <a class="nav-link" href="cart/viewcart.jsp">View Cart</a>

                    </div>
                </div>
            </div>
        </nav>

        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <c:if test="${catName != null}" >
                        <h1 class="display-4 fw-bolder">${catName} Books</h1>
                    </c:if>

                    <c:if test="${catName == null}" >
                        <h1 class="display-4 fw-bolder">Please pick a category.</h1>
                    </c:if>
                    <p class="lead fw-normal text-white-50 mb-0">Project for PRJ301</p>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

                    <c:forEach items="${bookListCat}" var="book">
                        <div class="col mb-5 ">
                            <div class="card h-100">
                                <!-- Sale badge-->
                                <div class="badge bg-success text-white position-absolute" style="top: 0.5rem; right: 0.5rem">${book.category.name}</div>

                                <c:if test="${book.quantityInStock == 0}">
                                    <div class="badge bg-danger text-white position-absolute" style="top: 0.5rem; left: 0.5rem">Out of stock</div>
                                </c:if>

                                <img class="card-img-top h-75" src="assets/books/${book.getImageURL()}" alt="..." />
                                <!-- Product details-->
                                <div class="card-body p-4">
                                    <div class="text-left">
                                        <!-- Product name-->
                                        <h5 class="fw-bolder">${book.getTitle()}</h5>
                                        <!-- Product price-->
                                        $${book.getPrice()}
                                    </div>
                                </div>
                                <!-- Product actions-->
                                <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                    <div class="text-center">
                                        <a class="btn btn-outline-dark mt-auto" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal-${book.getId()}">View</a>
                                        <c:if test="${book.quantityInStock > 0}">
                                            <a class="btn btn-outline-dark mt-auto" href="javascript:void(0);" onclick="addToCart(${book.getId()})">Add to cart</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal-${book.getId()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                <div class="modal-content" >
                                    <div class="modal-header">
                                        <h1 class="modal-title" id="exampleModalLabel">Book View</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-5" >
                                                <img src="assets/books/${book.getImageURL()}" alt="" style="width: 100%;"/>
                                            </div>
                                            <div class="col-7" >
                                                <span>${book.getAuthor()} </span> 
                                                <h2 class="">${book.getTitle()}</h2> 
                                                <p style="text-align: justify">${book.getDescription()}</p>
                                                <span class=""><strong>Price: </strong>$${book.getPrice()}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="text-center">
                    <pager:pager pageIndex="${pageIndexCat}" totalPages="${totalPagesCat}" pageSize="${pageSizeCat}" displayPages="5"/>
                </div>

            </div>
        </section>

        <div class="modal fade" id="addToCartModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title ">Item Added to Cart</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p class="text-success">Item has been added to your cart.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <a href="cart/viewcart.jsp" id="cart-icon" style="text-decoration: none">
            <i class="fas fa-shopping-cart fa-2x"></i>
            <span class="item-count" id="cart-item-count"><c:out value="${cart.getCount()}" /></span>
        </a>

        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; My Website PRJ301 Major 4 Phucdeptrai</p></div>
        </footer>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
                crossorigin="anonymous">

        </script>
        <script src="js/script.js">

        </script>

        <script>
            function loadBookList(pageIndex, pageSize) {
                $.get('book_list_category', {pageIndex: pageIndex, pageSize: pageSize}, function (data) {
                    $('body').html(data);
                    console.log(data);
                });
            }
            document.getElementById('cart-icon').addEventListener('click', function (event) {
                event.preventDefault();
                document.location.href = this.href;
            });
        </script>

    </body>
</html>
