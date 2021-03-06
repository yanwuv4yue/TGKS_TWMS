<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<input type="hidden" id="dealListSubmit" name="dealListSubmit" value="0" />
<div id="dealTableDiv" class="ui-widget">
    <table id="dealTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header ">
                <th width="20"><input type="checkbox" id="allDealId" name="allDealId"/></th>
				<th>商品名称</th>
				<th>商品编号</th>
				<th>订单编号</th>
				<th>过款状态</th>
				<th>过库状态</th>
				<th>交易类型</th>
				<th>交易数量</th>
				<th>交易价格</th>
				<th>交易时间</th>
				<th>付款时间</th>
				<th>备注</th>
            </tr>
        </thead>
        <tbody>
			<s:iterator  value="list" var="evt">
				<tr>
					<td width="20"><input type="checkbox" name="dealId" value="<s:property value='#evt.id'/>"/></td>
					<td><b id="<s:property value='#evt.id'/>" class="dealUpdate"><s:property value="#evt.commodityName"/></b></td>
					<td><s:property value="#evt.commodityCode"/></td>
					<td><s:property value="#evt.orderCode"/></td>
					<td>
						<s:if test="#evt.payStatus == 0">
							未过款
						</s:if>
						<s:elseif test="#evt.payStatus == 1">
							已付款
						</s:elseif>
						<s:if test="#evt.payStatus == 2">
							已收款
						</s:if>
					</td>
					<td>
						<s:if test="#evt.storeStatus == 0">
							未过库
						</s:if>
						<s:elseif test="#evt.storeStatus == 1">
							已入库
						</s:elseif>
						<s:if test="#evt.storeStatus == 2">
							已出库
						</s:if>
					</td>
					<td>
						<s:if test="#evt.type == 0">
							购入
						</s:if>
						<s:elseif test="#evt.type == 1">
							售出
						</s:elseif>
					</td>
					<td><s:property value="#evt.number"/></td>
					<td><s:property value="#evt.price"/></td>
					<td><s:date name="#evt.createTime" format="yyyy-MM-dd HH:mm:ss"/></td>
					<td><s:date name="#evt.dealTime" format="yyyy-MM-dd HH:mm:ss"/></td>
					<td><s:property value="#evt.remark"/></td>
				</tr>
			</s:iterator>
		</tbody>
    </table>
</div>
<script type="text/javascript">
	$(function () {
		$('#dealTable').longtable({'perPage': 10});
		
		// 点击记录首栏进入更新操作
		$(".dealUpdate").click(function() {
			$("#dealManagerSubmit").val("1");
			$("#orderDealSubmit").val("1");
			$("#dealEdit").dialog("open");
			var edit = $.ajax({
				url : "../wms/editDealPage.action?id=" + this.id,
				async : false
			});
			$("#dealForm").html(edit.responseText);
		});

		// 全选
		$("#allDealId").click(function(){
			var checkbox = $("#dealTable :checkbox");
			for (var i = 1; i < checkbox.length; i++)
			{
				if (checkbox[i].hidden == "")
				{
					checkbox[i].checked = checkbox[0].checked;
				}
			}
		});
	});
</script>
