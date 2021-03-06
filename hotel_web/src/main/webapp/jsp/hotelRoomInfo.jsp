<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="/css/css.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery-easyui-1.5/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery-easyui-1.5/themes/icon.css" />
</head>
<body style="margin:0px;">

<table id="dg" class="easyui-datagrid" title="酒店事务管理 -- 酒店客房信息 " singleSelect="true" fitColumns="true" nowrap="false" striped="true"
       SelectOnCheck="true" CheckOnSelect="true" rownumbers="true" pagination="true" pageSize="20" pageList="[20, 100, 200]" toolbar="#tb" fit="true">
    <thead>
    <tr>
        <th field="select" align="center" checkbox="true">选择</th>
        <th field="roomId" align="center" width="8%">客房ID</th>
        <th field="roomNo" align="center" width="11%">客房编号</th>
        <th field="roomType" align="center" width="7%" formatter="showRoomType">客房类型</th>
        <th field="isClean" align="center" width="7%" formatter="showIsClean">是否已打扫</th>
        <th field="isLive" align="center" width="6%" formatter="showIsLive">是否已居住</th>
        <th field="roomArea" align="center" width="12%" formatter="showRoomArea">客房面积</th>
        <th field="isVip" align="center" width="8%" formatter="showIsVip">是否为VIP客房</th>
        <th field="vipPrice" align="center" width="7%">客房价格</th>
        <th field="createTime" align="center" width="11%" formatter="timeStamp2DateTime">创建时间</th>
        <th field="modifyTime" align="center" width="11%"  formatter="timeStamp2DateTime">修改时间</th>
        <th field="opterRoomDetail" align="center" width="9%">客房详情</th>
    </tr>
    </thead>
</table>
<div id="tb" style="padding:2px 5px;">
    <form id="formSearch">
        <input type="hidden" name="pageSize" id="pageSize" />
        <input type="hidden" name="pageNumber" id="pageNumber" />
        <div width="100%" style="margin:4px">
            客房ID:<input type="text" id="roomId" name="roomId" class="easyui-textbox" maxlength="20" style="width:150px"/>&nbsp;&nbsp;
            是否为VIP客房: <select class="easyui-combobox" id="searchIsVip"  name="searchIsVip"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
            <option value="" selected></option>
            <option value="0">否</option>
            <option value="1">是</option>
        </select>&nbsp;&nbsp;&nbsp;
            创建时间：<input class="easyui-datebox" id="createTimeStart" name="createTimeStart" type="text" editable="false"> --
            <input class="easyui-datebox" id="crateTimeEnd" name="crateTimeEnd" type="text" editable="false">&nbsp;&nbsp;
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="btnSearch()">查询</a>
        </div>
        <div width="100%" style="margin:4px">
            <a href="#" class="easyui-linkbutton" style="margin-bottom: 2px;margin-top:  5px;" iconCls="icon-add" onclick="btnHotelRoomDetail()">客房详情</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#" class="easyui-linkbutton" style="margin-bottom: 2px;margin-top:  5px;" iconCls="icon-add" onclick="btnAdd()">添加客房</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#" class="easyui-linkbutton" style="margin-bottom: 2px;margin-top:  5px;" iconCls="icon-edit" onclick="btnModifyHotelRoom()">修改客房信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
    </form>
</div>

<!------------------点击新增按钮，显示新增的弹窗---------------------------------->
<div id="dgAdminDetail" class="easyui-dialog" title="新增页面" width="430px" height="375px" closed="true" buttons="#dlgAdminDetail-buttons"  style="padding:10px" modal="true">
    <form id="adminDetail" method="post">
        <table align="center" width="90%" cellpadding="2" cellspacing="2">
            <tr><td></td></tr> <tr><td></td></tr> <tr><td></td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;客房编号:<input type="text" id="roomNo" name="roomNo" class="easyui-textbox" missingMessage=""validType="length[1,20]" maxlength="20" style="width:120px"></td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;客房类型:
                <select class="easyui-combobox" id="roomType"  name="roomType"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
                    <option value="" selected>全部</option>
                    <option value="0">新建</option>
                    <option value="1">普通大床房</option>
                    <option value="2">普通双人床</option>
                </select>
            </td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;是否已打扫:
                <select class="easyui-combobox" id="isClean"  name="isClean"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
                    <option value="" selected>全部</option>
                    <option value="0">否</option>
                    <option value="1">是</option>
                </select></td>
            </tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;是否已居住:
                <select class="easyui-combobox" id="isLive"  name="isLive"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
                    <option value="" selected>全部</option>
                    <option value="0" selected>否</option>
                    <option value="1">是</option>
                </select>
            </td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;客房面积:<input type="text" id="roomArea" name="roomArea" class="easyui-textbox" missingMessage=""validType="length[1,20]" maxlength="20" style="width:120px"></td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;价格:<input type="text" id="vipPrice" name="vipPrice" class="easyui-textbox" missingMessage=""validType="length[1,20]" maxlength="20" style="width:120px"></td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;是否为VIP客房:
                <select class="easyui-combobox" id="isVip"  name="isVip"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
                    <option value="" selected>全部</option>
                    <option value="0" selected>否</option>
                    <option value="1">是</option>
                </select>
            </td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;所属酒店:<input type="text" id="hotelId" name="hotelId" class="easyui-textbox" missingMessage=""validType="length[1,20]" maxlength="20" style="width:120px"></td></tr>
            <tr><td></td></tr>
        </table>
    </form>
</div>
<div id="dlgAdminDetail-buttons">
    <div align="center">
        <a href="javascript:void(0)"  class="easyui-linkbutton"  onclick="btnsave()" iconcls="icon-save">确认</a>
        <a href="javascript:void(0)"  class="easyui-linkbutton"  onclick="javascript:$('#dgAdminDetail').dialog('close')" iconcls="icon-cancel">取消</a>
    </div>
</div>



<!------------------点击修改按钮，显示修改的弹窗---------------------------------->
<div id="dgModifyDetail" class="easyui-dialog" title="客房信息修改" width="430px" height="375px" closed="true" buttons="#dlgModifyDetail-buttons"  style="padding:10px" modal="true">
    <form id="modifyDetail" method="post">
        <table align="center" width="90%" cellpadding="2" cellspacing="2">
            <tr><td></td></tr> <tr><td></td></tr> <tr><td></td></tr>
            <tr><td><input type="hidden" id="modifyRoomId" name="modifyRoomId"></td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;客房编号:<input type="text" id="modifyRoomNo" name="modifyRoomNo" class="easyui-textbox" missingMessage=""validType="length[1,20]" maxlength="20" style="width:120px"></td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;客房类型:
                <select class="easyui-combobox" id="modifyRoomType"  name="modifyRoomType"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
                    <option value="0" selected>新建</option>
                    <option value="1">普通大床房</option>
                    <option value="2">普通双人床</option>
                </select>
            </td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;是否已打扫:
                <select class="easyui-combobox" id="modifyIsClean"  name="modifyIsClean"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
                    <option value="" selected>全部</option>
                    <option value="0">否</option>
                    <option value="1">是</option>
                </select></td>
            </tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;是否已居住:
                <select class="easyui-combobox" id="modifyIsLive"  name="modifyIsLive"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
                    <option value="" selected>全部</option>
                    <option value="0" selected>否</option>
                    <option value="1">是</option>
                </select>
            </td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;客房面积:<input type="text" id="modifyRoomArea" name="modifyRoomArea" class="easyui-textbox" missingMessage=""validType="length[1,20]" maxlength="20" style="width:120px"></td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;价格:<input type="text" id="modifyVipPrice" name="modifyVipPrice" class="easyui-textbox" missingMessage=""validType="length[1,20]" maxlength="20" style="width:120px"></td></tr>
            <tr><td style="font-size: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;是否为VIP客房:
                <select class="easyui-combobox" id="modifyIsVip"  name="modifyIsVip"  panelHeight="auto" editable="false"  style="width:110px" style="font-size: 12px;">
                    <option value="" selected></option>
                    <option value="0" selected>否</option>
                    <option value="1">是</option>
                </select>
            </td></tr>
            <tr><td></td></tr>
        </table>
    </form>
</div>
<div id="dlgModifyDetail-buttons">
    <div align="center">
        <a href="javascript:void(0)"  class="easyui-linkbutton"  onclick="modifySave()" iconcls="icon-save">确认</a>
        <a href="javascript:void(0)"  class="easyui-linkbutton"  onclick="javascript:$('#dgModifyDetail').dialog('close')" iconcls="icon-cancel">取消</a>
    </div>
</div>



<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.5/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.min.js"></script>

<script type="text/javascript">

    var authenticationTypeArr = [];  //存储业务类型下拉框的option
    var chargeMethodArr = []         //存储费用收取方式的option
    //扩大easyui验证表单(单表费用的验证)
    $.extend($.fn.validatebox.defaults.rules, {
        intOrFloat:{
            validator: function (value) {
                return /^\d+(\.\d+)?$/i.test(value);
            },
            message: '数据格式不正确，请重新输入'
        }
    });

    $(function(){

        $("#createTimeStart").datebox("setValue", currNDate(0));//默认时间为当天
        $("#crateTimeEnd").datebox("setValue", currNDate(0));//默认时间为当天

        //翻页控件，已支持分页
        $("#dg").datagrid().datagrid("getPager").pagination({
            //改变pageSize会执行 onChangePageSize，onSelectPage
            //点上一页或下一页只会执行 onSelectPage
            //刷新会执行 onSelectPage，onRefresh。所以删掉了onRefresh
            onChangePageSize: function(pageSize) {
                $("#pageSize").val(pageSize);
            },
            onSelectPage: function(pageNumber, pageSize) {
                $("#pageSize").val(pageSize);
                $("#pageNumber").val(pageNumber);
                datagridBind();
            },
            onClick:function () {
                checkType();
            },
            beforePageText: '第',
            afterPageText: '共{pages}页',
            displayMsg: '显示{from}到{to}条记录,共{total}条记录&nbsp;&nbsp;&nbsp;&nbsp;'//已支持分页，重新调整显示文字
        });
    });


    //加载列表
    function datagridBind() {
        $("#dg").datagrid("loading");
        $.get("/htm/hotelRoomInfoList.action", $("#formSearch").serialize(), function(pager){
            $("#dg").datagrid("loadData", {"total":pager.total, rows:pager.pageData});
            $("#dg").datagrid("loaded");
        });
    }

    //点上一页或下一页只会执行的加载列表功能
    function datagridBindOnSelectPage() {
        $("#dg").datagrid("loading");
        $.get("/htm/hotelRoomInfoList.action", $("#formSearch").serialize(), function(pager){
            $("#dg").datagrid("loadData", {"total":pager.total, rows:pager.pageData});
            $("#dg").datagrid("loaded");

        });
    }


    function btnAdd() {
        $("#adminDetail").form('clear');        //每次新增之前，清空原数据
        $('#dgAdminDetail').dialog("open").window("center");
    }
    function btnsave() {
        var roomNo = $("#roomNo").val();
        var roomType = $("#roomType").combobox("getValue");
        var isClean = $("#isClean").combobox("getValue");
        var isLive = $("#isLive").combobox("getValue");
        var roomArea = $("#roomArea").val();
        var isVip = $("#isVip").combobox("getValue");
        var hotelId = $("#hotelId").val();
        if(roomType ==""){
            $.messager.alert("提示","客房类型不能为空!","info");
            return ;
        }else if(isClean ==""){
            $.messager.alert("提示","是否打扫不能为空!","info");
            return ;
        }else if(isLive ==""){
            $.messager.alert("提示","客房是否居住不能为空!","info");
            return ;
        }else if(roomArea ==""){
            $.messager.alert("提示","客房居住面积不能为空!","info");
            return ;
        }else if(isVip ==""){
            $.messager.alert("提示","客房是否为VIP客房不能为空!","info");
            return ;
        }else if(hotelId ==""){
            $.messager.alert("提示","所属酒店不能为空!","info");
            return ;
        }
        $.post("/htm/hotelRoomInfoAdd.action", {
                roomNo:roomNo,
                roomType: roomType,
                isClean:isClean,
                isLive:isLive,
                roomArea:roomArea,
                isVip:isVip
            },function(data){
            $.messager.progress('close');
            if (data.status) {
                    $.messager.alert("信息", "添加客房成功", "info");
                    $('#dgAdminDetail').dialog('close');
                    datagridBind();
            } else {
                var message = "添加客房失败！";
                if (data.message != null) {
                    message = data.message;
                }
                $.messager.alert("信息", message, "error");
            }
        }, "json");

    }

    //修改客房信息--数据回显
    function btnModifyHotelRoom() {
        var row = $('#dg').datagrid('getSelected');
        if(row !=null){
            var roomId = row.roomId;
            var roomNo = row.roomNo;
            var roomType = row.roomType;
            var clean = row.isClean;
            var isLive = row.isLive;
            var roomArea = row.roomArea;
            var isVip = row.isVip;
            var vipPrice = row.vipPrice;

            $("#modifyDetail").form('load',{
                modifyRoomId :roomId,
                modifyRoomNo:roomNo,
                modifyRoomType:roomType,
                modifyIsClean:clean,
                modifyRoomArea:roomArea,
                modifyIsLive:isLive,
                modifyIsVip:isVip,
                modifyVipPrice:vipPrice,
            });
            //客房编号不能修改
            $('#modifyRoomNo').textbox('disable');
            $('#dgModifyDetail').dialog("open").window("center");

        }else{
            $.messager.alert("提示","请先选择要修改的项目","info");
            return ;
        }
    }

    //保存修改的数据
    function modifySave() {
        var modifyRoomId = $("#modifyRoomId").val();
        var modifyRoomNo = $("#modifyRoomNo").val();
        var modifyRoomType = $("#modifyRoomType").combobox("getValue");
        var modifyIsClean = $("#modifyIsClean").combobox("getValue");
        var modifyIsLive = $("#modifyIsLive").combobox("getValue");
        var modifyRoomArea = $("#modifyRoomArea").val();
        var modifyIsVip = $("#modifyIsVip").combobox("getValue");
        var modifyVipPrice = $("#modifyVipPrice").val();

        if(modifyRoomNo ==""){
            $.messager.alert("提示","客房编号不能为空!","info");
            return ;
        }else if(modifyRoomType ==""){
            $.messager.alert("提示","客房类型不能为空!","info");
            return ;
        }else if(modifyIsClean ==""){
            $.messager.alert("提示","客房是否被清理不能为空!","info");
            return ;
        }else if(modifyIsLive ==""){
            $.messager.alert("提示","客房是否已经居住不能为空!","info");
            return ;
        }else if(modifyRoomArea ==""){
            $.messager.alert("提示","客房面积不能为空!","info");
            return ;
        }else if(modifyVipPrice ==""){
            $.messager.alert("提示","客房价格不能为空!","info");
            return ;
        }

        var modifyRoomId = 35;
        $.post(" /htm/hotelRoomInfoModify.action", {
            modifyRoomId:modifyRoomId,
            modifyRoomNo:modifyRoomNo,
            modifyRoomType: modifyRoomType,
            modifyIsClean:modifyIsClean,
            modifyIsLive:modifyIsLive,
            modifyRoomArea:modifyRoomArea,
            modifyIsVip:modifyIsVip,
            modifyVipPrice:modifyVipPrice
        },function(data){
            $.messager.progress('close');
            if (data.status) {
                $.messager.alert("信息", "添加客房成功", "info");
                $('#dgAdminDetail').dialog('close');
                datagridBind();
            } else {
                var message = "添加客房失败！";
                if (data.message != null) {
                    message = data.message;
                }
                $.messager.alert("信息", message, "error");
            }
        }, "json");

    }
    
    //显示客房详细信息
    function opterRoomDetail(value,row) {
        return "<a href=\"javascript:void(0)\" style='color: red' title=\"结算申请\" name=\"operateDetail\" onclick=\"showOperateDetail('\" + row.accountId + \"')\" >" + "点击" + "</a>\";";
    }
    

    //查询按钮
    function btnSearch() {
        datagridBind();
    }

    function showRoomType(value) {
        if(value ==0){
            return "新建";
        }else if(value ==1){
            return "普通大床房";
        }else if(value ==2){
            return "普通双人床";
        }
        return value;
    }
    function showIsClean(value) {
        if(value ==0){
            return "否";
        }else if(value ==1){
            return "是";
        }
        return value;
    }
    function showIsLive(value) {
        if(value ==0){
            return "否";
        }else if(value ==1){
            return "是";
        }
        return value;
    }
    function showRoomArea(value) {
        return value.toString().concat("平")
    }
    function showIsVip(value) {
        if(value ==0){
            return "否";
        }else if(value==1){
            return "是";
        }
        return value;
    }


    //获取n天前 yyyy-MM-dd
    function currNDate(n) {
        var date = new Date();//获取当前时间
        date.setDate(date.getDate() - n);//设置n天前
        var currTime = dateTimeFormat(date);
        return currTime.substring(0, 10);
    }
    //对时间进行格式化
    function timeStamp2DateTime(timeStamp) {
        timeStamp = parseInt(timeStamp);
        if (timeStamp > 0) {
            var datetime = new Date(timeStamp);
            return dateTimeFormat(datetime);
        } else {
            return "";
        }
    }
    function timeStamp2Date(timeStamp) {
        if (timeStamp > 0) {
            var dateTime = timeStamp2DateTime(timeStamp);
            return dateTime.substring(0, 10);
        } else {
            return "";
        }
    }
    function dateTimeFormat(date) {
        var month = date.getMonth() + 1;
        if (month < 10) {
            month = "0" + month;
        }
        var day = date.getDate();
        if (day < 10) {
            day = "0" + day;
        }
        var hour = date.getHours();
        if (hour < 10) {
            hour = "0" + hour;
        }
        var minutes = date.getMinutes();
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        var second = date.getSeconds();
        if (second < 10) {
            second = "0" + second;
        }
        var datetime = date.getFullYear() + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + second;
        return datetime;
    }
</script>
</body>
</html>
