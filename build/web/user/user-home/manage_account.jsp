<%-- 
    Document   : manage_account
    Created on : Sep 5, 2015, 10:07:54 PM
    Author     : ZionZ
--%>

<%@page import="java.util.StringTokenizer"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="iCloud_Pack.DBConnect" %>
<%@page import="iCloud_Pack.Icloud_main" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%
            response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server 
            response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance 
            response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale" 
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
        %>
        <title>Manage Account</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">

        <link href="../css/font-awesome.min.css" rel="stylesheet">
        <link href="../css/animate.min.css" rel="stylesheet">

        <!-- Custom styling plus plugins -->
        <link href="../css/custom.css" rel="stylesheet">
        <script src="../js/jquery.min.js"></script>
        <link href="../css/green.css" rel="stylesheet" type="text/css"/>
        <script>
            $(function () {
                $("span.text_pos").css("font-size", "15px");
                $(".algn").css("margin-top", "6px");
                $(".algn").css("margin-left", "15px");
            });
        </script>
    </head>
    <body>
        <%
            int id = Integer.parseInt(session.getAttribute("iCloud_user_id").toString());
            DBConnect dbc = new DBConnect();
            Icloud_main im = new Icloud_main();
            ResultSet rs;
            String name = null;
            String lname = "";
            String uname = "";
            String created = "";
            try {
                ResultSet rsu = dbc.get_User_Info(id);
                while (rsu.next()) {
                    name = rsu.getString(2);
                    uname = rsu.getString(3);
                    created = im.formatDate(rsu.getDate(6));
                    created = created + " " + im.formatTime(rsu.getTime(6));

                }

            } catch (Exception ex) {
                ex.printStackTrace();
            }
            int[] filecount = dbc.file_Count(id);
            long[] dsize = dbc.file_totalsize(id);
            String size = im.formatFileSize(dsize[0]);

        %>
        <!-- top navigation -->
        <%@include file="../_pages/_header.jsp" %>
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">
            <div class="">
                <div class="page-title">
                    <div class="title_left">
                        <h3></h3>
                    </div>

                    <div class="title_right">
                        <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Search for...">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button">Go!</button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content">

                                <div class="col-md-3 col-sm-3 col-xs-12 profile_left">

                                    <div class="profile_img">

                                        <!-- end of image cropping -->
                                        <div id="crop-avatar">
                                            <!-- Current avatar -->
                                            <div class="avatar-view" title="Change the Display Picture">
                                                <img src="ImageRetrieveServlet?icloud_id=<%=id%>" alt="Avatar" onerror="this.src='../images/picture.jpg';"/>
                                            </div>

                                            <!-- Cropping modal -->
                                            <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">

                                                        <div class="modal-header">
                                                            <button class="close" data-dismiss="modal" type="button">&times;</button>
                                                            <h4 class="modal-title" id="avatar-modal-label">Change Display Image</h4>
                                                        </div>
                                                        <form method="post" action="fileUpload" enctype="multipart/form-data" class="avatar-form">  
                                                            <div class="modal-body">
                                                                <div class="avatar-body">

                                                                    <!-- Upload image and data -->
                                                                    <div class="avatar-upload">
                                                                        <input class="avatar-src" name="avatar_src" type="hidden">
                                                                        <input class="avatar-data" name="avatar_data" type="hidden">
                                                                        <label for="avatarInput">Local upload</label>
                                                                        <input class="avatar-input" id="avatarInput" name="avatar_file" type="file" accept="image/jpeg,image/png">
                                                                    </div>

                                                                    <!-- Crop and preview -->
                                                                    <div class="row">
                                                                        <div class="col-md-9">
                                                                            <div class="avatar-wrapper"></div>
                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <div class="avatar-preview preview-lg"></div>
                                                                            <div class="avatar-preview preview-md"></div>
                                                                            <div class="avatar-preview preview-sm"></div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="row avatar-btns">
                                                                        <div class="col-md-9">                                                                               

                                                                        </div>
                                                                        <div class="col-md-3">
                                                                            <input class="btn btn-default" data-dismiss="modal" type="button" value="Cancel" />
                                                                            <input class="btn btn-primary btn-block avatar-save" type="submit" name="img_save" value="Done"/>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.modal -->

                                            <!-- Loading state -->
                                            <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
                                        </div>
                                        <!-- end of image cropping -->

                                    </div>
                                    <h3><%out.print(name + " " + lname);%></h3>

                                    <ul class="list-unstyled user_data">
                                        <li><i class="fa fa-map-marker user-profile-icon"></i> <%out.print(uname);%>
                                        </li>
                                    </ul>

                                    <a class="btn btn-default user_custom" onclick="window.location = 'profile_user.jsp'"><i class="fa fa-edit m-right-xs"></i> &nbsp;Edit Profile</a>
                                    <br />
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <div class="list-group">
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-file-text fa-fw"></i> Documents
                                                <span class="pull-right text-muted small"><em><span class="badge bg-blue"><%=filecount[0]%></span></em>
                                                </span>
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-book fa-fw"></i> Compressed
                                                <span class="pull-right text-muted small"><em><span class="badge bg-green"><%=filecount[1]%></span></em>
                                                </span>
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-camera fa-fw"></i> Images
                                                <span class="pull-right text-muted small"><em><span class="badge bg-purple"><%=filecount[2]%></span></em>
                                                </span>
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-video-camera fa-fw"></i> Videos
                                                <span class="pull-right text-muted small"><em><span class="badge bg-aero"><%=filecount[3]%></span></em>
                                                </span>
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-music fa-fw"></i> Music
                                                <span class="pull-right text-muted small"><em><span class="badge bg-warning"><%=filecount[4]%></span></em>
                                                </span>
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-file fa-fw"></i> Others
                                                <span class="pull-right text-muted small"><em><span class="badge bg-red"><%=(filecount[5] - (filecount[4] + filecount[3] + filecount[2] + filecount[1] + filecount[0]))%></span></em>
                                                </span>
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-trash fa-fw"></i> Recycle Bin
                                                <span class="pull-right text-muted small"><em><span class="badge bg-orange">1</span></em>
                                                </span>
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-share-alt fa-fw"></i> Shared
                                                <span class="pull-right text-muted small"><em><span class="badge bg-blue-sky">0</span></em>
                                                </span>
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-heart fa-fw"></i> Favorite
                                                <span class="pull-right text-muted small"><em><span class="badge bg-green">23</span></em>
                                                </span>
                                            </a>
                                        </div>
                                        <!-- /.list-group -->
                                        <a href="manage_account.jsp" class="btn btn-default btn-block"><i class="fa fa-lock m-right-xs"></i> &nbsp; Manage Account</a>
                                    </div>
                                    <!-- /.panel-body -->

                                </div>
                                <div class="col-md-9 col-sm-9 col-xs-12">


                                    <!-- Main Page Header Starts-->
                                    <div class="mail-toolbar clearfix">                                        
                                        <h2><i class="fa fa-lock"></i> Manage Account<small><%=uname%></small>
                                            <ul class="nav navbar-right panel_toolbox">

                                                <li><small>User Since : <%=created%></small></li></h2>
                                        </ul>
                                        <div class="clearfix"></div>                                       
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <div class="x_panel">
                                                <div class="x_title">
                                                    <h4><i class="fa fa-list-alt"></i> General Informations</h4>
                                                    <!--                                                    <ul class="nav navbar-right panel_toolbox">
                                                    
                                                                                                            <li><label class="btn btn-primary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default" onclick="bringFront()">
                                                                                                                    <i class="fa fa-wrench"></i> Edit Profile
                                                                                                                </label></li>
                                                                                                        </ul>-->
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="x_content">
                                                    <br />
                                                    <div class="col-md-6 col-sm-4 col-xs-12">
                                                        <div class="x_panel tile overflow_hidden">
                                                            <div class="x_title">
                                                                <h5>File Count</h5>
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <div class="x_content">

                                                                <table class="" style="width:100%">
                                                                    <tr>
                                                                        <th style="width:37%;">

                                                                        </th>
                                                                        <th>
                                                                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                                                        <p class="">Type</p>
                                                                    </div>
                                                                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                                                                        <p class="">Count</p>
                                                                    </div>
                                                                    </th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <canvas id="canvas1" height="180" width="180" style="margin: 15px 10px 10px 0"></canvas>
                                                                        </td>
                                                                        <td>
                                                                            <table class="tile_info">
                                                                                <tr>
                                                                                    <td>
                                                                                        <p><i class="fa fa-square blue"></i>Documents </p>
                                                                                    </td>
                                                                                    <td><% double dvaldoc = filecount[0];
                                                                                        double doc = dvaldoc * 100 / filecount[5];
                                                                                        out.print(String.format("%.2f", doc)); %>%</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p><i class="fa fa-square green"></i>Compressed </p>
                                                                                    </td>
                                                                                    <td><% double dvalcom = filecount[1];
                                                                                        double comp = (dvalcom * 100) / filecount[5];
                                                                                        out.print(String.format("%.2f", comp));%>%</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p><i class="fa fa-square purple"></i>Images </p>
                                                                                    </td>
                                                                                    <td><% double dvalimg = filecount[2];
                                                                                        double img = (dvalimg * 100) / filecount[5];
                                                                                        out.print(String.format("%.2f", img));%>%</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p><i class="fa fa-square aero"></i>Videos </p>
                                                                                    </td>
                                                                                    <td><%double dvalvid = filecount[3];
                                                                                        double vid = (dvalvid * 100) / filecount[5];
                                                                                        out.print(String.format("%.2f", vid));%>%</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p><i class="fa fa-square dark_gray"></i>Music </p>
                                                                                    </td>
                                                                                    <td><%double dvalmus = filecount[4];
                                                                                        double mus = (dvalmus * 100) / filecount[5];
                                                                                        out.print(String.format("%.2f", mus));%>%</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <p><i class="fa fa-square custom_red"></i>Others </p>
                                                                                    </td>
                                                                                    <td><%double dvaloth = filecount[5];
                                                                                        double other = ((dvaloth - dvalmus - dvalvid - dvalimg - dvalcom - dvaldoc) * 100) / filecount[5];
                                                                                        out.print(String.format("%.2f", other));%>%</td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6 col-sm-4 col-xs-12">
                                                        <div class="x_panel tile fixed_height_310">
                                                            <div class="x_title">
                                                                <h5>Size Used</h5>
                                                                <!--                                                                <ul class="nav navbar-right panel_toolbox">
                                                                                                                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                                                                                                    </li>
                                                                                                                                    <li class="dropdown">
                                                                                                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                                                                                                        <ul class="dropdown-menu" role="menu">
                                                                                                                                            <li><a href="#">Settings 1</a>
                                                                                                                                            </li>
                                                                                                                                            <li><a href="#">Settings 2</a>
                                                                                                                                            </li>
                                                                                                                                        </ul>
                                                                                                                                    </li>
                                                                                                                                    <li><a class="close-link"><i class="fa fa-close"></i></a>
                                                                                                                                    </li>
                                                                                                                                </ul>-->
                                                                <div class="clearfix"></div>
                                                            </div>
                                                            <div class="x_content">
                                                                <div class="dashboard-widget-content">
                                                                    <ul class="quick-list height_adjust">
                                                                        <li><p class="no_margin_bottom"><i class="fa fa-square green font_size_17"></i><a href="#">File  </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=(dsize[1] / 1024) / 1024%>MB</p>
                                                                        </li>
                                                                        <li><p class="no_margin_bottom"><i class="fa fa-square green font_size_17"></i><a href="#">Media  </a>&nbsp;<%=": "+ (dsize[2] / 1024) / 1024%>MB</p>
                                                                        </li>
                                                                        <li><p class="no_margin_bottom"><i class="fa fa-square green font_size_17"></i><a href="#">Others  </a>&nbsp;<% long num = Math.abs(((dsize[0] / 1024) / 1024) - (((dsize[1] / 1024) / 1024) + ((dsize[2] / 1024) / 1024)));
                                                                            out.print(": " + num);%>MB</p>
                                                                        </li>
                                                                    </ul>

                                                                    <div class="sidebar-widget">
                                                                        <h4>Total Size Used</h4>
                                                                        <canvas width="150" height="80" id="foo" class="" style="width: 220px; height: 130px;"></canvas>
                                                                        <div class="goal-wrapper">

                                                                            <span id="gauge-text" class="gauge-value pull-left"><%=(dsize[0] / 1024) / 1024%></span>
                                                                            <span class="gauge-value pull-left">MB</span>
                                                                            <span id="goal-text" class="goal-value pull-right">Unlimited</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <div class="x_panel">
                                                <div class="x_title">
                                                    <h4><i class="fa fa-key"></i> Change Password</h4>
                                                    <!--                                                    <ul class="nav navbar-right panel_toolbox">
                                                    
                                                                                                            <li><label class="btn btn-primary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default" onclick="bringFront()">
                                                                                                                    <i class="fa fa-wrench"></i> Edit Profile
                                                                                                                </label></li>
                                                                                                        </ul>-->
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="x_content">
                                                    <br />
                                                    <form id="demo-form2" name="profileform" data-parsley-validate class="form-horizontal form-label-left" method="POST" action="Password_Update">

                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Password <span class="required">*</span>
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">

                                                                <!--<label style="font-size: 17px;font-weight: normal;margin-top: 3px;"></label>-->
                                                                <input type="password" id="pass" name="pass" required="required" class="form-control col-md-7 col-xs-12">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Repeat Password <span class="required">*</span>
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                <input type="password" id="repeat_pass" name="repeat_pass" class="form-control col-md-7 col-xs-12">
                                                            </div>
                                                        </div>
                                                        <div class="ln_solid"></div>
                                                        <div class="form-group">
                                                            <div class="col-md-3 col-sm-6 col-xs-12 col-md-offset-9">
                                                                <button type="reset" class="btn btn-default">Cancel</button>
                                                                <button type="submit" class="btn btn-primary" >Change</button>
                                                            </div>
                                                        </div>

                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <div class="x_panel">
                                                <div class="x_title">
                                                    <h4><i class="fa fa-trash"></i> Delete Account</h4>
                                                    <!--                                                    <ul class="nav navbar-right panel_toolbox">
                                                    
                                                                                                            <li><label class="btn btn-primary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default" onclick="bringFront()">
                                                                                                                    <i class="fa fa-wrench"></i> Edit Profile
                                                                                                                </label></li>
                                                                                                        </ul>-->
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="x_content">
                                                    <br />
                                                    <div id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">

                                                        <div class="form-group">
                                                            <p style="font-size: 15px"><span style="font-weight: 600">NOTICE :</span> Once you delete your Account , you will not be able to access the account in future.On deletion all your files in the iCloud Account will be deleted including the Shared Files</p>
                                                        </div>
                                                        <div class="form-group">
                                                            <p style="font-size: 15px">We recommend you backup your valuable Data before Deleting this Account.</p>
                                                        </div>
                                                        <div class="ln_solid"></div>
                                                        <div class="form-group">
                                                            <div class="col-md-1 col-sm-6 col-xs-12 col-md-offset-10">
                                                                <button type="button" class="btn btn-danger" onclick="confirm_delete()" ><i class="fa fa-trash"></i> Delete</button>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>                    
                                <!--content ends-->

                            </div>
                        </div>
                    </div>
                </div>
                <!--Pop up for Folder Delete Starts-->
                <div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="AccountDelete">
                    <div class="modal-dialog modal-sm">
                        <form action="Delete_Account" method="post">
                            <div class="modal-content delete">

                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                                    </button>
                                    <h4 class="modal-title" id="myModalLabel2"><i class="fa fa-warning fa-fw red"></i>Delete Account</h4>
                                </div>
                                <div class="modal-body">
                                    <p style="font-size: 12px">Do you really wanna Delete? The Contents inside will also be Deleted! Continue?</p>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Delete</button>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>
                <!--Pop up for Folder Delete Ends-->
                <!-- footer content -->
                <%@include file="../_pages/_footer.jsp" %>
                <!-- /footer content -->
            </div>


        </div>
        <div id="custom_notifications" class="custom-notifications dsp_none">
            <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
            </ul>
            <div class="clearfix"></div>
            <div id="notif-group" class="tabbed_notifications"></div>
        </div>
        <div id="contextMenu" class="dropdown clearfix">
            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;bottom:5px;">
                <li><a tabindex="-1" href="#"><i class="fa fa-folder fa-fw"></i> Add Folder</a>

                </li>
                <li><a tabindex="-1" href="#"><i class="fa fa-file-text fa-fw"></i> Add File</a>

                </li>
                <li><a tabindex="-1" href="#">Something else here</a>

                </li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="#">Separated link</a>

                </li>
            </ul>
        </div>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/Chart/chart.min.js" type="text/javascript"></script>
        <script src="../js/Chart/jquery.nicescroll.min.js" type="text/javascript"></script>
        <script src="../js/custom.js" type="text/javascript"></script>
        <script src="../js/icheck.min.js" type="text/javascript"></script>
        <!-- Gauge-->
        <script src="../js/gauge/gauge.min.js" type="text/javascript"></script>
        <!-- image cropping -->
        <script src="../js/cropping/cropper.min.js"></script>
        <script src="../js/cropping/main.js"></script>
        <!-- dashbord linegraph -->
        
        <script>
            function confirm_delete(){
                $('#AccountDelete').modal('show');
                
            }
            </script>
        <script>
                                                                            var doughnutData = [
                                                                                {
                                                                                    value: <%=filecount[0]%>,
                                                                                    color: "#3498DB"
                                                                                },
                                                                                {
                                                                                    value: <%=filecount[1]%>,
                                                                                    color: "#1ABB9C"
                                                                                },
                                                                                {
                                                                                    value: <%=filecount[2]%>,
                                                                                    color: "#9B59B6"
                                                                                },
                                                                                {
                                                                                    value: <%=filecount[3]%>,
                                                                                    color: "#9CC2CB"
                                                                                },
                                                                                {
                                                                                    value: <%=filecount[4]%>,
                                                                                    color: "#455C73"
                                                                                },
                                                                                {
                                                                                    value: <%=(filecount[5] - (filecount[4] + filecount[3] + filecount[2] + filecount[1] + filecount[0]))%>,
                                                                                    color: "#E34554"
                                                                                }
                                                                            ];
                                                                            var myDoughnut = new Chart(document.getElementById("canvas1").getContext("2d")).Doughnut(doughnutData);
        </script>
        <script>
            var opts = {
                lines: 12, // The number of lines to draw
                angle: 0, // The length of each line
                lineWidth: 0.4, // The line thickness
                pointer: {
                    length: 0.75, // The radius of the inner circle
                    strokeWidth: 0.042, // The rotation offset
                    color: '#455C73' // Fill color
                },
                limitMax: 'false', // If true, the pointer will not go past the end of the gauge
                colorStart: '#1ABC9C', // Colors
                colorStop: '#1ABC9C', // just experiment with them
                strokeColor: '#F0F3F3', // to see which ones work best for you
                generateGradient: true
            };
            var target = document.getElementById('foo'); // your canvas element
            var gauge = new Gauge(target).setOptions(opts); // create sexy gauge!
            gauge.maxValue = <%=((dsize[0] / 1024) / 1024) + 50%>; // set max gauge value
            gauge.animationSpeed = 32; // set animation speed (32 is default value)
            gauge.set(<%=((dsize[0] / 1024) / 1024)%>); // set actual value
            gauge.setTextField(document.getElementById("gauge-text"));
        </script>
        <!-- /dashbord linegraph -->
    </body>
</html>

