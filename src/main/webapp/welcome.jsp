<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <style>
        .image-list, .video-list {
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Toggle Lists Based on Type</h1>

    <div class="mb-3">
        <label for="typeSelect" class="form-label">Type</label>
        <select id="typeSelect" class="form-select" onchange="changeList()">
            <option value="default">Please choose a type</option>
            <option value="image">Image</option>
            <option value="video">Video</option>
        </select>
    </div>

    <div class="image-list">
        <h2>Image List</h2>
        <%-- Display image list here --%>
        <ul>
            <% for (String image : (List<String>) request.getAttribute("imageList")) { %>
            <li><img src="<%= image %>" alt="Image"></li>
            <% } %>
        </ul>
    </div>

    <div class="video-list">
        <h2>Video List</h2>
        <%-- Display video list here --%>
        <ul>
            <% for (String video : (List<String>) request.getAttribute("videoList")) { %>
            <li>
                <video controls="controls" autoplay="autoplay">
                    <source src="<%= video %>" type="video/mp4"/>
                </video>
            </li>
            <% } %>
        </ul>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function changeList() {
        var typeSelect = document.getElementById("typeSelect");
        var imageList = document.querySelector(".image-list");
        var videoList = document.querySelector(".video-list");

        if (typeSelect.value === "image") {
            imageList.style.display = "block";
            videoList.style.display = "none";
        } else if (typeSelect.value === "video") {
            imageList.style.display = "none";
            videoList.style.display = "block";
        }
    }
</script>
</body>
</html>