<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create an account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        .card {
            margin-bottom: 20px;
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .card-title {
            margin-bottom: 10px;
        }
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">

    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Welcome ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Logout</a></h2>

    </c:if>

    <h1>数据列表</h1>

    <h1 class="text-center">数据列表</h1>

    <div class="form-group">
        <label for="typeSelect">选择类型:</label>
        <select class="form-control" id="typeSelect">
            <option value="all">全部</option>
            <option value="image">图片</option>
            <option value="video">视频</option>
        </select>
    </div>

    <div id="dataList">
        <%-- 这里是动态生成的数据列表 --%>
        <% for (int i = 1; i <= 20; i++) { %>
        <div class="card">
            <img src="image.jpg" alt="Image <%= i %>" class="card-img-top">
            <div class="card-body">
                <h5 class="card-title">数据<%= i %></h5>
                <p class="card-text">这是一条数据的描述。</p>
            </div>
        </div>
        <% } %>
    </div>

    <ul class="pagination">
        <%-- 这里是动态生成的分页 --%>
        <% for (int i = 1; i <= 5; i++) { %>
        <li class="page-item"><a class="page-link" href="#"><%= i %></a></li>
        <% } %>
    </ul>

</div>
<!-- /container -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script>
    function filterData() {
        var type = document.getElementById("typeSelect").value;
        var cards = document.getElementsByClassName("card");
        for (var i = 0; i < cards.length; i++) {
            if (type === "all" || cards[i].classList.contains(type)) {
                cards[i].style.display = "block";
            } else {
                cards[i].style.display = "none";
            }
        }
    }
</script>
</body>
</html>
