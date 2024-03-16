<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Sidebar -->
<nav id="sidebarMenu" class="collapse d-lg-block sidebar collapse bg-white" style="padding: 0px">
    <div class="position-sticky">
        <div class="list-group list-group-flush mx-3 mt-4">
            <a href="dashboard" class="list-group-item list-group-item-action py-2 ripple" aria-current="true">
                <i class="fas fa-tachometer-alt fa-fw me-3"></i><span>Dashboard</span>
            </a>
            <a href="manage" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-apple-alt fa-fw me-3"></i><span>Fruit management</span>
            </a>
            <a href="manage?check=ordermanage" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-clipboard fa-fw me-3"></i><span>Order management</span>
            </a>
            <a href="category" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-parachute-box fa-fw me-3"></i><span>Category management</span>
            </a>
            <a href="transaction" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-file-invoice-dollar fa-fw me-3"></i><span>Transaction</span></a>
            </a>
            <a href="topfruits" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-trophy fa-fw me-3"></i><span>TOP 10 best-selling fruits</span>
            </a>
            <a href="feedback" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-comments fa-fw me-3"></i><span>Feedback</span>
            </a>
            <div class="dropdown">
                <span class="list-group-item list-group-item-action py-2 ripple dropdown-toggle" id="accountDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-user-tie fa-fw me-3"></i><span>Account management</span>
                </span>
                <ul class="dropdown-menu" aria-labelledby="accountDropdown">
                    <li>
                        <a href="account" class="list-group-item list-group-item-action py-2 ripple">
                            <i class="fas fa-id-card fa-fw me-3"></i><span>Personal information</span>
                        </a>
                    </li>
                    <li>
                        <a href="change-password" class="list-group-item list-group-item-action py-2 ripple">
                            <i class="fas fa-key fa-fw me-3"></i><span>Change password</span>
                        </a>
                    </li>
                    <li>
                        <a href="logout" class="list-group-item list-group-item-action py-2 ripple">
                            <i class="fas fa-sign-out-alt fa-fw me-3"></i><span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>

        </div>
    </div>
</nav>
<!-- Bootstrap JS bundle (includes Popper.js) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Sidebar -->