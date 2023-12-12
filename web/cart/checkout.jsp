<%@page import="DB.DBConnect" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Order</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" 
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="../css/index_style.css" rel="stylesheet" />
    </head
    <body>
        <div class="container-fluid p-3">
            <div class="row">
                <div class="col-md-3 text-dark">
                    <h3><i class="fa-solid fa-person-hiking"></i> Travel Website</h3>
                </div>
                <div class="col-md-7">
                    <form action="../search" method="post" class="d-flex" role="search">
                        <input class="form-control me-2 w-50" type="search" name="searchInput" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-dark" type="submit">Search</button>
                    </form>
                </div>
                <div class="col-md-2"> 
                    <a href="viewcart.jsp" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Cart"><i class="fa-solid fa-cart-shopping"></i></a>

                    <c:if test="${user != null}" var="noUser" >
                        <a href="../customer/profile.jsp" class="btn btn-dark" data-bs-toggle="tooltip" data-bs-placement="top" title="Profile"><i class="fa-solid fa-user"></i></a>
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
                        <a class="nav-link" href="viewcart.jsp">View Cart</a>

                    </div>
                </div>
            </div>
        </nav>

        <!--Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">My Order</h1>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5 row">

            <div class="container px-4 px-lg-5 mt-5 col-7">
                <h3 class="text-center">Item List</h3>
                <table class="table" border="2">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Product Image</th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Price</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach items="${cart.items}" var="item" varStatus="loop">
                            <tr>
                                <th scope="row">${loop.index + 1}</th>
                                <td><img src="../assets/books/${item.book.imageURL}" alt="alt" width="70px" height="100px" /></td>
                                <td>${item.book.title}</td>
                                <td>${item.quantity}</td>
                                <td>$${item.getTotal()}
                                </td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="4"></td>
                            <td><strong>Total: $${cart.getTotalAmount()}</strong></td>
                        </tr>
                    </tbody>

                </table>

            </div>

            <div class="container px-4 px-lg-5 mt-5 col-5">
                <h3 class="text-center">Order Details</h3>
                <div class="row g-3">
                    <div class="col-12">
                        <p><strong>Description: </strong> ${cart.getDescription()}</p>
                    </div>

                    <div class="col-12">
                        <p><strong>Shipping: </strong>Free</p>
                    </div>
                    <div class="col-12">
                        <p><strong>Tax: </strong>0%</p>
                    </div>
                    <div class="col-12">
                        <p><strong>Total: </strong>$${cart.getTotalAmount()}</p>
                    </div>

                    <div class="col-12">
                        <div class="d-grid">
                            <button class="btn btn-dark btn-lg" onclick="document.location.href = '../authorize_payment'">Order</button>
                        </div>
                    </div>
                </div>
            </div>



            <script>
                const infoChoiceSelect = document.getElementById('infoChoice');
                const newFields = document.querySelectorAll('input');
                const userFields = [
                    document.getElementById('email').value,
                    document.getElementById('firstname').value,
                    document.getElementById('lastname').value,
                    document.getElementById('streetaddress').value,
                    document.getElementById('zipcode').value,
                    document.getElementById('city').value,
                    document.getElementById('country').value,
                    document.getElementById('phone').value
                ];
                console.log(userFields);

                // Add an event listener to the "Choose Information Source" select box
                infoChoiceSelect.addEventListener('change', function () {
                    if (infoChoiceSelect.value === 'useCurrent') {
                        // If "Use Current Information" is selected, make the new fields readonly and hide the new information section
                        newFields.forEach((field, index) => {
                            field.readOnly = true;
                            field.value = userFields[index - 1];
                        });
                    } else if (infoChoiceSelect.value === 'enterNew') {
                        // If "Enter New Information" is selected, make the new fields editable and clear the form
                        newFields.forEach(field => {
                            field.readOnly = false;
                            field.value = '';
                        });
                    }
                });
            </script>




        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
        crossorigin="anonymous"></script>


        <script src="../js/script.js"></script>
    </body>
</html>
