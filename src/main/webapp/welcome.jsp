<%@ page import="java.util.List" %>
<%@ page import="com.hellokoding.auth.model.UserImage" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="com.hellokoding.auth.model.UserVideo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">

    <style>
        .image-list, .video-list {
            display: none;
        }

        :root {
            --gradient: linear-gradient(to left top, #DD2476 10%, #FF512F 90%) !important;
        }

        body {
            background: #111 !important;
        }

        .card {
            background: #222;
            border: 1px solid #dd2476;
            color: rgba(250, 250, 250, 0.8);
            margin-bottom: 2rem;
        }

        .btn {
            border: 5px solid;
            border-image-slice: 1;
            background: var(--gradient) !important;
            -webkit-background-clip: text !important;
            -webkit-text-fill-color: transparent !important;
            border-image-source:  var(--gradient) !important;
            text-decoration: none;
            transition: all .4s ease;
        }

        .btn:hover, .btn:focus {
            background: var(--gradient) !important;
            -webkit-background-clip: none !important;
            -webkit-text-fill-color: #fff !important;
            border: 5px solid #fff !important;
            box-shadow: #222 1px 0 10px;
            text-decoration: underline;
        }

        #logoutBtn:hover, #logoutBtn:focus {
            background: var(--gradient) !important;
            -webkit-background-clip: none !important;
            -webkit-text-fill-color: #fff !important;
            border: 5px solid #fff !important;
            box-shadow: #222 1px 0 10px;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">

    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2 class="text-danger">Welcome ${pageContext.request.userPrincipal.name} | <a id="logoutBtn" onclick="document.forms['logoutForm'].submit()" style="cursor:pointer">Logout</a></h2>

    </c:if>

    <h1 class="text-danger">Toggle Lists Based on Type</h1>

    <div class="mb-3">
        <label for="typeSelect" class="form-label">Type</label>
        <select id="typeSelect" class="selectpicker" data-style="btn-danger" onchange="changeList()">
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
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="fileUpload">
                        <label class="custom-file-label" for="fileUpload">Choose Image File：</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="imageUploadBtn">Upload</button>
                </div>
            </div>
        </div>
    </div>

    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal2">
        Open Upload Video Modal
    </button>

    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel2">Video File Upload</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="fileUpload2">
                        <label class="custom-file-label" for="fileUpload2">Choose Video File：</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="imageUploadBtn2">Upload</button>
                </div>
            </div>
        </div>
    </div>

    <div class="image-list">
        <%-- Display image list here --%>
<%--        <ul>--%>


<%--            <% for (UserImage image : (List<UserImage>) request.getAttribute("imageList")) { %>--%>
<%--&lt;%&ndash;            <li><img src="<%= image.getImageData() %>" alt="Image"></li>&ndash;%&gt;--%>
<%--                <li>--%>
<%--                    <p><%= image.getImageName() %></p>--%>
<%--                    <img src="data:image/jpeg;base64,<%= image.getImageBase64() %>" alt="Image">--%>
<%--                    <button onclick="deleteImage('<%= image.getId() %>')">删除</button> <!-- 添加删除按钮 -->--%>
<%--                </li>--%>
<%--            <% } %>--%>
<%--        </ul>--%>


<%--        <div class="row">--%>

<%--             <% for (UserImage image : (List<UserImage>) request.getAttribute("imageList")) { %>--%>
<%--             <div class="col-sm col-xs-12">--%>
<%--                 <div class="card" style="width: 18rem;">--%>
<%--                     <img class="card-img-top" src="data:image/jpeg;base64,<%= image.getImageBase64() %>" alt="Card image cap">--%>
<%--                     <div class="card-body">--%>
<%--                         <p class="card-text"><%= image.getImageName() %></p>--%>
<%--                     </div>--%>
<%--                     <div class="card-body">--%>
<%--                         <a href="#" class="card-link" onclick="deleteImage('<%= image.getId() %>')">Delete image</a>--%>
<%--                     </div>--%>
<%--                 </div>--%>
<%--             </div>--%>
<%--             <% } %>--%>
<%--        </div>--%>

            <div class="container mx-auto mt-4">
                <div class="row">

            <% for (UserImage image : (List<UserImage>) request.getAttribute("imageList")) { %>
                    <div class="col-md-4">
                        <div class="card" style="width: 18rem;">
                            <img src="data:image/jpeg;base64,<%= image.getImageBase64() %>" class="card-img-top" alt="...">

                            <div class="card-body">
                                <h5 class="card-title"><%= image.getImageName() %></h5>
                                <h6 class="card-subtitle mb-2 text-muted"><%=image.getCreatedAt()%></h6>
                                <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                <a href="#" class="btn mr-2" onclick="deleteImage('<%= image.getId() %>')"><i class="fas fa-link"></i> Delete image</a>
                            </div>

                        </div>
                    </div>
                    <% } %>

                </div>
            </div>
    </div>

    <div class="video-list">
        <div class="container mx-auto mt-4">
            <div class="row">

                <% for (UserVideo video : (List<UserVideo>) request.getAttribute("videoList")) { %>
                <div class="col-md-4">
                    <div class="card" style="width: 18rem;">
                        <video src="data:video/mp4;base64,<%= video.getVideoBase64() %>" class="card-img-top" controls>

                        <div class="card-body">
                            <h5 class="card-title"><%= video.getVideoName() %></h5>
                            <h6 class="card-subtitle mb-2 text-muted"><%=video.getCreatedAt()%></h6>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn mr-2" onclick="deleteImage('<%= video.getId() %>')"><i class="fas fa-link"></i> Delete Video</a>
                        </div>

                    </div>
                </div>
                <% } %>

            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
<script>
    function changeList() {
        var typeSelect = document.getElementById("typeSelect");
        var imageList = document.querySelector(".image-list");
        var videoList = document.querySelector(".video-list");

        if (typeSelect.value === "image") {
            imageList.style.display = "flex";
            videoList.style.display = "none";
        } else if (typeSelect.value === "video") {
            imageList.style.display = "none";
            videoList.style.display = "flex";
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

        $("#imageUploadBtn2").click(function() {
            // 获取文件名和文件数据
            var fileName = $("#fileName").val();
            var fileData = $("#fileUpload2")[0].files[0];

            // 创建FormData对象，并将文件数据添加到其中
            var formData = new FormData();
            formData.append("file", fileData);

            // 发送文件数据到后端接口
            $.ajax({
                url: "http://localhost:8080/videoUpload",
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

    function deleteImage(imageId) {
        // 发送删除请求到后端接口
        $.ajax({
            url: "http://localhost:8080/deleteImage",
            type: "DELETE",
            data: JSON.stringify({"imageId": imageId}),
            contentType: "application/json",
            success: function(response) {
                // 处理成功响应
                location.reload(); // 刷新当前页面
            },
            error: function(xhr, status, error) {
                // 处理错误响应
                console.error(error);
            }
        });
    }


    function deleteVideo(videoId) {
        // 发送删除请求到后端接口
        $.ajax({
            url: "http://localhost:8080/deleteVideo",
            type: "DELETE",
            data: JSON.stringify({"videoId": videoId}),
            contentType: "application/json",
            success: function(response) {
                // 处理成功响应
                location.reload(); // 刷新当前页面
            },
            error: function(xhr, status, error) {
                // 处理错误响应
                console.error(error);
            }
        });
    }
</script>
</body>
</html>