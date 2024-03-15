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
                <i class="fas fa-apple-alt fa-fw me-3"></i><span>Fruit Management</span>
            </a>
            <a href="manage?check=ordermanage" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-clipboard fa-fw me-3"></i><span>Order Management</span>
            </a>
            <a href="category" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-parachute-box fa-fw me-3"></i><span>Category Management</span>
            </a>
            <a href="transaction" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-file-invoice-dollar fa-fw me-3"></i><span>Transaction</span></a>
            </a>
            <a href="topfruits" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-trophy fa-fw me-3"></i><span>Top 10 best-selling fruits</span>
            </a>
            <a href="feedback" class="list-group-item list-group-item-action py-2 ripple">
                <i class="fas fa-comments fa-fw me-3"></i><span>Feedback</span>
            </a>
        </div>
    </div>
</nav>
<!-- Sidebar -->