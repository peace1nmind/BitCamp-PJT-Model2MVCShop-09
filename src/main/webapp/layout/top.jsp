<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

	<head>
	
		<title>Model2 MVC Shop</title>
		
		<link href="/css/left.css" rel="stylesheet" type="text/css">
		
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	
		<script type="text/javascript">
			
			$(function() {
				
				$("#logInOut span").on({
					'click': function() {
				
						var text = $(this).text().replace(/\s/g, "");
						
						console.log("로그인/로그아웃= "+text);
						
						switch(text) {
							
						case "login":
							$(window.parent.frames["rightFrame"].document.location).attr("href", "/user/login");
							break;
						
						case "logout":
							$(window.parent.document.location).attr("href","/user/logout");
							break;
						}
					}

				});
				
// 				$("td[width='800'] h2").on('click', function() {
					
// 					alert("home으로 이동");
// 					location.href="/";
					
// 				});
				
			});
		
		</script>
		
		<style type="text/css">
			#logInOut span:hover {cursor: pointer;}
		</style>
	
	</head>
	
	<body topmargin="0" leftmargin="0">
	 
		<table width="100%" height="50" border="0" cellpadding="0" cellspacing="0">
		  <tr>
			<td height="10"></td>
			<td height="10" >&nbsp;</td>
		  </tr>
		  <tr>
		    <td width="800" height="30"><h2>&emsp;Model2 MVC Shop</h2></td>
		  </tr>
		  <tr>
		    <td height="20" align="right" background="/images/img_bg.gif">
			    <table width="200" border="0" cellspacing="0" cellpadding="0" id="logInOut">
			        <tr> 
		        		<c:if test="${ empty user }">
							<td width="56">
								<span>login</span>
							</td>
			          	</c:if> 

			          	<c:if test="${ ! empty user }">
				        	<td width="56">
					      		<span>logout</span>
				          	</td>
			          	</c:if>
			        </tr>
		        </table>
	      	</td>
	      	
		    <td height="20" background="/images/img_bg.gif">&nbsp;</td>
		    
		  </tr>
		</table>
	
	</body>
</html>