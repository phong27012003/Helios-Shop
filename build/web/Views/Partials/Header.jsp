<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link href="${pageContext.request.contextPath}/css/homePage.css" rel="stylesheet" type="text/css"/>
        <style>
            /* --- Reset & base --- */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            a {
                text-decoration: none;
                color: inherit;
            }

            button {
                background: none;
                border: none;
                cursor: pointer;
                color: #fff
            }

            .user-dropdown-wrapper {
                position: relative;
                display: inline-block;
            }

            .user-dropdown-wrapper:hover .dropdown-menu {
                display: flex;
                flex-direction: column;
            }

            .dropdown-menu {
                list-style-type: none;
                position: absolute;
                top: 100%;
                right: 0;
                background: #fff;
                color: #000;
                border-radius: 4px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.3);
                display: none;
                min-width: 160px;
                z-index: 1000;
            }

            .dropdown-item {
                text-decoration: none;
                padding: 10px 16px;
                font-size: 14px;
                color: #333;
                transition: background 0.2s;
            }



        </style>
    </head>
    <body>
        <!-- Header -->
        <header>
            <nav class="navbar">
                <div class="nav-section nav-left">
                    <div class="menu-dropdown-wrapper" id="menuDropdownWrapper">
                        <a href="#" class="nav-link menu-main">MENU</a>
                        <div class="menu-dropdown">
                            <div class="menu-col">
                                <a class="menu-header" style="color: #ffc34a" href="showAllProduct">SHOP ALL</a>
                                <a href="#">NHẪN BẠC NAM</a>
                                <a href="#">VÒNG TAY BẠC NAM</a>
                                <a href="#">DÂY CHUYỀN BẠC S925</a>
                                <a href="#">MẶT DÂY CHUYỀN BẠC S925</a>
                                <a href="#">KHUYÊN TAI BẠC NAM</a>
                            </div>
                            <div class="menu-col">
                                <span class="menu-header">HELIOS BLACK SILVER</span>
                                <a href="#">LOTUS BLACK SILVER</a>
                                <a href="#">SUNFLOWER BLACK SILVER</a>
                                <a href="#">CHRYSABER BLACK SILVER</a>
                                <span class="menu-header">HOLIDAY GIFT</span>
                                <a href="#">QUÀ TẶNG CHO NAM</a>
                                <a href="#">QUÀ TẶNG CHO NỮ</a>
                                <a href="#">QUÀ SINH NHẬT</a>
                                <a href="#">COUPLE</a>
                            </div>
                            <div class="menu-col">
                                <span class="menu-header">OTHER</span>
                                <a href="#">ACCESSORIES</a>
                                <a href="#">GOLD JEWELRY</a>
                                <span class="menu-header">NEW IN</span>
                                <a href="#">Sản phẩm mới</a>
                                <span class="menu-header">BEST SELLER</span>
                                <a href="#">Sản phẩm bán chạy</a>
                            </div>
                        </div>
                    </div>
                    <a href="#" class="nav-link">COLLECTIONS</a>
                    <a href="#" class="nav-link">EYEWEAR</a>
                    <a href="#" class="nav-link">CUỐI MÙA</a>
                    <a href="#" class="nav-link">FEEDBACK</a>
                </div>
                <div class="nav-section nav-center">
                    <span class="logo">HELIOS</span>
                </div>
                <div class="nav-section nav-right">
                    <div class="nav-item dropdown">
                        <span>Tiếng Việt ▾</span>
                    </div>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="user-dropdown-wrapper">
                                <div class="nav-link">
                                    <button class="btn btn-light dropdown-toggle" type="button">
                                        Hello, <c:out value="${sessionScope.user.fullName}" />!
                                    </button>
                                </div>
                                <div class="nav-link">
                                    <ul class="dropdown-menu">
                                        <li>
                                            <form action="profile" method="get">
                                                <input type="hidden" name="service" value="profile">
                                                <button type="submit" class="dropdown-item">Profile</button>
                                            </form>
                                        </li>
                                        <li>
                                            <form action="profile" method="get">
                                                <input type="hidden" name="service" value="changePass">
                                                <button type="submit" class="dropdown-item">Change Password</button>
                                            </form>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="logout">Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                        </c:when>
                        <c:otherwise>
                            <a href="login" class="nav-link">Đăng ký / Đăng nhập</a>
                        </c:otherwise>
                    </c:choose>
                    <a href="#" class="nav-icon"
                       ><img
                            src="https://ext.same-assets.com/837853198/2320907649.svg"
                            alt="Tìm kiếm"
                            height="22"
                            /></a>
                    <form action="addToCart" method="POST">
                        <button class="btn-main"> <a href="${pageContext.request.contextPath}/Views/User/Cart.jsp" class="nav-icon cart"
                                                     ><img
                                    src="https://ext.same-assets.com/837853198/1998606599.svg"
                                    alt="Giỏ hàng"
                                    height="22"
                                    /><span class="cart-count">0</span></a
                            ></button>   
                    </form>

                </div>
            </nav>
        </header>
    </body>
</html>
