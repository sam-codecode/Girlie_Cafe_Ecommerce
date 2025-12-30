<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Admin" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }

    List<Map<String, Object>> monthlySales =
        (List<Map<String, Object>>) request.getAttribute("monthlySales");

    List<Map<String, Object>> topProducts =
        (List<Map<String, Object>>) request.getAttribute("topProducts");

    if (monthlySales == null) monthlySales = new ArrayList<>();
    if (topProducts == null) topProducts = new ArrayList<>();

    List<String> months = new ArrayList<>();
    List<Double> totals = new ArrayList<>();

    for (Map<String, Object> row : monthlySales) {
        months.add(row.get("month").toString());
        totals.add((Double) row.get("total"));
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Reports & Analytics | Girlie's Café</title>

    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admin.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="admin-page">

<div class="admin-layout">

    <%
        request.setAttribute("activePage", "reports");
    %>
    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <div class="header">
            <h2>Reports & Analytics</h2>
            <div class="admin-info">
                <span>👤</span>
                <span><%= admin.getName() %></span>
            </div>
        </div>

        <!-- REPORTS GRID -->
        <div class="stats" style="grid-template-columns: 2fr 1fr;">

            <!-- MONTHLY SALES -->
            <div class="stat-card">
                <h3 style="margin-bottom: 14px;">Monthly Sales (RM)</h3>

                <canvas id="salesChart" height="140"></canvas>

                <table style="margin-top: 20px;">
                    <thead>
                        <tr>
                            <th>Month</th>
                            <th>Total Sales</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (monthlySales.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="2">No sales data available</td>
                        </tr>
                    <%
                        } else {
                            for (Map<String, Object> row : monthlySales) {
                    %>
                        <tr>
                            <td><%= row.get("month") %></td>
                            <td>RM <%= String.format("%.2f", row.get("total")) %></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <!-- TOP PRODUCTS -->
            <div class="stat-card">
                <h3 style="margin-bottom: 14px;">Top Selling Products</h3>

                <%
                    if (topProducts.isEmpty()) {
                %>
                    <p>No product data available</p>
                <%
                    } else {
                        for (Map<String, Object> row : topProducts) {
                %>
                    <p>
                        <strong><%= row.get("name") %></strong>
                        — <%= row.get("sold") %> sold
                    </p>
                <%
                        }
                    }
                %>
            </div>

        </div>
    </div>
</div>

<!-- CHART SCRIPT -->
<script>
const ctx = document.getElementById('salesChart');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: <%= months.toString() %>,
        datasets: [{
            label: 'Sales (RM)',
            data: <%= totals.toString() %>,
            backgroundColor: '#c58b5a'
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { display: false }
        },
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>

</body>
</html>
