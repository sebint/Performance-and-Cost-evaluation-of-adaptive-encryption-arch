<!----start-header---->
<div class="header" id="home">
	  <div class="container">
			<div class="logo">
				<a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/images/logo-3.png" alt=""></a>
			</div>
			<div class="menu">			
			  <div class="top-menu navigation">
				 <span class="menu"></span> 
				 <ul class="navig">
                                         <li><a href="${pageContext.request.contextPath}">Home</a></li>
					 <li><a href="about.html">About</a></li>
					 <li><a href="pages.html">Services</a></li>
					 <li><a href="gallery.html">Gallery</a></li>
					 <li><a href="contact.html">Contact</a></li>
				 </ul>
			  </div>
			   <!-- script-for-menu -->
		 <script>
				$("span.menu").click(function(){
					$(" ul.navig").slideToggle("slow" , function(){
					});
				});
		 </script>
		 <!-- script-for-menu -->

			  <div class="search">
					 <form>
						<input type="text" value="" placeholder="Search...">
						<input type="submit" value="">
						</form>
				</div>
			</div>
		  <div class="clearfix"></div>
	 </div>	
</div>
<!----end-header---->