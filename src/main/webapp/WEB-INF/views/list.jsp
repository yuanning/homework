<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>数据列表</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1>数据列表</h1>

    <div class="form-group">
        <label for="typeSelect">选择类型:</label>
        <select class="form-control" id="typeSelect">
            <option value="all">全部</option>
            <option value="image">图片</option>
            <option value="video">视频</option>
        </select>
    </div>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>名称</th>
            <th>类型</th>
        </tr>
        </thead>
        <tbody>
        <%-- 这里是动态生成的数据列表 --%>
        <% for (int i = 1; i <= 20; i++) { %>
        <tr>
            <td><%= i %></td>
            <td>数据<%= i %></td>
            <td><%= i %></td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <ul class="pagination">
        <%-- 这里是动态生成的分页 --%>
        <% for (int i = 1; i <= 5; i++) { %>
        <li class="page-item"><a class="page-link" href="#"><%= i %></a></li>
        <% } %>
    </ul>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>