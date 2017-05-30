<%-- 
    Document   : index
    Created on : Sep 14, 2015, 7:43:11 PM
    Author     : ZionZ
--%>

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
        <title>Welcome Administrator</title>
        <%
            response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server 
            response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance 
            response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale" 
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
        %>
        <title>Home</title>
        <!-- Bootstrap core CSS -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/font-awesome.min.css" rel="stylesheet">
        <link href="../css/animate.min.css" rel="stylesheet">

        <!-- Custom styling plus plugins -->
        <link href="../css/custom.css" rel="stylesheet">
        <script src="../js/jquery.min.js" type="text/javascript"></script>
        <link href="../css/green.css" rel="stylesheet" type="text/css"/>
        <link href="../css/thumbnail-iCloud.css" rel="stylesheet" type="text/css"/>
        <link href="../css/custom_1.css" rel="stylesheet" type="text/css"/>
        <link href="../css/perfect-scrollbar/perfect-scrollbar.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            int id = Integer.parseInt(session.getAttribute("iCloud_user_id").toString());
            DBConnect dbc = new DBConnect();
            Icloud_main im = new Icloud_main();
            ResultSet rs;
            String name = null;
            String uname = null;
            String created = null;
//            String gtfid = null;
            rs = dbc.get_User_Info(id);
            while (rs.next()) {
                name = rs.getString(2);
                uname = rs.getString(3);
                created = rs.getString(6);
            }
//            ResultSet rsFile = null;
//            ResultSet rsFolder = dbc.getData("{call icloud_proc_get_folder(?,?)}", id, 0);
//            rsFile = dbc.getFile(0, id);
//            int[] filecount = dbc.file_Count(id);
//            int[] othercount = dbc.other_Count(id);
            String[] dash_row_one = dbc.dashBoard_r1();
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
                                                                            <!--                                                                                <div class="btn-group">
                                                                                                                                                                <button class="btn btn-primary" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees">Rotate Left</button>
                                                                                                                                                                <button class="btn btn-primary" data-method="rotate" data-option="-15" type="button">-15deg</button>
                                                                                                                                                                <button class="btn btn-primary" data-method="rotate" data-option="-30" type="button">-30deg</button>
                                                                                                                                                                <button class="btn btn-primary" data-method="rotate" data-option="-45" type="button">-45deg</button>
                                                                                                                                                            </div>
                                                                                                                                                            <div class="btn-group">
                                                                                                                                                                <button class="btn btn-primary" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees">Rotate Right</button>
                                                                                                                                                                <button class="btn btn-primary" data-method="rotate" data-option="15" type="button">15deg</button>
                                                                                                                                                                <button class="btn btn-primary" data-method="rotate" data-option="30" type="button">30deg</button>
                                                                                                                                                                <button class="btn btn-primary" data-method="rotate" data-option="45" type="button">45deg</button>
                                                                                                                                                            </div>-->
                                                                        </div>
                                                                        <div class="col-md-3">

                                                                            <!--                                                                                <button class="btn btn-primary btn-block avatar-save" type="submit" name="img_save">Done</button>-->
                                                                            <input class="btn btn-default" data-dismiss="modal" type="button" value="Cancel" />
                                                                            <input class="btn btn-primary avatar-save" type="submit" name="img_save" value="Done"/>
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
<!--                                    <h3>Welcome <%out.print(name);%></h3>

                                    <ul class="list-unstyled user_data">
                                        <li><i class="fa fa-map-marker user-profile-icon"></i> <%out.print(uname);%>
                                        </li>

                                                                                    <li>
                                                                                        <i class="fa fa-briefcase user-profile-icon"></i> Software Engineer
                                                                                    </li>
                                        
                                                                                    <li class="m-top-xs">
                                                                                        <i class="fa fa-external-link user-profile-icon"></i>
                                                                                        <a href="http://www.kimlabs.com/profile/" target="_blank">www.kimlabs.com</a>
                                                                                    </li>
                                    </ul>-->

                                    <a class="btn btn-default user_custom" onclick="window.location = 'profile_user.jsp'"><i class="fa fa-edit m-right-xs"></i>&nbsp;Edit Profile</a>
                                    <br />
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <div class="list-group">
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(1)">
                                                <i class="fa fa-users fa-fw"></i> Manage Users
                                            </a>
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(2)">
                                                <i class="fa fa-database fa-fw"></i> Manage DataBase
                                            </a>
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(3)">
                                                <i class="fa fa-clock-o fa-fw"></i> Timeline
                                            </a>
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(4)">
                                                <i class="fa fa-calendar fa-fw"></i> Calender
                                            </a>
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(5)">
                                                <i class="fa fa-music fa-fw"></i> Manage Files                                               
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-file fa-fw"></i> Others                                                
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-trash fa-fw"></i> Recycle Bin                                              
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-share-alt fa-fw"></i> Shared                                              
                                            </a>
                                            <a href="#" class="list-group-item">
                                                <i class="fa fa-cogs fa-fw"></i> Settings                     
                                            </a>
                                        </div>
                                        <!-- /.list-group -->
                                        <a href="manage_account.jsp" class="btn btn-default btn-block"><i class="fa fa-lock m-right-xs"></i> &nbsp; Manage Account</a>
                                    </div>
                                    <!-- /.panel-body -->

                                </div>
                                <div class="col-md-9 col-sm-9 col-xs-12">
                                    <div class="col-sm-12">
                                        <div class="page-header-admin">
                                            <h1>Dashboard <small>overview &amp; stats </small></h1>
                                        </div>
                                    </div>
                                    <!-- top tiles -->
                                    <div class="row tile_count">
                                        <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                                            <div class="left"></div>
                                            <div class="right">
                                                <span class="count_top"><i class="fa fa-users"></i> Total Users</span>
                                                <div class="count"><%=dash_row_one[0]%></div>
                                                <span class="count_bottom"><i class="green">4% </i> From last Week</span>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                                            <div class="left"></div>
                                            <div class="right">
                                                <span class="count_top"><i class="fa fa-thumbs-up"></i> Active Now</span>
                                                <div class="count"><%=dash_row_one[1]%></div>
                                                <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>3% </i> From last Week</span>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                                            <div class="left"></div>
                                            <div class="right">
                                                <span class="count_top"><i class="fa fa-file-text"></i> Total Files</span>
                                                <div class="count green"><%=dash_row_one[2]%></div>
                                                <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Week</span>
                                            </div>
                                        </div>
                                        <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                                            <div class="left"></div>
                                            <div class="right">
                                                <span class="count_top"><i class="fa fa-user"></i> Total visitors</span>
                                                <div class="count">4,567</div>
                                                <span class="count_bottom"><i class="red"><i class="fa fa-sort-desc"></i>12% </i> From last Week</span>
                                            </div>
                                        </div><!--
                                        <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                                            <div class="left"></div>
                                            <div class="right">
                                                <span class="count_top"><i class="fa fa-file-text"></i> Total Files</span>
                                                <div class="count">2,315</div>
                                                <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Week</span>
                                            </div>
                                        </div>-->
                                        <div class="animated flipInY col-md-2 col-sm-4 col-xs-4 tile_stats_count">
                                            <div class="left"></div>
                                            <div class="right">
                                                <span class="count_top"><i class="fa fa-database"></i> DataBase Size(MB)</span>
                                                <div class="count"><%=dash_row_one[3]%></div>
                                                <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Week</span>
                                            </div>
                                        </div>

                                    </div>
                                    <!-- /top tiles -->
                                    <!-- start: PAGE CONTENT -->
                                    <!--                                    <div class="row">
                                                                            <div class="col-sm-4">
                                                                                <div class="animated flipInX core-box">
                                                                                    <div class="heading">
                                                                                        <i class="fa fa-user circle-icon circle-green"></i>
                                                                                        <h2>Manage Users</h2>
                                                                                    </div>
                                                                                    <div class="content">
                                                                                        Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                                                                    </div>
                                                                                    <a class="view-more" href="#">
                                                                                        View More <i class="fa fa-arrow-circle-right"></i>
                                                                                    </a>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <div class=" animated flipInX core-box">
                                                                                    <div class="heading">
                                                                                        <i class="clip-clip circle-icon circle-teal"></i>
                                                                                        <h2>Manage Orders</h2>
                                                                                    </div>
                                                                                    <div class="content">
                                                                                        Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                                                                    </div>
                                                                                    <a class="view-more" href="#">
                                                                                        View More <i class="fa fa-arrow-circle-right"></i>
                                                                                    </a>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-4">
                                                                                <div class=" animated flipInX core-box">
                                                                                    <div class="heading">
                                                                                        <i class="fa fa-database circle-icon circle-bricky"></i>
                                                                                        <h2>Manage DataBase</h2>
                                                                                    </div>
                                                                                    <div class="content">
                                                                                        Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                                                                    </div>
                                                                                    <a class="view-more" href="#">
                                                                                        View More <i class="fa fa-arrow-circle-right"></i>
                                                                                    </a>
                                                                                </div>
                                                                            </div>
                                                                        </div>-->


                                    <div class="clearfix"></div>
                                    <hr>


                                    <div class="row">


                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                     <i class="fa fa-line-chart"></i>
                                                    User Growth  <small>Months</small>
                                                    <div class="panel-tools">                                             
                                                        <select name="mm" id="mm" class="form-control" onchange="getUserStat(this.value)">
                                                            <%
                                                                ResultSet year = dbc.getYear(0);
                                                                while (year.next()) {
                                                            %>
                                                            <option value="<%=year.getString(1)%>"><%=year.getString(1)%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="x_content">
                                                    <canvas id="canvas000"></canvas>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6 col-sm-6 col-xs-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <!--                                                    <h2>File Growth <small>Months</small></h2>-->
                                                    <i class="fa fa-bar-chart"></i>
                                                    File Growth  <small>Months</small>
                                                    <div class="panel-tools">
                                                        <select name="mm" id="mm" class="form-control" onchange="getFileStat(this.value)">
                                                            <%
                                                                ResultSet year1 = dbc.getYear(1);
                                                                while (year1.next()) {
                                                            %>
                                                            <option value="<%=year1.getString(1)%>"><%=year1.getString(1)%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="x_content">
                                                    <canvas id="canvas_bar"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                                        <div class="clearfix"></div>
                                                        <hr>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <i class="fa fa-users"></i>
                                                    Users
                                                    <div class="panel-tools">
                                                        <a class="btn btn-xs btn-link panel-collapse collapses" href="#">
                                                        </a>
                                                        <a class="btn btn-xs btn-link panel-config" href="#panel-config" data-toggle="modal">
                                                            <i class="icon-wrench"></i>
                                                        </a>
                                                        <a class="btn btn-xs btn-link panel-refresh" href="#">
                                                            <i class="icon-refresh"></i>
                                                        </a>
                                                        <a class="btn btn-xs btn-link panel-close" href="#">
                                                            <i class="icon-remove"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="panel-body panel-scroll" style="height:300px">
                                                    <table class="table table-striped table-hover" id="sample-table-1">
                                                        <thead>
                                                            <tr>
                                                                <th class="center">Photo</th>
                                                                <th>Full Name</th>
                                                                <th class="hidden-xs">Email</th>
                                                                <th class="hidden-xs">Member Since</th>                                  
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                try {
                                                                    ResultSet all = dbc.getAllUser();
                                                                    while (all.next()) {
                                                            %>
                                                            <tr>
                                                                <td class="center"><img src="ImageRetrieveServlet?icloud_id=<%=all.getInt("icloud_id")%>" alt="image" width="50" height="50" onerror="this.src='../images/picture.jpg';"/></td>
                                                                <td><%=all.getString("name")%></td>
                                                                <td class="hidden-xs">
                                                                    <a href="#" rel="nofollow" target="_blank">
                                                                        <%=all.getString("email")%>
                                                                    </a></td>
                                                                <td><%=im.formatDate(all.getDate("created")) + " " + im.formatTime(all.getTime("created"))%></td>                                                               
                                                            </tr>
                                                            <%}
                                                                } catch (Exception ex) {
                                                                    ex.printStackTrace();
                                                                }
                                                            %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>




                <!-- footer content -->
                <%@include file="../_pages/_footer.jsp" %>
                <!-- /footer content -->
            </div>


        </div>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/Chart/chart.min.js" type="text/javascript"></script>
        <script src="../js/Chart/jquery.nicescroll.min.js" type="text/javascript"></script>
        <script src="../js/custom.js" type="text/javascript"></script>
        <script src="../js/icheck.min.js" type="text/javascript"></script>
        <!-- image cropping -->
        <script src="../js/cropping/cropper.min.js"></script>
        <script src="../js/cropping/main.js"></script>

        <script src="../js/data_thumbnail/thumbnail_icloud.js" type="text/javascript"></script>
        <script src="../js/perfect-scrollbar/jquery.mousewheel.js" type="text/javascript"></script>
        <script src="../js/perfect-scrollbar/perfect-scrollbar.js" type="text/javascript"></script>
        <script src="../js/perfect-scrollbar/main.js" type="text/javascript"></script>
        <script>
                                                            window.onload = function () {
                                                                var d = new Date();
                                                                var n = d.getFullYear();
                                                                $('#mm').val(n);
                                                                getUserStat(n);
                                                                getFileStat(n);
                                                            }
                                                            var randomScalingFactor = function () {
                                                                return Math.round(Math.random() * 100)
                                                            };

                                                            var strarr, strarru;
                                                            function getUserStat(year) {
                                                                var xmlhttp;
                                                                if (window.XMLHttpRequest)
                                                                {
                                                                    xmlhttp = new XMLHttpRequest();
                                                                }
                                                                else
                                                                {
                                                                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                                                }
                                                                xmlhttp.onreadystatechange = function ()
                                                                {
                                                                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                                                                    {
                                                                        var fcount = xmlhttp.responseText;
                                                                        strarru = fcount.split(",");
                                                                        var lineChartData = {
                                                                            labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                                                            datasets: [
                                                                                {
                                                                                    label: "My Second dataset",
                                                                                    fillColor: "rgba(3, 88, 106, 0.3)", //rgba(151,187,205,0.2)
                                                                                    strokeColor: "rgba(3, 88, 106, 0.70)", //rgba(151,187,205,1)
                                                                                    pointColor: "rgba(3, 88, 106, 0.70)", //rgba(151,187,205,1)
                                                                                    pointStrokeColor: "#fff",
                                                                                    pointHighlightFill: "#fff",
                                                                                    pointHighlightStroke: "rgba(151,187,205,1)",
                                                                                    data: [strarru[0], strarru[1], strarru[2], strarru[3], strarru[4], strarru[5], strarru[6], strarru[7], strarru[8], strarru[9], strarru[10], strarru[11]]
                                                                                }
                                                                            ]

                                                                        }
                                                                        $(document).ready(function () {
                                                                            new Chart(document.getElementById("canvas000").getContext("2d")).Line(lineChartData, {
                                                                                responsive: true,
                                                                                tooltipFillColor: "rgba(51, 51, 51, 0.55)"
                                                                            });
                                                                        });
                                                                    }
                                                                }
                                                                xmlhttp.open("POST", "GetUserGrowth?year=" + year, true);
                                                                xmlhttp.send();
                                                            }
                                                            function getFileStat(year) {
                                                                var xmlhttp;
                                                                if (window.XMLHttpRequest)
                                                                {
                                                                    xmlhttp = new XMLHttpRequest();
                                                                }
                                                                else
                                                                {
                                                                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                                                }
                                                                xmlhttp.onreadystatechange = function ()
                                                                {
                                                                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                                                                    {
                                                                        var fcount = xmlhttp.responseText;
                                                                        strarr = fcount.split(",");
                                                                        var randomScalingFactor = function () {
                                                                            return Math.round(Math.random() * 100)
                                                                        };
                                                                        var barChartData = {
                                                                            labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                                                            datasets: [
                                                                                {
                                                                                    fillColor: "#26B99A", //rgba(220,220,220,0.5)
                                                                                    strokeColor: "#26B99A", //rgba(220,220,220,0.8)
                                                                                    highlightFill: "#36CAAB", //rgba(220,220,220,0.75)
                                                                                    highlightStroke: "#36CAAB", //rgba(220,220,220,1)
                                                                                    data: [strarr[0], strarr[1], strarr[2], strarr[3], strarr[4], strarr[5], strarr[6], strarr[7], strarr[8], strarr[9], strarr[10], strarr[11]]
                                                                                }
                                                                            ],
                                                                        }
                                                                        $(document).ready(function () {
                                                                            new Chart($("#canvas_bar").get(0).getContext("2d")).Bar(barChartData, {
                                                                                tooltipFillColor: "rgba(51, 51, 51, 0.55)",
                                                                                responsive: true,
                                                                                barDatasetSpacing: 6,
                                                                                barValueSpacing: 5
                                                                            });
                                                                        });
                                                                    }
                                                                }
                                                                xmlhttp.open("POST", "GetFileGrowth?year=" + year, true);
                                                                xmlhttp.send();
                                                            }
        </script>

        <script>
            jQuery(document).ready(function () {
                Main.init();
            });
        </script>

    </body>
</html>
