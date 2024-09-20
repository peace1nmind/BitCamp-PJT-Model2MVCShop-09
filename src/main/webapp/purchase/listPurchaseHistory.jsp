<%-- ���ſϷ��� ȭ�� --%>
<%-- listPurchaseHistory.do --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>

<html>

	<head>
	
		<title>��ۿϷ��� ��ȸ</title>
	
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
		<script type="text/javascript">
			function fncGetUserList() {
				document.detailForm.submit();
			}
			
		</script>
		
		<style>
	        a.disabled {
	            pointer-events: none; /* ��ũ Ŭ�� ��Ȱ��ȭ */
	            color: #FFFFFF; /* ��Ȱ��ȭ �� ��ũ�� ���� ���� */
	            text-decoration: none; /* ��ũ ���� ���� */
	            cursor: default; /* �⺻ Ŀ���� ���� */
	        }
	        
    	</style>
		
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
	
		<div style="width: 98%; margin-left: 10px;">
		
			<form name="detailForm" action="/purchase/listPurchaseHistory" method="post">
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
				
					<tr>
						<td colspan="11">��ü ${historyMap.count } �Ǽ�, ���� ${historyPaging.currentPage } ������</td>
					</tr>
					<tr>
						<td class="ct_list_b" width="50">No</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="100">��ǰ��</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="100">�޴»��</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">��ȭ��ȣ</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">��������</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">�����Ȳ</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">��������</td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="808285" height="1"></td>
					</tr>
					
					<c:forEach var="purchase" items="${historyMap.list }" varStatus="status">
						<tr class="ct_list_pop">
							<td align="center">
								${status.count }
							</td>
							
							<td></td>
							<%-- ��ǰ�� --%>
							<td align="left">
								<a href="/product/getProduct?prodNo=${purchase.purchaseProd.prodNo }">
									${purchase.purchaseProd.prodName }
								</a>
							</td>
							
							<td></td>
							
							<%-- �޴»�� --%>
							<td align="left">
								${purchase.receiverName }
							</td>
							
							<td></td>
							
							<%-- ��ȭ��ȣ --%>
							<td align="left">
								${purchase.receiverPhone }
							</td>
							
							<td></td>
							
							<%-- �������� --%>
							<td align="left">
								${purchase.orderDate }
							</td>
							
							<td></td>
							
							<%-- �����Ȳ --%>
							<td align="left">
								${tranCodeMap[purchase.tranCode] }
							</td>
							
							<td></td>
							
							<%-- ��������(����Ȯ��) --%>
							<td align="left">
							
								<c:if test="${purchase.tranCode=='4' }">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=5">
										����Ȯ��
									</a>
								</c:if>
								
							</td>
						</tr>
						
					</c:forEach>
					
					
					<c:if test="${historyPaging.total == 0 }">
						<tr class="ct_list_pop">
							<table>
								<tr>
									<td></td>
									<td align="center">
										<h3>��ۿϷ� �̷��� �����ϴ�.</h3>
									</td>
								</tr>
							</table>
						</tr>
					</c:if>

					
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					
					<tr>
						<td align="center">

							<a href="/purchase/listPurchase?historyPage=1" 
							${(historyPaging.left)? "":"class='disabled'" }>
								<span>��</span>
							</a>
							
							&nbsp;
							
							<a href="/purchase/listPurchase?historyPage=${historyPaging.start - 1 }" 
							${(historyPaging.left)? "":"class='disabled'" }>
								<span>����</span>
							</a>
					
							&nbsp;&nbsp;
							
							<c:forEach begin="${historyPaging.start }" end="${historyPaging.end }" varStatus="status">
							
								<a href="/purchase/listPurchase?historyPage=${status.count }" 
								${(historyPaging.currentPage==status.count)? "style='font-weight: bold; font-size: 15px'" : "" }>
									${status.count }
								</a> 
								
							</c:forEach>

							&nbsp;&nbsp;
							
							<a href="/purchase/listPurchase?historyPage=${historyPaging.end + 1 }" 
							${(historyPaging.right)? "":"class='disabled'" }>
								<span>����</span>
							</a>
							
							&nbsp;
							
							<a href="/purchase/listPurchase?historyPage=${historyPaing.totalPage }" 
							${(historyPaging.right)? "":"class='disabled'" }>
								<span>��</span>
							</a>

						</td>
					</tr>
					
				</table>
			
			<!--  ������ Navigator �� -->
			</form>
		
		</div>
		
		<br><br>
		
	</body>
</html>
