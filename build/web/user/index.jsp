<%-- 
    Document   : user
    Created on : Jul 24, 2015, 10:27:09 AM
    Author     : ZionZ
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>iCloud Connect | Login</title>
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
        <!--Login Form2-->
        <div class="main-login">
            <div class="header-login" >
                <h1>Login / Create a New Account!</h1>
            </div>
            <p>Login using your existing user credentials or create your new <sapn style="color: #e6515f;">iCloud</sapn> account providing the informtions.</p>

        <div class="form-login">
            <form id="reg_user" method="POST" action="RegUser">
                <ul class="left-form-login">
                    <h2>New Account:</h2>
                    <li>
                        <input type="text" ID="txt_name" name="txt_name" value="Name"  onfocus="this.value = '';" onblur="if (this.value == '') {
                                    this.value = 'Name';
                                }"/>
                        <a href="#" class=" icon-login user"></a>
                        <div class="clear"> </div>
                    </li> 
                    <li>
                        <input type="text" ID="txt_email" name="txt_email" value="E-mail"  onfocus="this.value = '';" onblur="if (this.value == '') {
                                    this.value = 'E-mail';
                                }"/>
                        <a href="#" class=" icon-login mail"></a>
                        <div class="clear"> </div>
                    </li> 
                    <li>
                        <input type="text" ID="txt_pass" name="txt_pass"  value="Password" onfocus="this.value = '';
                                this.type = 'password';" onblur="if (this.value == '') {
                                            this.value = 'Password';
                                        }"/>
                        <a href="#" class=" icon-login lock"></a>
                        <div class="clear"> </div>
                    </li> 
                    <li>
                        <input type="text" ID="txt_conpass" name="txt_conpass" value="Retype Password"  onfocus="this.value = '';
                                this.type = 'password';" onblur="if (this.value == '') {
                                            this.value = 'Retype Password';
                                        }"/>
                        <a href="#" class=" icon-login lock"></a>
                        <div class="clear"> </div>
                    </li> 
                    <label class="checkbox"><input type="checkbox" name="checkbox" id="chkbox" checked=""><i> </i>I agree to <span style="color:#e6515f; ">iCloud</span><a href="javascript:;" onclick="termsCond()"> terms and conditions</a>.</label>
                    <input type="button" ID="btn_login" name="btn_login" value="Create your free Account" onclick="register()" />

                    <div class="clear"> </div>
                </ul>
            </form>
            <form method="POST" action="LoginController">
                <ul class="right-form-login">
                    <h3>Login:<span style="color: red; font-size: 16px; font-weight: 100; margin-left: 16px;"> <% String status = request.getParameter("status");
                        if ("login_user".equals(status)) {
                            out.print("Login to continue!");
                        } else if ("false".equals(status)) {
                            out.print("Invalid username or password!.");
                        }%> </span></h3>

                    <li>
                        <input type="text" ID="txt_login_uname" name="txt_login_uname" value="Username"  onfocus="this.value = '';" onblur="if (this.value == '') {
                                    this.value = 'Username';
                                }" on/>
                        <a href="#" class=" icon-login user"></a>
                    </li>
                    <li>
                        <input type="password" ID="txt_login_pass" name="txt_login_pass" value="Password"  onfocus="this.value = '';" onblur="if (this.value == '') {
                                    this.value = 'Password';
                                }"/>
                        <a href="#" class=" icon-login lock"></a>
                    </li>
                    <label class="checkbox"><input type="checkbox" name="checkbox" checked=""><i> </i>Keep Me Signed in</label><a href="password_reset.jsp"><h4>I Forgot My Password!</h4></a>
                    <input type="submit" ID="btn_login" name="btn_login" value="Login" />

                    <div class="clear"> </div>
                </ul>
                <div class="clear"> </div>
            </form>
        </div>

    </div>
    <!--Login form2 Ends Here-->     
    <!--pop up for Terms and Conditions Starts-->
    <div class="modal fade bs-tc-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="ter_cond">
        <div class="modal-dialog modal-sm">
            <div class="modal-content tc">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="window.location = 'index.jsp'"><span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel2">iCloud Terms and Conditions</h4>
                </div>
                <div class="modal-body">
                    <div class="BoxBorder">
                        <div class="terms-of-use">
                            <h3>Terms of Use</h3>
                            <p>These terms of service (the “Terms of Use”) govern your access to and use of all iCloud Internet Limited (“iCloud”) services (the “Services”), whether sold to you directly by Livedrive or through a Livedrive authorised retail electronic outlet (“a Retail Outlet”). Where the context so permits, the words "we", "our" and "us" refer to icloud, including its successors and assigns. Please read these Terms of Use carefully before using the Services.</p>
                            <ol>
                                <li>By using the Services you agree to be bound by these Terms of Use in their entirety for the period of time agreed between the parties, encompassing both the initial billing period agreed at sign-up and such further periods as are renewed automatically (each a “Fixed Contract Period”) in accordance with these Terms of Use.</li>
                                <li>If you are using the Services on behalf of an organisation then you are agreeing to these Terms of Use for that organisation and are warranting that you have the authority to bind that organisation to these Terms of Use. In that case "you" and "your" will refer to that organisation.</li>
                                <li>You may use the Services only in compliance with these Terms of Use. You may use the Services only if you have the power to form a contract with Livedrive and are not barred under any applicable laws from doing so. The Services may continue to change over time as we refine and add more features. We may stop, suspend, or modify the Services at any time without prior notice to you. We may also remove any content from our Services at our discretion.</li>
                            </ol>                                
                            <br>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>

                </div>
            </div>
        </div>
    </div>
    <!--pop up for Terms and Conditions Ends-->
    <%@include file="../_footer.jsp" %>
    <%
        String resp = request.getParameter("resp");
        if ("0".equals(resp)) {
    %>
    <script>alert("Invalid user");</script>
    <%
        }

    %>
    <script src="../js/bootstrap.min.js" type="text/javascript"></script>
    <script>
        function register() {
            if (document.getElementById("chkbox").checked) {
                document.getElementById("reg_user").submit();
            } else {
              
            }

        }
        function termsCond() {
            $('#ter_cond').modal('show');
        }
    </script>
</body>
</html>
