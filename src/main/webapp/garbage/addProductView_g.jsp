<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 버리는거 --%>
    
<!DOCTYPE html>

<html>
	<head>
		<title>상품등록</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		<script src="https://code.jquery.com/jquery-2.2.4.js" 
				integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI=" 
				crossorigin="anonymous"></script>
				
		<script type="text/javascript" src="/javascript/calendar.js"></script>
		<script type="text/javascript" src="/javascript/common.js"></script>
		<script type="text/javascript" src="/javascript/addProductView.js"></script>
		
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
		
		<form name="detailForm" method="post" enctype="multipart/form-data">
		
			<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">
								
									<c:if test="${!empty fnc }">
									
										<c:if test="${fnc == 'add' }">
											상품등록
										</c:if>
										
										<c:if test="${fnc == 'update' }">
											상품수정
										</c:if>
											
									</c:if>
									
								</td>
								<td width="20%" align="right">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
					</td>
				</tr>
			</table>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="105">
									<input type="text" name="prodName" class="ct_input_g" 
												style="width: 100px; height: 19px" maxLength="20">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품상세정보
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="prodDetail" class="ct_input_g" 
									style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						제조일자 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="manuDate" readonly="readonly" class="ct_input_g"  
									style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>
							&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" id="calendar"/>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						가격 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="price" 	class="ct_input_g" 
									style="width: 100px; height: 19px" maxLength="10">&nbsp;원
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">상품이미지</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input	type="file" name="file" class="ct_input_g" 
								style="width: 200px; height: 19px" maxLength="13" accept="image/*"/>
					</td>
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
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
								<a href="javascript:fncAddProduct();">등록</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
							
							<td width="30"></td>
							
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
								<a href="javascript:resetData();">취소</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
							</td>
							
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

