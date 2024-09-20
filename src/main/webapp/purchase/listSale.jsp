<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

	<head>
	
		<title>���ſϷ� ���</title>
	
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
		
<!-- 			<form name="detailForm" action="/listPurchaseHistory.do" method="post"> -->
<%-- 			<form name="detailForm" action="/product/listProduct?menu=${menu }" method="post">		 --%>
			
				<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
				
					<tr>
						<td colspan="11">��ü ${salePaging.total } �Ǽ�, ���� ${salePaging.currentPage } ������</td>
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
					
					<c:forEach var="purchase" items="${saleMap.list }" varStatus="status">
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
							
							<%-- ��������(����ϱ�) --%>
							<td align="left">
						
								<c:if test="${menu=='manage' && purchase.purchaseProd.proTranCode=='2' }">
									&nbsp;
									<%-- prodNo�� ���� updateTranCode(tranNo, tranCode) --%>
									<a href="/purchase/updateTranCode?&prodNo=${purchase.purchaseProd.prodNo }
																		&tranCode=3">
										����ϱ�
									</a>
								</c:if>
								
							</td>
						</tr>
						
					</c:forEach>
					
					
					<c:if test="${salePaging.total == 0 }">
						<tr class="ct_list_pop">
							<table>
								<tr>
									<td></td>
									<td align="center">
										<h3>�����(���ſϷ� ������) ��ǰ�� �����ϴ�.</h3>
									</td>
								</tr>
							</table>
						</tr>
					</c:if>

					
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
					
					<tr>
						<td align="center">

							<a href="/product/listProduct?page=${paging.currentPage }
															&menu=${menu}
															&searchCondition=${search.searchCondition}
															&searchKeyword=${search.searchKeyword}
															&orderBy=${search.orderBy}&desc=${search.desc}
															&salePage=1" 
							${(salePaging.left)? "":"class='disabled'" }>
								<span>��</span>
							</a>
							
							&nbsp;
							
							<a href="/product/listProduct?page=${paging.currentPage }
															&menu=${menu}
															&searchCondition=${search.searchCondition}
															&searchKeyword=${search.searchKeyword}
															&orderBy=${search.orderBy}&desc=${search.desc}
															&salePage=${salePaging.start - 1 }" 
							${(salePaging.left)? "":"class='disabled'" }>
								<span>����</span>
							</a>
					
							&nbsp;&nbsp;
							
							<c:forEach begin="${salePaging.start }" end="${salePaging.end }" varStatus="status">
							
								<a href="/product/listProduct?page=${paging.currentPage }
																&menu=${menu}
																&searchCondition=${search.searchCondition}
																&searchKeyword=${search.searchKeyword}
																&orderBy=${search.orderBy}&desc=${search.desc}
																&salePage=${status.count }" 
								${(salePaging.currentPage==status.count)? "style='font-weight: bold; font-size: 15px'" : "" }>
									${status.count }
								</a> 
								
							</c:forEach>

							&nbsp;&nbsp;
							
							<a href="/product/listProduct?page=${paging.currentPage }
															&menu=${menu}
															&searchCondition=${search.searchCondition}
															&searchKeyword=${search.searchKeyword}
															&orderBy=${search.orderBy}&desc=${search.desc}
															&salePage=${salePaging.end + 1 }" 
							${(salePaging.right)? "":"class='disabled'" }>
								<span>����</span>
							</a>
							
							&nbsp;
							
							<a href="/product/listProduct?page=${paging.currentPage }
															&menu=${menu}
															&searchCondition=${search.searchCondition}
															&searchKeyword=${search.searchKeyword}
															&orderBy=${search.orderBy}&desc=${search.desc}
															&salePage=${salePaging.totalPage }" 
							${(salePaging.right)? "":"class='disabled'" }>
								<span>��</span>
							</a>

						</td>
					</tr>
					
				</table>
			
			<!--  ������ Navigator �� -->
<!-- 			</form> -->
		
		</div>
		
		<br><br>
		
	</body>
</html>
