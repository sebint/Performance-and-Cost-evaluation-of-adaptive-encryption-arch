
<%-- 
    Document   : index
    Created on : Jul 21, 2015, 11:43:12 AM
    Author     : ZionZ
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="iCloud_Pack.DBConnect" %>
<!DOCTYPE html>
<html>
    <head>      
        <title>iCloud connect | Home </title>
        <script type="application/x-javascript"> 
            addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 
        </script>
        <link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
        <link href="css/style.css" rel='stylesheet' type='text/css' />
        <script src="js/jquery.chocolat.js" type="text/javascript"></script>
        <link href="css/flexslider.css" rel="stylesheet" type="text/css"/>
        <link href="css/chocolat.css" rel="stylesheet" type="text/css"/>
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/jquery-1.11.0.min.js"></script>
        <!-- banner Slider starts Here -->
        <script>
            // You can also use "$(window).load(function() {"
            $(function () {
                // Slideshow 4
                $("#slider3").responsiveSlides({
                    auto: true,
                    pager: false,
                    nav: false,
                    speed: 500,
                    namespace: "callbacks",
                    before: function () {
                        $('.events').append("<li>before event fired.</li>");
                    },
                    after: function () {
                        $('.events').append("<li>after event fired.</li>");
                    }
                });

            });
        </script>
        <!--//End-slider-script -->
        <%
            DBConnect dbcon = new DBConnect();
            String uname = null;
            String pass = null;
            int i = dbcon.putData("SET GLOBAL max_allowed_packet=524288000");
           //create Admin account at the primary startup of the application
            //username=admin_icloud@icloud.com and Pass= admin
            //Change the passsword at firat login
            try {
                if (dbcon.createAd() == 0) {
                    if (dbcon.iCloud_Register("Admin", "admin_icloud@icloud.com", "admin", 1) > 0) {
                        uname = "admin_icloud@icloud.com";
                        pass = "admin";
        %>
        <script>
            $('#adnotif').modal('show');
        </script>
        <%
        } else {
        %>
        <script>
            $('#adnotif').modal('show');
        </script>
        <%
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        %>
    </head>
    <body>
        <%@include file="_header.jsp" %>
        <div class="banner">

            <div  id="top" class="callbacks_container">

                <ul class="rslides" id="slider3">
                    <li><div class="banner-bg"></div></li>
                    <li><div class="banner-bg banner2"></div></li>
                </ul>

            </div>
            <div class="container">
                <div class="banner-sec">
                    <div class="banner-top">
                        <!--                                                                    <div class="col-md-4 banner-text">
                                                                                                    <div class="banner-text_grid">
                                                                                                     <img src="images/icon1.png" class="img-responsive" alt="/">
                                                                                                    <h4>Connect </h4>
                                                                                                    <p>Cras consequat iaculis lorem, id vehicula erat mattis quis. Vivamus laoreet velit justo, in ven e natis purus.</p>
                                                                                                    </div>
                                                                                            </div>
                                                                                            <div class="col-md-4 banner-text">
                                                                                                    <div class="banner-text_grid1">
                                                                                                     <img src="images/icon2.png" class="img-responsive" alt="/">
                                                                                                    <h4>Store </h4>
                                                                                                    <p>Cras consequat iaculis lorem, id vehicula erat mattis quis. Vivamus laoreet velit justo, in ven e natis purus.</p>
                                                                                                    </div>
                                                                                            </div>-->
                        <div class="col-md-12 banner-text">
                            <div class="banner-text_grid2">
                                <img src="images/icon3.png" class="img-responsive" alt="/">
                                <h4>Connect | Store | Share </h4>
                                <p>iCloud Connect keeps your files Safe,Secure and easy to Share.The Adaptive encryption makes the file more Secure.Now start Uploading..</p>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default rg" onclick="window.location = 'user/'">REGISTER</button>
                                    <button type="submit" class="btn btn-primary lgn" onclick="window.location = 'user/'">LOGIN</button>
                                </div>
                            </div>
                        </div>				
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--welcome-starts--> 
        <div class="welcome">
            <div class="container">
                <div class="welcome-top">
                    <div class="head text-center work-head">
                        <h3><span> </span> How iCloud Work</h3>
                        <p>Manage all your files, access them from anywhere, and share them with anyone securely.With iCloud, you can store all kinds of files online – from presentations, school papers, photos and videos to financials, spreadsheets and taxes. Keep everything organized in folders just like on your desktop.</p>
                    </div>
                    <!---- start-work-grids----->
                    <div class="work-grids">
                        <div class="col-md-4 work-grid wone">
                            <span class="col-md-5 w-icon"> <i class="fa fa-cloud"> </i></span>
                            <div class="col-md-7 work-info">
                                <h4>Connect</h4>
                                <p>Connect with iCloud using your iCloud user credentials, where you will find the interface just like your Desktop.  </p>
                            </div>
                        </div>
                        <div class="col-md-4 work-grid wtwo center-work-grid">
                            <span class="col-md-5 w-icon"> <i class="fa fa-cloud-upload"> </i></span>
                            <div class="col-md-7 work-info">
                                <h4>Store</h4>
                                <p>Upload your values files to iCloud by choosing the adaptive encryption method suitable for your files.</p>
                            </div>
                        </div>
                        <div class="col-md-4 work-grid wthree">
                            <span class="col-md-5 w-icon"><i class="fa fa-share-alt"> </i> </span>
                            <div class="col-md-7 work-info">
                                <h4>Share</h4>
                                <p>Share your files in one click with other users of the iCloud and access the files anywhere around the world.</p>
                            </div>
                        </div>
                        <div class="clearfix"> </div>
                        <div class="work-map">
                            <span> </span>
                        </div>
                    </div>
                    <!---- //End-work-grids----->  
                    <hr>
                </div>

                <div class="welcome-bottom">
                    <div class="col-md-6 welcome-left">
                        <h3>The Secure Content Platform</h3>
                        <p>iCloud transforms the way you share, manage and collaborate on your most valuable corporate information. Designed without compromise between security and ease-of-use, iCloud allows every user to securely share, with other users - on any device, anywhere. Adopt iCloud as your secure content platform.</p>
                        <div class="welcome-one">
                            <div class="col-md-6 welcome-one-left">
                                <a href="single.html"><img src="images/w-6.jpg" alt="" /></a>
                            </div>
                            <div class="col-md-6 welcome-one-right">
                                <a href="single.html"><img src="images/w-4.jpg" alt="" /></a>
                                <a href="single.html" class="one-top"><img src="images/w-5.jpg" alt="" /></a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div class="col-md-6 welcome-left">
                        <h3>Access, Share and Protect Personal Data</h3>
                        <p>Use iCloud to store, manage and share your files securely in the cloud. Access your content anywhere you might need it: web, tablet or phone. Plus, you can share large files with a simple link and work on projects with your friends, family or colleagues from anywhere.</p>
                        <div class="welcome-one">
                            <a href="single.html"><img src="images/w-2.jpg" alt="" /></a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <!--welcome-ends-->
        <div class="content">
            <div class="container">
                <div class="content-slogan">
                    <p>Access your files from <a>Anywhere</a> at <a>Anytime,</a> from <a>Any Device</a>.</p>
                    <!--<p>Lorem ipsum dolor sit amet, <a href="#">consectetur</a> adipisicing elit. sed  incididunt ut <a href="#">labore</a> et dolore magna aliqua. Ut enim ad <a href="#">minim veniam.</a> </p>-->
                </div>
                <div class="slogan-sub">
                    <p>iCloud lets you store all your files online so you can access them from anywhere at anytime.Every iCloud account comes with all the features of Free cloud storage,Simple and Easy to Use,Encrypted and secure and Access files anywhere.The Adaptive Encryption Methodology lets you choose the Encryption Method for your each file.</p>
                </div>
                <div class="clearfix"> </div>
                <div class="grids">
                    <div class="section group">
                        <div class="col-md-4 images_1_of_3">
                            <img src="images/g1.png">
                            <h3>File Protection</h3>
                            <p>Your valuable data is protected using the different Encryption Methods.Data is encrypted as three layers and stored in the cloud storage.</p>
                            <div class="button"><span><a href="about.html">Read More</a></span></div>
                        </div>
                        <div class="col-md-4 images_1_of_3">
                            <img src="images/g2.png">
                            <h3>Share Files</h3>
                            <p>You can Share your data to other users of the iCloud in a click.They can use your files as you do.Also you can unshare whenever you want to just in a click.</p>
                            <div class="button"><span><a href="about.html">Read More</a></span></div>
                        </div>
                        <div class="col-md-4 images_1_of_3">
                            <img src="images/g3.png">
                            <h3>Mobile Access</h3>
                            <p>You can also access your files in mobiles also.Which brings you the access in anywhere with the help of your smart phone.All the features are added in the application.</p>
                            <div class="button"><span><a href="about.html">Read More</a></span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--nature-starts--> 
        <div class="nature">
            <div class="container">
                <div class="nature-top">
                    <h3>Adaptive File Encryption</h3>
                    <p>iCloud provides the Adaptive Encryption System which lets you choose from three different Encryption Methodology based on the Cost of the file and Security.</p>
                </div>
            </div>
        </div>
        <!--nature-ends-->
        <!--field-starts--> 
        <div class="fields">
            <div class="container">
                <div class="fields-top">
                    <div class="col-md-4 fields-left">
                        <span class="home"></span>
                        <h4>Vestibulum vel finibus</h4>
                        <p>Pellentesque sed sem bibendum, rutrum ipsum vitae, facilisis turpis. Mauris vitae metus gravida, hendrerit erat ac, facilisis ligula.</p>
                    </div>
                    <div class="col-md-4 fields-left">
                        <span class="men"></span>
                        <h4>Quisque non ligula</h4>
                        <p>Pellentesque sed sem bibendum, rutrum ipsum vitae, facilisis turpis. Mauris vitae metus gravida, hendrerit erat ac, facilisis ligula.</p>
                    </div>
                    <div class="col-md-4 fields-left">
                        <span class="pen"></span>
                        <h4>Lorem ipsum dolor</h4>
                        <p>Pellentesque sed sem bibendum, rutrum ipsum vitae, facilisis turpis. Mauris vitae metus gravida, hendrerit erat ac, facilisis ligula.</p>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <!--field-end--> 
        <%@include file="_footer.jsp" %>
        <!--pop up for notification Starts-->
        <div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="adnotif">
            <div class="modal-dialog modal-sm">
                <div class="modal-content delete">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="window.location = 'index.jsp'"><span aria-hidden="true">×</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel2">Rename File</h4>
                    </div>
                    <div class="modal-body">
                        <% if (uname != null && pass != null) {%> 
                        <p>The Administrator Account Has been Created!</p>
                        <p>Username:<%=uname%></p>
                        <p>Password:<%=pass%></p>
                        <p>Please Change the Password after login!</p>
                        <% } else {%>
                        <p>Creation of Administrator account Failed!.</p>
                        <p>Please create the account Manually or Restart the Applicaton!.</p>
                        <%}%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default">OK!</button>
                    </div>

                </div>
            </div>
        </div>
        <!--pop up for notification Ends-->       
        <script src="js/responsiveslides.min.js"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>

    </body>
</html>