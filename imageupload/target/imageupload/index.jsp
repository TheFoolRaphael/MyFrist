<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${pageInfo == null}">
    <c:redirect url="/All"/>
</c:if>
<html>
<head>
    <title>笔记本配件列表</title>
    <!-- 设置viewport属性  -->
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />

    <!-- 设置网页字符编码格式  -->
    <meta charset="utf-8" />

    <!-- 引用框架CSS文件  -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.css"/>

    <!-- 引用框架JS文件  -->
    <script src="js/jquery-3.3.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <style>
        th, .table td {
            text-align: center;vertical-align: middle!important;
        }
        img,li {
            cursor: pointer;
        }
    </style>
    <script>
        $(function () {
            $(document).on('click','a[data-del]',function () {
                return confirm('是否删除该产品信息？');
            });

            $(document).on('click', 'button[data-edit]',function () {
                var id = $(this).data('edit');
                var url = '/toEdit-'+id;

                //将url地址页面内容加载到指定的元素中
                $('#modal-edit .modal-content').load(url,function () {
                    $('#modal-edit').modal('show');
                })
            })
        })
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <h1 class="text-primary">笔记本配件列表</h1>
        </div>
        <a class="btn btn-primary" data-toggle="modal" data-backdrop="static" data-target="#modal-add">
            <span class="glyphicon glyphicon-plus"></span>
            添加
        </a>
    </div>
    <table class="table table-hover table-bordered table-striped col-md-10">
        <thead class="bg-primary text-warning">
        <tr>
            <th width="257px">名称</th>
            <th>图片</th>
            <th>价格</th>
            <th>描述</th>
            <th>时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="c" items="${pageInfo.list}">
            <fmt:formatDate var="date" pattern="yyyy-MM-dd" value="${c.made_Date}"/>
            <fmt:formatNumber var="price" pattern="$###.00" value="${c.price}"/>
            <tr>
                <td style="display: none">${c.id}</td>
                <td><h4>${c.name}</h4></td>
                <td>
                    <img src="/img/${c.image}" title="${c.remark}" width="70" height="70"/>
                </td>
                <td><h4>${price}</h4></td>
                <td width="180"><h5>${c.remark}</h5></td>
                <td><h5>${date}</h5></td>
                <td>
                    <button class="btn btn-primary" data-backdrop="false" data-edit="${c.id}" >
                        <span class="glyphicon glyphicon-edit"></span>
                        修改
                    </button>
                    <a href="/del-${c.id}" class="btn btn-danger" data-del="">
                        <span class="glyphicon glyphicon-remove"></span>
                        删除
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <nav>
        <ul class="pagination">
            <c:choose>
                <c:when test="${pageInfo.pageNum eq 1}">
                    <li class="disabled">
                        <a>&laquo;</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="/All?page=${pageInfo.prePage}">&laquo;</a>
                    </li>
                </c:otherwise>
            </c:choose>
            <c:forEach var="i" items="${pageInfo.navigatepageNums}">
                <c:choose>
                    <c:when test="${i eq pageInfo.pageNum}">
                        <li class="active">
                            <a>${i}</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a href="/All?page=${i}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${pageInfo.pageNum eq pageInfo.pages}">
                    <li class="disabled">
                        <a>&raquo;</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li>
                        <a href="/All?page=${pageInfo.nextPage}">&raquo;</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>

</div>

<div id="modal-add" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-primary">
                <button class="close" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove"></span>
                </button>
                <span style="font-size: 20px">添加产品信息</span>
            </div>
            <div class="modal-body">
                <form id="add-form" action="/add" method="post" enctype="multipart/form-data">
                    <table style="height: 150px;text-align: right">
                        <tr>
                            <td><label class="control-label">名称:　</label></td>
                            <td><input class="form-control" name="name" required=""/></td>
                            <td><label class="control-label">　图片:　</label></td>
                            <td>
                                <div class="input-group col-md-6">
                                    <input style="width: 160px;" id="fileName" onclick="upImg()" class="form-control" placeholder="请选择一张图片" readonly="readonly">
                                    <label class="input-group-addon">
                                        <span class="glyphicon glyphicon-folder-open"></span>
                                        <input onchange="handName()" id="img" style="display: none" name="img1" type="file" multiple="multiple"/>
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><label class="control-label">价格:　</label></td>
                            <td><input class="form-control" name="price" type="number" required=""/></td>
                            <td><label class="control-label">　描述:　</label></td>
                            <td rowspan="2">
                                <textarea style="height: 90px;width: 200px;resize: none" class="form-control" name="remark" required=""></textarea>
                            </td>
                        </tr>
                    </table>
                </form>
                <script>
                    var $fileName = $("#fileName");
                    var $img = $("#img");
                    function upImg() {
                        document.getElementById("img").click();
                    }
                    function handName() {
                        $fileName.val($img.val());
                    }
                </script>
            </div>
            <div class="modal-footer">
                <div class="form-group text-right">
                    <button form="add-form" class="btn btn-primary btn-xs">
                        <span class="glyphicon glyphicon-save"></span>
                        保存
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="modal-edit" class="modal fade" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">

        </div>
    </div>
</div>

</body>
</html>
