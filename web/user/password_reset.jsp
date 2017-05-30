<%-- 
    Document   : password_reset
    Created on : Sep 29, 2015, 4:51:07 PM
    Author     : ZionZ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iCloud Connect | Reset Password</title>
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="../css/bootstrap.css" rel='stylesheet' type='text/css' />
        <link href="../css/style.css" rel='stylesheet' type='text/css' />
        <script src="../js/jquery-1.11.0.min.js"></script>
    </head>
    <body>
        <%@include file="../_header.jsp" %>
        <!--light-box-files -->
        <script src="../js/jquery.chocolat.js"></script>
        <link rel="stylesheet" href="../css/chocolat.css" type="text/css" media="screen" charset="utf-8" />
        <!--light-box-files -->
        <script type="text/javascript" charset="utf-8">
            $(function () {
                $('.gallery-bottom a').Chocolat();
            });
        </script>
        <!----end-light-box-files---->
        <div class="main-login">
            <div class="header-login" >
                <h1>Reset Password</h1>
            </div>
            <p>Reset password of your <sapn style="color: #e6515f;">iCloud</sapn> account by providing your Registered Mail Id.</p>
        <div class="form-login">
            <div class="aligncenter">
                <form method="POST" action="Reset_Pass">
                    <ul class="right-form-login">
                        <h3>Enter Username : <span style="color: red; font-size: 16px; font-weight: 100; margin-left: 16px;"> <% String status = request.getParameter("status");
                    if ("login_user".equals(status)) {
                        out.print("Login to continue!");
                    } else if ("false".equals(status)) {
                        out.print("Invalid username or password!.");
                    }%> </span></h3>

                        <li>
                            <input type="text" ID="txt_login_uname" name="txt_uname" value="Username"  onfocus="this.value = '';" onblur="if (this.value == '') {
                                this.value = 'Username';
                            }" on/>
                            <a href="#" class=" icon-login user"></a>
                        </li>
                        
                        <input type="submit" ID="btn_u_uname" name="btn_login" value="Reset Password" />
                       
                        <div class="clear"> </div>
                    </ul>

                    <div class="clear"> </div>
                </form>
            </div>
        </div>
    </div>
    <%@include file="../_footer.jsp" %> 
</body>
</html>
