<%@ page import="java.util.List" %>
<%@ page import="com.hellokoding.auth.model.UserImage" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.OutputStream" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        .image-list, .video-list {
            display: none;
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

    <h1>Toggle Lists Based on Type</h1>

    <div class="mb-3">
        <label for="typeSelect" class="form-label">Type</label>
        <select id="typeSelect" class="form-select" onchange="changeList()">
            <option value="default">Please choose a type</option>
            <option value="image">Image</option>
            <option value="video">Video</option>
        </select>
    </div>

    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
        Open Upload Image Modal
    </button>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel">Image File Upload</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- 在这里添加文件名和文件上传按钮的代码 -->
<%--                    <div class="form-group">--%>
<%--                        <label for="fileName">Image Name：</label>--%>
<%--                        <input type="text" class="form-control" id="fileName" placeholder="Please Input Image File Name">--%>
<%--                    </div>--%>
                    <div class="form-group">
                        <label for="fileUpload">Choose Image File：</label>
                        <input type="file" class="form-control-file" id="fileUpload">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="imageUploadBtn">Upload</button>
                </div>
            </div>
        </div>
    </div>

    <div class="image-list">
        <h2>Image List</h2>
        <%-- Display image list here --%>
        <ul>


            <% for (UserImage image : (List<UserImage>) request.getAttribute("imageList")) { %>
<%--            <li><img src="<%= image.getImageData() %>" alt="Image"></li>--%>
                <li><img src="data:image/jpeg;base64,<%= image.getImageBase64() %>" alt="Image"></li>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
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

    $(document).ready(function() {
        $("#imageUploadBtn").click(function() {
            // 获取文件名和文件数据
            var fileName = $("#fileName").val();
            var fileData = $("#fileUpload")[0].files[0];

            // 创建FormData对象，并将文件数据添加到其中
            var formData = new FormData();
            formData.append("file", fileData);

            // 发送文件数据到后端接口
            $.ajax({
                url: "http://localhost:8080/imageUpload",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    // 处理成功响应
                    location.reload();
                },
                error: function(xhr, status, error) {
                    // 处理错误响应
                    console.error(error);
                }
            });
        });
    });
</script>
</body>
</html>