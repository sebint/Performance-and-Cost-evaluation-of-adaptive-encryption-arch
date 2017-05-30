<%-- 
    Document   : error_404
    Created on : Aug 5, 2015, 3:05:32 PM
    Author     : ZionZ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page not found</title>
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel='stylesheet' type='text/css' />
        <link href="<%=request.getContextPath()%>/css/style.css" rel='stylesheet' type='text/css' />
        <script src="<%=request.getContextPath()%>/js/jquery-1.11.0.min.js"></script>
    </head>
    <body>
         <%@include file="../_header.jsp" %>
         <!-- 404 -->
	<div class="e-page">
		<!-- container -->
		<div class="container_404">
			<h3 class="wow fadeInLeft animated" data-wow-delay="0.4s" style="visibility: visible; -webkit-animation-delay: 0.4s;">500</h3>
			<h5 class="wow fadeInRight animated" data-wow-delay="0.4s" style="visibility: visible; -webkit-animation-delay: 0.4s;">Internal Server Error</h5>
			<p class="wow fadeInLeft animated" data-wow-delay="0.4s" style="visibility: visible; -webkit-animation-delay: 0.4s;">We track these errors automatically, but if the problem persists feel free to contact us. In the meantime, try refreshing.</p>
			<div class="see-button">
				<!--<a class="btn btn-primary btn-lg see-button hvr-shutter-out-horizontal specialty-button e-button footer-middle wow bounceIn animated" data-wow-delay="0.4s" style="visibility: visible; -webkit-animation-delay: 0.4s;" href="" role="button">Tack Me Home</a>-->
                                <input value="Take me back" type="button" name="go_back" onclick="window.history.back();" class="btn btn-primary btn-lg see-button hvr-shutter-out-horizontal specialty-button e-button footer-middle wow bounceIn animated" data-wow-delay="0.4s" style="visibility: visible; -webkit-animation-delay: 0.4s;"/>
                                
			</div>
		</div>
		<!-- //container -->
	</div>
	<!-- //404 -->
         <%@include file="../_footer.jsp" %>
    </body>
</html>
