<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
	<head>
	
		<title>상품상세조회</title>
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		<script src="https://code.jquery.com/jquery-2.2.4.js" 
				integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI=" 
				crossorigin="anonymous"></script>
		
		<script type="text/javascript">
		
			$(function() {
				var price = parseInt($("#productPrice").text());
				
				console.log(price.toLocaleString());
				
				$("#productPrice").text(price.toLocaleString());
			});
		
		</script>
	
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
	
		<form name="detailForm" method="post">
		
			<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">상품상세조회</td>
								<td width="20%" align="right">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
					</td>
				</tr>
			</table>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="105">${product.prodNo }</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.prodName }</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품이미지 <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">

						<c:if test="${!empty product.fileName }">
							<img src = "/images/uploadFiles/${product.fileName }" width="300" height="300"/>
						</c:if>

					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.prodDetail }</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">제조일자</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.manuDate }</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">가격</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01" id="productPrice">${product.price }</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">등록일자</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.regDate }</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
			</table>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
				<tr>
					<td width="53%"></td>
					<td align="right">
			
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
						
						<c:choose>
							
							<c:when test="${user.role=='admin' }">
						
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
									<a href="/product/updateProduct?prodNo=${product.prodNo }">수정</a>
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23">
								</td>
								
							</c:when>
							
							<c:when test="${user.role=='user' && product.proTranCode=='1' }">
						
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
									<a href="/purchase/addPurchase?prodNo=${product.prodNo }">구매</a>
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23">
								</td>
								
							</c:when>

						</c:choose>
						
							<td width="30"></td>
							
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
								<a href="javascript:history.go(-1)">이전</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23">
							</td>
						</tr>
					</table>
			
					</td>
				</tr>
			</table>
		</form>
	
	</body>
</html>
