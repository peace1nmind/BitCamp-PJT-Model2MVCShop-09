<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html>

<html>

	<head>
	
		<title>${title}</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		<script type="text/javascript">
		<!--
		function fncGetProductList(){
			var bigger = document.detailForm.searchPriceBigger;
			var less = document.detailForm.searchPriceLess;
			if (bigger.value - less.value > 0 && bigger.value - less.value != bigger.value) {
				alert("���� ������ �ùٸ��� �ʽ��ϴ�");
				document.detailForm.searchPriceBigger.focus();
				document.detailForm.searchPriceBigger.setSelectionRange(document.detailForm.searchPriceBigger.value.length, document.detailForm.searchPriceBigger.value.length);
			} else {
				document.detailForm.submit();
			}
		}
		-->
		
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
		<form name="detailForm" action="/product/listProduct" method="post">
			
			<div style="width:98%; margin-left:10px;">

				<input type="hidden" name="menu" value="${menu }">
			
				<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
					<tr>
						<td width="15" height="37">
							<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
						</td>
						<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="93%" class="ct_ttl01">
									
											${title}
									
									</td>
								</tr>
							</table>
						</td>
						<td width="12" height="37">
							<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
						</td>
					</tr>
				</table>
				
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td align="right">
							<select name="searchCondition" class="ct_input_g" style="width:80px">
								
								<option value="0" ${(!empty search.searchCondition && search.searchCondition=='0')? "selected":""}>
									��ǰ��ȣ
								</option>
								<option value="1" ${(!empty search.searchCondition && search.searchCondition=='1')? "selected":""}>
									��ǰ��
								</option>
								
								<!-- Mapper �߰��ʿ� -->
								<option value="2" ${(!empty search.searchCondition && search.searchCondition=='1')? "selected":""}>
									��ǰ����
								</option>
								
							</select>
							
							<input type="text" name="searchKeyword" value="${search.searchKeyword}" 
									class="ct_input_g" style="width:200px; height:19px" />
							
						</td>
						
						<td align="right" width="70">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="17" height="23">
										<img src="/images/ct_btnbg01.gif" width="17" height="23">
									</td>
									<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
										<a href="javascript:fncGetProductList();">�˻�</a>
									</td>
									<td width="14" height="23">
										<img src="/images/ct_btnbg03.gif" width="14" height="23">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td align="right">
							<input type="number" name="searchPriceBigger" value="${search.searchPriceBigger}" 
									class="ct_input_g" style="width:200px; height:19px" />
							~
							<input type="number" name="searchPriceLess" value="${search.searchPriceLess}" 
									class="ct_input_g" style="width:200px; height:19px" />
							
						</td>
						
						<td align="right" width="70">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="17" height="23">
										<img src="/images/ct_btnbg01.gif" width="17" height="23">
									</td>
									<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
										<a href="javascript:fncGetProductList();">�˻�</a>
									</td>
									<td width="14" height="23">
										<img src="/images/ct_btnbg03.gif" width="14" height="23">
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
					<tr>
						<td colspan="11" >��ü ${paging.total} �Ǽ�, ���� ${paging.currentPage} ������</td>
					</tr>
					<tr>
						<td class="ct_list_b" width="100">No</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="150">��ǰ��</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b" width="150">
							����&nbsp;
							<input type="button" value="���" 
									onclick="window.location.href='/product/listProduct?page=1&menu=${menu}&searchCondition=${search.searchCondition}&searchKeyword=${search.searchKeyword}&orderBy=price&desc=${!search.desc}'">
						</td>
						<td class="ct_line02"></td>
						<td class="ct_list_b">�����</td>	
						<td class="ct_line02"></td>
						<td class="ct_list_b">�������</td>	
					</tr>
					<tr>
						<td colspan="11" bgcolor="808285" height="1"></td>
					</tr>
					
					<c:forEach items="${map.list}" var="product" varStatus="status">
					
						<tr class="ct_list_pop">
							<td align="center">${status.count}</td>
							<td></td>
									
							<td align="left">
								<a href="/product/${navi}?prodNo=${product.prodNo}">
									${product.prodName}
								</a>
							</td>
							
							<td></td>
							<td align="left">${product.price}</td>
							<td></td>
							<td align="left">${product.regDate}</td>
							<td></td>
							
							<td align="left">
								${tranCodeMap[product.proTranCode]}
							</td>	
						</tr>
						<tr>
							<td colspan="11" bgcolor="D6D7D6" height="1"></td>
						</tr>	
						
					</c:forEach>
					
				</table>
				
				<input type="hidden" name="page" value="${paging.currentPage}">
				
<!-- 				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;"> -->
<!-- 					<tr> -->
<!-- 						<td align="center"> -->
					
<%-- 							<a href="/product/listProduct?page=1 --%>
<%-- 															&menu=${menu} --%>
<%-- 															&searchCondition=${search.searchCondition} --%>
<%-- 															&searchKeyword=${search.searchKeyword} --%>
<%-- 															&orderBy=${search.orderBy} --%>
<%-- 															&desc=${search.desc} --%>
<%-- 															&salePage=${salePaging.currentPage} --%>
<%-- 															&searchPriceBigger=${search.searchPriceBigger} --%>
<%-- 															&searchPriceLess=${search.searchPriceLess}"  --%>
<%-- 							${(paging.left)? "":"style='visibility:hidden'"}> --%>
<!-- 								<span>��</span> -->
<!-- 							</a> -->
							
<!-- 							&nbsp; -->
							
<%-- 							<a href="/product/listProduct?page=${paging.start - 1} --%>
<%-- 															&menu=${menu} --%>
<%-- 															&searchCondition=${search.searchCondition} --%>
<%-- 															&searchKeyword=${search.searchKeyword} --%>
<%-- 															&orderBy=${search.orderBy} --%>
<%-- 															&desc=${search.desc} --%>
<%-- 															&salePage=${salePaging.currentPage} --%>
<%-- 															&searchPriceBigger=${search.searchPriceBigger} --%>
<%-- 															&searchPriceLess=${search.searchPriceLess}"  --%>
<%-- 							${(paging.left)? "":"style='visibility:hidden'"}> --%>
<!-- 								<span>����</span> -->
<!-- 							</a> -->
							
<!-- 							&nbsp;&nbsp; -->
							
<%-- 					<c:forEach begin="${paging.start}" end="${paging.end}" var="i" > --%>
<%-- 							<a href="/product/listProduct?page=${i} --%>
<%-- 															&menu=${menu} --%>
<%-- 															&searchCondition=${search.searchCondition} --%>
<%-- 															&searchKeyword=${search.searchKeyword} --%>
<%-- 															&orderBy=${search.orderBy} --%>
<%-- 															&desc=${search.desc} --%>
<%-- 															&salePage=${salePaging.currentPage} --%>
<%-- 															&searchPriceBigger=${search.searchPriceBigger} --%>
<%-- 															&searchPriceLess=${search.searchPriceLess}"  --%>
<%-- 							${(paging.currentPage==i)? "style='font-weight: bold; font-size: 15px'" : ""}> --%>
<%-- 								${i} --%>
<!-- 							</a> -->
<%-- 					</c:forEach> --%>
					
<!-- 							&nbsp;&nbsp; -->
						
							
<%-- 							<a href="/product/listProduct?page=${paging.end + 1} --%>
<%-- 															&menu=${menu} --%>
<%-- 															&searchCondition=${search.searchCondition} --%>
<%-- 															&searchKeyword=${search.searchKeyword} --%>
<%-- 															&orderBy=${search.orderBy} --%>
<%-- 															&desc=${search.desc} --%>
<%-- 															&salePage=${salePaging.currentPage} --%>
<%-- 															&searchPriceBigger=${search.searchPriceBigger} --%>
<%-- 															&searchPriceLess=${search.searchPriceLess}"  --%>
<%-- 							${(paging.right)? "":"style='visibility:hidden'"}> --%>
<!-- 								<span>����</span> -->
<!-- 							</a> -->
							
<!-- 							&nbsp; -->
							
<%-- 							<a href="/product/listProduct?page=${paging.totalPage} --%>
<%-- 															&menu=${menu} --%>
<%-- 															&searchCondition=${search.searchCondition} --%>
<%-- 															&searchKeyword=${search.searchKeyword} --%>
<%-- 															&orderBy=${search.orderBy} --%>
<%-- 															&desc=${search.desc} --%>
<%-- 															&salePage=${salePaging.currentPage} --%>
<%-- 															&searchPriceBigger=${search.searchPriceBigger} --%>
<%-- 															&searchPriceLess=${search.searchPriceLess}"  --%>
<%-- 							${(paging.right)? "":"style='visibility:hidden'"}> --%>
<!-- 								<span>��</span> -->
<!-- 							</a> -->
							

<!-- 				    	</td> -->
<!-- 					</tr> -->
<!-- 				</table> -->
				<!--  ������ Navigator �� -->
			
			<jsp:include page="../common/pagingNavigator.jsp">
				<jsp:param value="false" name="isSale"/>
			</jsp:include>
			
			</div>

		
		
		<br><br>
		
		<c:if test="${menu=='manage'}">
			<%	System.out.println("\tinclude �߻�: listSale.jsp"); %>
<%-- 			<jsp:include page="/purchase/listSale.jsp"></jsp:include> --%>
			<%@ include file="../purchase/listSale.jsp" %>
		</c:if>
		
		</form>
		
	</body>
</html>
