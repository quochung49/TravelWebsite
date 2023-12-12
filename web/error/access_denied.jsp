
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
    <body>

        <div class="container-fluid p-3">
            <div class="row">
                <div class="col-md-3 text-dark">
                    <h3><i class="fa-solid fa-book"></i> Book Store</h3>
                </div>
                <div class="col-md-7">
                    <form class="d-flex" role="search">
                        <input class="form-control me-2 w-50" type="search" placeholder="Search" aria-label="Search">
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
                        <a class="nav-link" href="#">All Books</a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">

                    <h2 class="display-4 fw-bolder text-danger"><c:choose>
                            <c:when test="${accessError != null}">
                                <c:out value="${accessError}" />
                            </c:when>
                            <c:otherwise>
                                <c:out value="Nothing" />
                            </c:otherwise>
                        </c:choose></h2>
                </div>
            </div>
        </header>
        <!-- Section-->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" 
        crossorigin="anonymous"></script>

        <script src="../js/script.js"></script>
    </body>
</html>

