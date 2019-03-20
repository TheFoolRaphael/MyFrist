<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

    <div class="modal-header text-primary">
        <button class="close" data-dismiss="modal">
            <span class="glyphicon glyphicon-remove"></span>
        </button>
        <span style="font-size: 20px">产品信息修改</span>
    </div>
    <div class="modal-body">
        <form id="edit-form" action="/edit" method="post" enctype="multipart/form-data">
            <table style="height: 150px;text-align: right">
                <tr>
                    <td><label class="control-label">编号:　</label></td>
                    <td><input class="form-control" name="id" value="${c.id}" readonly="readonly"></td>
                    <td><label class="control-label">　图片:　</label></td>
                    <td>
                        <div class="input-group col-md-6">
                            <input style="width: 160px;" id="fileName1" onclick="upImg1()" class="form-control" placeholder="请选择一张图片" readonly="readonly">
                            <label class="input-group-addon">
                                <span class="glyphicon glyphicon-folder-open"></span>
                                <input onchange="handName1()" id="img1" style="display: none" name="img1" type="file" multiple="multiple"/>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="control-label">名称:　</label></td>
                    <td><input class="form-control" name="name" value="${c.name}"  required=""></td>
                    <td><label class="control-label">　描述:　</label></td>
                    <td rowspan="2">
                        <textarea style="height: 90px;width: 200px;resize: none" class="form-control" name="remark" required="">${c.remark}
                        </textarea>
                    </td>
                </tr>
                <tr>
                    <td><label class="control-label">价格:　</label></td>
                    <td><input class="form-control" value="${c.price}" type="number" min="0.00"  required="" step="0.01" name="price"></td>
                </tr>
            </table>
        </form>
        <script>
            var $fileName1 = $("#fileName1");
            var $img1 = $("#img1");
            function upImg1() {
                document.getElementById("img1").click();
            }
            function handName1() {
                $fileName1.val($img1.val());
            }
        </script>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary btn-xs" form="edit-form">
            <span class="glyphicon glyphicon-refresh"></span>
            <span>更新</span>
        </button>
    </div>

</body>
</html>
