<%-- 
    Document   : index
    Created on : Jul 29, 2015, 10:09:49 AM
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
<html lang="en">
    <head>
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
        <style>
         
        </style>
    </head>
    <body>
        <% if (request.getParameter("pfolder_id") != null && request.getParameter("action").equals("delete")) {%>
        <script>
            window.onload = function () {
                $('#myModal').modal('show');
            };
        </script>
        <%
            }
            if (request.getParameter("pfolder_id") != null && request.getParameter("action").equals("rename")) { %>
        <script>
            window.onload = function () {
                $('#Rename').modal('show');
            };
        </script>
        <%
            }
        %>


        <%
            int id = Integer.parseInt(session.getAttribute("iCloud_user_id").toString());
            DBConnect dbc = new DBConnect();
            Icloud_main im = new Icloud_main();
            ResultSet rs;
            String name = null;
            String uname = null;
            String created = null;
            String gtfid = null;
            rs = dbc.get_User_Info(id);
            while (rs.next()) {
                name = rs.getString(2);
                uname = rs.getString(3);
                created = rs.getString(6);
            }
            ResultSet rsFile = null;
            ResultSet rsFolder = dbc.getData("{call icloud_proc_get_folder(?,?)}", id, 0);
            rsFile = dbc.getFile(0, id);
            int[] filecount = dbc.file_Count(id);
            int[] othercount = dbc.other_Count(id);
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
                            <!--                            <div class="x_title">
                                                            <ol class="breadcrumb">
                                                                <li><a href="#"> <i class="fa fa-home fa-fw"></i>Home</a></li>
                                                            </ol>-->
                            <!--<h2><small>Activity report</small></h2>-->
                            <!--                                <ul class="nav navbar-right panel_toolbox">
                                                                <li><a href="#"><i class="fa fa-chevron-up"></i></a>
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
                                                                <li><a href="#"><i class="fa fa-close"></i></a>
                                                                </li>
                                                            </ul>-->
                            <!--                                <div class="clearfix"></div>
                                                        </div>-->
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
                                    <h3><%out.print(name);%></h3>

                                    <ul class="list-unstyled user_data">
                                        <li><i class="fa fa-map-marker user-profile-icon"></i> <%out.print(uname);%>
                                        </li>

                                        <!--                                            <li>
                                                                                        <i class="fa fa-briefcase user-profile-icon"></i> Software Engineer
                                                                                    </li>
                                        
                                                                                    <li class="m-top-xs">
                                                                                        <i class="fa fa-external-link user-profile-icon"></i>
                                                                                        <a href="http://www.kimlabs.com/profile/" target="_blank">www.kimlabs.com</a>
                                                                                    </li>-->
                                    </ul>

                                    <a class="btn btn-default user_custom" onclick="window.location = 'profile_user.jsp'"><i class="fa fa-edit m-right-xs"></i>&nbsp;Edit Profile</a>
                                    <br />
                                    <!-- /.panel-heading -->
                                    <div class="panel-body">
                                        <div class="list-group">
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(1)">
                                                <i class="fa fa-file-text fa-fw"></i> Documents
                                                <span class="pull-right text-muted small"><em><span class="badge bg-blue"><%=filecount[0]%></span></em>
                                                </span>
                                            </a>
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(2)">
                                                <i class="fa fa-book fa-fw"></i> Compressed
                                                <span class="pull-right text-muted small"><em><span class="badge bg-green"><%=filecount[1]%></span></em>
                                                </span>
                                            </a>
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(3)">
                                                <i class="fa fa-camera fa-fw"></i> Images
                                                <span class="pull-right text-muted small"><em><span class="badge bg-purple"><%=filecount[2]%></span></em>
                                                </span>
                                            </a>
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(4)">
                                                <i class="fa fa-video-camera fa-fw"></i> Videos
                                                <span class="pull-right text-muted small"><em><span class="badge bg-aero"><%=filecount[3]%></span></em>
                                                </span>
                                            </a>
                                            <a href="javascript:;" class="list-group-item" onclick="loadData(5)">
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
                                                <span class="pull-right text-muted small"><em><span class="badge bg-orange"><%=othercount[0]%></span></em>
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
                                        <div class="float-left">
                                            <%
                                                String url = request.getRequestURL().toString();
                                            %>
                                            <a href="<% out.print(url); %>" title=""><div class="btn btn_1 btn-default mrg5R">
                                                    <i class="fa fa-refresh"> </i>
                                                </div></a>
                                            <div class="dropdown">
                                                <a href="#" title="" class="btn btn-default" data-toggle="dropdown" aria-expanded="false">
                                                    <i class="fa fa-cog icon_8"></i>
                                                    <i class="fa fa-chevron-down icon_8"></i>
                                                    <div class="ripple-wrapper"></div></a>
                                                <ul class="dropdown-menu float-right">
                                                    <li>
                                                        <a href="#" title="">
                                                            <i class="fa fa-pencil-square-o icon_9"></i>
                                                            Edit
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="#" title="">
                                                            <i class="fa fa-calendar icon_9"></i>
                                                            Schedule
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <a href="#" title="">
                                                            <i class="fa fa-download icon_9"></i>
                                                            Download
                                                        </a>
                                                    </li>
                                                    <li class="divider"></li>
                                                    <li>
                                                        <a href="#" class="font-red" title="">
                                                            <i class="fa fa-times" icon_9=""></i>
                                                            Delete
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"> </div>
                                        </div>
                                        <div class="float-right">


                                            <!--                            <span class="text-muted m-r-sm">Showing 20 of 346 </span>-->
                                            <div class="btn-group m-r-sm mail-hidden-options" style="display: inline-block;">
                                                <div class="btn-group">   

                                                    <a class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-sm"><i class="fa fa-cloud-upload"></i> <span class=""></span></a>
                                                    <!--Model Small for Uploading File Starts -->
                                                    <form action="File_enc_on_data?fder_id=0" method="post"  enctype="multipart/form-data">
                                                        <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="fileupload">
                                                            <div class="modal-dialog modal-sm">

                                                                <div class="modal-content">

                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                                                                        </button>
                                                                        <h4 class="modal-title" id="myModalLabel2">Upload to iCloud Storage</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        Choose files to upload to your iCloud Storage.
                                                                        <div class="fileUpload btn btn-danger">
                                                                            <span>Choose File</span>
                                                                            <input type="file" class="upload" id="uploadBtn" name="upload_file" onchange="ajaxLoader()" />
                                                                            <input type="hidden" id="hval" name="hval">
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <img id="uploading" width="200" class="left" alt=""><p class="left" id="wait"></p>
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                                        <button type="submit" class="btn btn-primary">Upload File</button>
                                                                    </div>
                                                                    <script>

//                                                                        document.getElementById("uploadBtn").onchange = function () {
//                                                                            window.location = 'Encript';
//                                                                            document.getElementById("uploadFile").value = document.getElementById("uploadBtn").files[0].name;
//                                                                        };
                                                                    </script>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <!--Model Small for Uploading File Ends -->                     
                                                        <div class="modal fade bs-fileupload2-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="fileupload2">
                                                            <div class="modal-dialog modal-sm">

                                                                <div class="modal-content">

                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="window.location = 'index.jsp'"><span aria-hidden="true">×</span>
                                                                        </button>
                                                                        <h4 class="modal-title" id="myModalLabel2">Upload to iCloud Storage</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div>
                                                                            Selected File Name : <b><h5 id="filename" ></h5></b>
                                                                            <input type="hidden" id="hval" name="hval">
                                                                        </div>

                                                                        <div class="divider"></div>
                                                                        <div class="row">                                                                
                                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                                <div class="x_panel">
                                                                                    <div class="x_title">
                                                                                        <h2>Time<small>usage</small></h2>
                                                                                        <ul class="nav navbar-right panel_toolbox">
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
                                                                                        </ul>
                                                                                        <div class="clearfix"></div>
                                                                                    </div>
                                                                                    <div class="x_content">
                                                                                        <canvas id="canvas_bar" width="400" height="400"></canvas>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                                <div class="x_panel">
                                                                                    <div class="x_title">
                                                                                        <h2>Memory<small>usage</small></h2>
                                                                                        <ul class="nav navbar-right panel_toolbox">
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
                                                                                        </ul>
                                                                                        <div class="clearfix"></div>
                                                                                    </div>
                                                                                    <div class="x_content">
                                                                                        <canvas id="canvas000" width="400" height="400"></canvas>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="clearfix"></div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <div class="left">
                                                                            <div class="radio">
                                                                                <label>SELECT : 
                                                                                    <input type="radio" class="flat" checked name="iCheck" value="1"> Method I
                                                                                </label>
                                                                                <label>
                                                                                    <input type="radio" class="flat" name="iCheck" value="2"> Method II
                                                                                </label>
                                                                                <label>
                                                                                    <input type="radio" class="flat" name="iCheck" value="3"> Method III
                                                                                </label>
                                                                            </div>

                                                                        </div>
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                                        <button type="submit" class="btn btn-primary">Upload File</button>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>   
                                                    </form>





                                                    <!--                                    <ul class="dropdown-menu dropdown-menu-right" role="menu">
                                                                                            <li><a href="#">Social</a></li>
                                                                                            <li><a href="#">Forums</a></li>
                                                                                            <li><a href="#">Updates</a></li>
                                                                                            <li class="divider"></li>
                                                                                            <li><a href="#">Spam</a></li>
                                                                                            <li><a href="#">Trash</a></li>
                                                                                            <li class="divider"></li>
                                                                                            <li><a href="#">New</a></li>
                                                                                        </ul>-->
                                                </div>
                                                <div class="btn-group">
                                                    <a class="btn btn-default" data-toggle="modal" data-target=".bs-example1-modal-sm" ><i class="fa fa-folder"></i> <span class="caret"></span></a>
                                                    <div class="modal fade bs-example1-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                                                        <div class="modal-dialog modal-sm">
                                                            <form action="Create_Folder?pfolder_id=0" method="post">
                                                                <div class="modal-content">

                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                                                                        </button>
                                                                        <h4 class="modal-title" id="myModalLabel2">Create New Folder</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p>What's the Name of your Folder?</p>

                                                                        <span class="fa fa-folder form-control-feedback left" aria-hidden="true"></span>
                                                                        <input type="text" id="folder_name" name="folder_name" class="form-control has-feedback-left" placeholder="Folder Name">

                                                                        <!--                                                <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.</p>
                                                                                                                        <p>Aenean lacinia bibendum nulla sed consectetur. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Donec ullamcorper nulla non metus auctor fringilla.</p>-->
                                                                    </div>

                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                                        <button type="submit" class="btn btn-primary">Create</button>
                                                                    </div>

                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="btn-group">
                                                    <a class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-share-alt"></i> <span class="caret"></span></a>
                                                    <ul class="dropdown-menu dropdown-menu-right" role="menu">
                                                        <li><a href="#">Work</a></li>
                                                        <li><a href="#">Family</a></li>
                                                        <li><a href="#">Social</a></li>
                                                        <li class="divider"></li>
                                                        <li><a href="#">Primary</a></li>
                                                        <li><a href="#">Promotions</a></li>
                                                        <li><a href="#">Forums</a></li>
                                                    </ul>
                                                </div>
                                                <div class="btn-group btn-default" data-toggle="tooltip" data-placement="top" title="Recycle Bin">
                                                    <a class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-trash"></i> <span class="caret"></span></a>
                                                    <ul class="dropdown-menu dropdown-menu-right" role="menu">
                                                        <li><a href="#">Work</a></li>
                                                        <li><a href="#">Family</a></li>
                                                        <li><a href="#">Social</a></li>
                                                        <li class="divider"></li>
                                                        <li><a href="#">Primary</a></li>
                                                        <li><a href="#">Promotions</a></li>
                                                        <li><a href="#">Forums</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="btn-group">
                                                <a href="javascript:;" class="btn btn-default" onclick="changeView()"><i class="fa fa-th-large"></i></a>
                                                <a href="javascript:;" class="btn btn-default" onclick="changeViewList()"><i class="fa fa-th-list"></i></a>
                                            </div>


                                        </div>
                                    </div>
                                    <!--Main Page Header Ends-->
                                    <!--                                        <div class="profile_title">
                                                                                <div class="col-md-6">
                                                                                    <h2>User Activity Report</h2>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div id="reportrange" class="pull-right" style="margin-top: 5px; background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #E6E9ED">
                                                                                        <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                                                                        <span>December 30, 2014 - January 28, 2015</span> <b class="caret"></b>
                                                                                    </div>
                                                                                </div>
                                                                               
                                                                                
                                                                            </div>-->

                                    <!--                                    </div>-->
                                    <!--content Starts-->


                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="x_panel">
                                                <!--                                <div class="x_title">
                                                                                    <h2>Projects</h2>
                                                                                    <ul class="nav navbar-right panel_toolbox">
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
                                                                                    </ul>
                                                                                    <div class="clearfix"></div>
                                                                                </div>-->
                                                <div class="x_content">

                                                    <!--                                    <p>Simple table with project listing with progress and editing options</p>-->

                                                    <!-- start project list -->
                                                    <table class="table project table-hover" id="dataTable">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 1%"></th>
                                                                <th style="width: 35%">Name</th>
                                                                <th>File Count</th>
                                                                <th>Size</th>
                                                                <th style="width: 20%">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                while (rsFolder.next()) {
                                                                    String[] encriptId = im.encrypt(rsFolder.getString("icloud_folder_id"));
                                                            %>
                                                            <tr id="dataFolder">
                                                                   <td><a href="view_files.jsp?f_name=<%=rsFolder.getString("icloud_folder_name")%>&f_id=<% out.print(encriptId[0]);
                                                                       session.setAttribute(encriptId[0], encriptId[1]);%>" ><i class="fa fa-folder big custom_color_folder"></i></a></td>
                                                                <td>
                                                                   <a href="view_files.jsp?f_name=<%=rsFolder.getString("icloud_folder_name")%>&f_id=<% out.print(encriptId[0]); session.setAttribute(encriptId[0], encriptId[1]); %>"><% out.print(rsFolder.getString("icloud_folder_name")); %></a>
                                                                    <br />
                                                                    <small>created : <% out.print(im.formatDate(rsFolder.getDate("icloud_folder_created")));
                                                                        out.print(" " + im.formatTime(rsFolder.getTime("icloud_folder_created"))); %></small>     
                                                                        
                                                                </td>
                                                                <td>
                                                                    <% out.print(dbc.getFileCount(Integer.parseInt(im.decrypt(encriptId[0], encriptId[1])))); %>
                                                                </td>
                                                                <td>                                                  
                                                                    <% out.print(im.formatFileSize(dbc.getFolderSize(Integer.parseInt(im.decrypt(encriptId[0], encriptId[1])))));%>
                                                                </td>
                                                                <td>
                                                                    <!--                                                                    <a href="#" class="btn btn-primary btn-xs"><i class="fa fa-folder"></i> View </a>
                                                                                                                                        <a href="#" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Rename </a>
                                                                                                                                        <a href="#" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> Delete </a>-->

                                                                    <div class="btn-group">
                                                                            <button type="button" class="btn btn-default custom" onclick="window.location = 'view_files.jsp?f_name=<%=rsFolder.getString("icloud_folder_name")%>&f_id=<% out.print(encriptId[0]);
                                                                                session.setAttribute(encriptId[0], encriptId[1]);%>'">Open</button>
                                                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                                            <span class="caret"></span>
                                                                            <span class="sr-only">Toggle Dropdown</span>
                                                                        </button>
                                                                        <ul class="dropdown-menu animated fadeInDown pull-right" role="menu">                                                           
                                                                            <li class="space-top"><a href="#"><i class="fa fa-cloud-download fa-fw"></i>Download</a>
                                                                            </li>
                                                                            <li><a href="#"><i class="fa fa-share-alt fa-fw"></i>Share</a>
                                                                            </li>
                                                                            <li><a href="<%=request.getRequestURL()%>?action=delete&pfolder_id=<%=im.singleKeyEncrypt(rsFolder.getString("icloud_folder_id"), getServletContext().getInitParameter("staticValueKey"))%>"><i class="fa fa-trash fa-fw"></i>Delete</a>
                                                                            </li>
                                                                            <li><a href="<%=request.getRequestURL()%>?action=rename&pfolder_id=<%=im.singleKeyEncrypt(rsFolder.getString("icloud_folder_id"), getServletContext().getInitParameter("staticValueKey"))%>"><i class="fa fa-pencil fa-fw"></i>Rename</a>
                                                                            </li>
                                                                            <li><a href="#"><i class="fa fa-repeat fa-fw"></i>Move</a>
                                                                            </li>
                                                                            <li class="divider"></li>
                                                                            <li><a href="#">Separated link</a>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </td>
                                                            </tr>


                                                            <%
                                                                }
                                                                String fa = null;
                                                                while (rsFile.next()) {

                                                                    fa = im.setFileImage(rsFile.getString("icloud_file_type"));

                                                            %>
                                                            <tr id="dataFile">
                                                                <td><a href="#" ><i class="fa <%out.print(fa);%> big custom_color_file"></i></a></td>
                                                                <td>
                                                                    <a href="javascript:;" onclick="openFile('<%=rsFile.getString("icloud_file_type")%>', '<%=rsFile.getString("icloud_file_id")%>')"><%out.print(rsFile.getString("icloud_file_name")); %></a>
                                                                    <br />
                                                                        <small>created : <% out.print(im.formatDate(rsFile.getDate("icloud_date_upload")));
                                                                            out.print(" " + im.formatTime(rsFile.getTime("icloud_date_upload"))); %></small>
                                                                </td>                                              
                                                                <td>
                                                                    ---
                                                                </td>
                                                                <td>                                                  
                                                                    <% out.print(im.formatFileSize(rsFile.getLong("icloud_file_size")));%>
                                                                </td>

                                                                <td>
                                                                    <div class="btn-group">
                                                                        <button type="button" class="btn btn-default custom">View</button>
                                                                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                                                            <span class="caret"></span>
                                                                            <span class="sr-only">Toggle Dropdown</span>
                                                                        </button>
                                                                        <ul class="dropdown-menu animated fadeInDown pull-right" role="menu">
                                                                            <li class="space-top"><a href="File_download?pfile_id=<%=im.singleKeyEncrypt(rsFile.getString("icloud_file_id"), getServletContext().getInitParameter("staticValueKey"))%>"><i class="fa fa-cloud-download fa-fw"></i>Download</a>
                                                                            </li>
                                                                            <li><a href="#"><i class="fa fa-share-alt fa-fw"></i>Share</a>
                                                                            </li>
                                                                            <li><a href="javascript:;" onclick="getDetails('<%=im.singleKeyEncrypt(rsFile.getString("icloud_file_id"), getServletContext().getInitParameter("staticValueKey"))%>', 'delete')"><i class="fa fa-trash fa-fw"></i>Delete</a>
                                                                            </li>
                                                                            <li><a href="javascript:;" onclick="getDetails('<%=im.singleKeyEncrypt(rsFile.getString("icloud_file_id"), getServletContext().getInitParameter("staticValueKey"))%>', 'rename')"><i class="fa fa-pencil fa-fw"></i>Rename</a>
                                                                            </li>
                                                                            <li><a href="#"><i class="fa fa-repeat fa-fw"></i>Move</a>
                                                                            </li>
                                                                            <li class="divider"></li>
                                                                            <li><a href="javascript:;" onclick="getDetails('<%=im.singleKeyEncrypt(rsFile.getString("icloud_file_id"), getServletContext().getInitParameter("staticValueKey"))%>', 'properties')"><i class="fa fa-cog fa-fw"></i>Properties</a>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                                        </tbody>
                                                    </table>

                                                    <!-- end project list -->
                                                    <!--Pop up for Folder Delete Starts-->
                                                    <div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="myModal">
                                                        <div class="modal-dialog modal-sm">
                                                            <form action="Delete_Folder?pfolder_id=<%=request.getParameter("pfolder_id")%>" method="post">
                                                                <div class="modal-content delete">

                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                                                                        </button>
                                                                        <h4 class="modal-title" id="myModalLabel2">Delete Folder</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p>Do you really wanna Delete "<span style="color: #0C7E88; font-weight: 600;" ><% try {
                                                                                out.print(dbc.getFolderName(Integer.parseInt(im.singleKeydecrypt(request.getParameter("pfolder_id"), getServletContext().getInitParameter("staticValueKey")))));
                                                                            } catch (Exception e) {
                                                                                e.printStackTrace();
                                                                            }%></span>"?<br> The Contents inside will also be Deleted! Continue?</p>

                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="window.location = 'index.jsp'">Cancel</button>
                                                                        <button type="submit" class="btn btn-primary">Delete</button>
                                                                    </div>

                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <!--Pop up for Folder Delete Ends-->
                                                    <!--pop up for Folder rename Starts-->
                                                    <div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="Rename">
                                                        <div class="modal-dialog modal-sm">
                                                            <form action="Action?pfolder_id=<%=request.getParameter("pfolder_id")%>" method="post">
                                                                <div class="modal-content delete">

                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="window.location = 'index.jsp'"><span aria-hidden="true">×</span>
                                                                        </button>
                                                                        <h4 class="modal-title" id="myModalLabel2">Rename Folder</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <p>Rename "<span><% try {
                                                                                out.print(dbc.getFolderName(Integer.parseInt(im.singleKeydecrypt(request.getParameter("pfolder_id"), getServletContext().getInitParameter("staticValueKey")))));
                                                                            } catch (Exception e) {
                                                                                e.printStackTrace();
                                                                            } %></span>" To </p>
                                                                        <span class="fa fa-folder form-control-feedback left" aria-hidden="true"></span>
                                                                        <input type="text" id="r_folder_name" name="r_folder_name" class="form-control has-feedback-left" placeholder="New Folder Name">
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-default" onclick="window.location = 'index.jsp'">Cancel</button>
                                                                        <button type="submit" class="btn btn-primary">Rename</button>
                                                                    </div>

                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <!--pop up for Folder rename Ends-->
                                                    <!--pop up for file_properties Starts-->
                                                    <div class="modal fade bs-properties-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="file_properties">
                                                        <div class="modal-dialog modal-sm">

                                                            <div class="modal-content properties">

                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="window.location = 'index.jsp'"><span aria-hidden="true">×</span>
                                                                    </button>
                                                                    <h4 class="modal-title" id="myModalLabel2"><i class="fa fa-file fa-fw"></i><span id="file_name_properties"></span>Properties</h4>
                                                                    <input type="hidden" name="encFileId_properties" id="encFileId_properties">
                                                                </div>
                                                                <div class="modal-body">
                                                                    <!--                                                                    <i class="fa fa-share-alt fa-fw"></i><p></p>-->
                                                                    <div class="panel panel-default">

                                                                        <!-- /.panel-heading -->
                                                                        <div class="panel-body">
                                                                            <!-- Nav tabs -->
                                                                            <ul class="nav nav-tabs">
                                                                                <li class="active"><a href="#home" data-toggle="tab">General</a>
                                                                                </li>
                                                                                <li><a href="#profile" data-toggle="tab">Security</a>
                                                                                </li>                                               
                                                                            </ul>
                                                                            <!-- Tab panes -->
                                                                            <div class="tab-content">
                                                                                <div class="tab-pane fade in active" id="home">
                                                                                    <%
                                                                                        try {
                                                                                            ResultSet userInfo = dbc.getFileProperties(Integer.parseInt(im.singleKeydecrypt(request.getAttribute("jsdbviub893hdsnj").toString(), getServletContext().getInitParameter("staticValueKey"))));
                                                                                            while (userInfo.next()) {
                                                                                    %>
                                                                                    <h5><i class="fa <%=im.setFileImage(userInfo.getString("icloud_file_type"))%> fa-2x"></i><p><% try {
                                                                                            out.print("      " + dbc.getFileName(Integer.parseInt(im.singleKeydecrypt(request.getAttribute("jsdbviub893hdsnj").toString(), getServletContext().getInitParameter("staticValueKey")))) + " ");
                                                                                        } catch (Exception e) {
                                                                                            e.printStackTrace();
                                                                                        }%></p></h5>

                                                                                    <div class="divider"></div>
                                                                                    <p> Type of File&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp; <%=" " + userInfo.getString("icloud_file_type")%></p>
                                                                                    <p> File Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp; <%=" " + im.formatFileSize(userInfo.getLong("icloud_file_size")) + " "%>(<%=userInfo.getLong("icloud_file_size") + " "%> Bytes)</p>
                                                                                    <p> Date Uploaded &nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;<% out.print(im.formatDate(userInfo.getDate("icloud_date_upload")));
                                                                                        out.print(" " + im.formatTime(userInfo.getTime("icloud_date_upload"))); %></p>
                                                                                    <p>Created By :<%%></p>
                                                                                    <%
                                                                                            }
                                                                                        } catch (Exception ex) {
                                                                                            ex.printStackTrace();
                                                                                        }
                                                                                    %>
                                                                                </div>
                                                                                <div class="tab-pane fade" id="profile">
                                                                                    <h4>Profile Tab</h4>
                                                                                    <p>nim id est laborum.</p>
                                                                                </div>
                                                                                <div class="tab-pane fade" id="messages">
                                                                                    <h4>Messages Tab</h4>
                                                                                    <p> culpa qui officia deserunt mollit anim id est laborum.</p>
                                                                                </div>
                                                                                <div class="tab-pane fade" id="settings">
                                                                                    <h4>Settings Tab</h4>
                                                                                    <p> anim id est laborum.</p>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <!--                                                                         /.panel-body -->
                                                                    </div>
                                                                    <!-- /.panel -->
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-default" onclick="window.location = 'index.jsp'">Cancel</button>
                                                                    <button type="submit" class="btn btn-primary">&nbsp;&nbsp;OK&nbsp;&nbsp;</button>
                                                                </div>

                                                            </div>

                                                        </div>
                                                    </div>
                                                    <!--pop up for file_properties Ends-->
                                                    <!--Pop up for File Delete Starts-->
                                                    <div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="fileDelete">
                                                        <div class="modal-dialog modal-sm">
                                                            <form action="Delete_File" method="post">
                                                                <div class="modal-content delete">

                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                                                                        </button>
                                                                        <h4 class="modal-title" id="myModalLabel2">Delete File</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <input type="hidden" name="encFileId_delete" id="encFileId_delete">
                                                                        <p>Do you really wanna Delete "<span id="file_name_delete" style="color: #0C7E88; font-weight: 600;" ></span>"?</p>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="window.location = 'index.jsp'">Cancel</button>
                                                                        <button type="submit" class="btn btn-primary">Delete</button>
                                                                    </div>

                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <!--Pop up for File Delete Ends-->
                                                    <!--pop up for File rename Starts-->
                                                    <div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="filerename">
                                                        <div class="modal-dialog modal-sm">
                                                            <form action="Rename_file" method="post">
                                                                <div class="modal-content delete">

                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="window.location = 'index.jsp'"><span aria-hidden="true">×</span>
                                                                        </button>
                                                                        <h4 class="modal-title" id="myModalLabel2">Rename File</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <input type="hidden" name="encFileId_rename" id="encFileId_rename">
                                                                        <p>Rename "<span id="file_name_rename" style="color: #0C7E88; font-weight: 600;"></span>" to :</p>
                                                                        <span class="fa fa-folder form-control-feedback left" aria-hidden="true"></span>
                                                                        <input type="text" id="r_file_name" name="r_file_name" class="form-control has-feedback-left" placeholder="New File Name">
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-default" onclick="window.location = 'index.jsp'">Cancel</button>
                                                                        <button type="submit" class="btn btn-primary">Rename</button>
                                                                    </div>

                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <!--pop up for File rename Ends-->
                                                    <!--pop up for File rename Starts-->
                                                    <div class="modal fade bs-delete-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="imgView">
                                                        <div class="modal-dialog modal-sm">
                                                            <div class="modal-content view_image">
                                                                <div id="imgsh" style="background-color: transparent;">
                                                                <!--<img id="imgsh" src="images/wxp (3).jpg" width="720" height="480" >-->                                                                                                        
                                                                </div>
                                                                
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--pop up for File rename Ends-->
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
        <!-- image cropping -->
        <script src="../js/cropping/cropper.min.js"></script>
        <script src="../js/cropping/main.js"></script>
         
        <script src="../js/data_thumbnail/thumbnail_icloud.js" type="text/javascript"></script>
       
        <!--        <script>
                                                                                    $(function () {
        
                                                                                        var $contextMenu = $("#contextMenu");
                                                                                        var $rowClicked;
        
                                                                                        $("body").on("contextmenu", "table tr", function (e) {
                                                                                            $rowClicked = $(this)
        
                                                                                            var pageWidth = $(window).width();
                                                                                            var menuWidth = $contextMenu.width();
                                                                                            var leftPosition = e.pageX + menuWidth > pageWidth ? e.pageX - menuWidth : e.pageX;
        
                                                                                            $contextMenu.css({
                                                                                                display: "block",
                                                                                                left: leftPosition,
                                                                                                top: e.pageY
                                                                                            });
                                                                                            return false;
                                                                                        });
        
                                                                                        $contextMenu.on("click", "a", function () {
                                                                                            var message = "You clicked on the row '" + $rowClicked.children("*")[1].innerHTML + "'\n"
                                                                                            message += "And selected the menu item '" + $(this).text() + "'"
                                                                                            alert(message);
                                                                                            $contextMenu.hide();
                                                                                        });
        
                                                                                        $(document).click(function () {
                                                                                            $contextMenu.hide();
                                                                                        });
                                                                                    });
        
                </script>-->
        <script>
                                                                            var strarr, timep, memp;
                                                                            function ajaxLoader() {
                                                                                $("#uploading").attr('src', '../images/uploading.gif');
                                                                                document.getElementById("wait").innerHTML = "Please wait..";
                                                                                var xmlhttp;

                                                                                var formData = new FormData();
                                                                                formData.append("upload_file", document.getElementById("uploadBtn").files[0]);
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
                                                                                        var filename = document.getElementById("uploadBtn").files[0].name;
                                                                                        val = document.getElementById("hval").value = xmlhttp.responseText;
                                                                                        strarr = val.split(" ");
                                                                                        timep = strarr[0].split(",");
                                                                                        memp = strarr[1].split(",");
                                                                                        //window.location = "index.jsp?enc_performance=" + val;
                                                                                        $('#fileupload').modal('hide');
                                                                                        $('#fileupload2').modal('show');
                                                                                        var randomScalingFactor = function () {
                                                                                            return Math.round(Math.random() * 100);
                                                                                        };
                                                                                        var barChartData = {
                                                                                            labels: ["Method I", "Method II", "Method III"],
                                                                                            datasets: [
                                                                                                {
                                                                                                    fillColor: "#26B99A", //rgba(220,220,220,0.5)
                                                                                                    strokeColor: "#26B99A", //rgba(220,220,220,0.8)
                                                                                                    highlightFill: "#36CAAB", //rgba(220,220,220,0.75)
                                                                                                    highlightStroke: "#36CAAB", //rgba(220,220,220,1)
                                                                                                    data: [timep[0], timep[1], timep[2]]
                                                                                                }
                                                                                            ]
                                                                                        };
                                                                                        $('#fileupload2').on('shown.bs.modal', function () {
                                                                                            new Chart($("#canvas_bar").get(0).getContext("2d")).Bar(barChartData, {
                                                                                                tooltipFillColor: "rgba(51, 51, 51, 0.55)",
                                                                                                responsive: true,
                                                                                                barDatasetSpacing: 6,
                                                                                                barValueSpacing: 5
                                                                                            });
                                                                                            document.getElementById("filename").innerHTML = filename;
                                                                                        });
                                                                                        var lineChartData = {
                                                                                            labels: ["Method I", "Method II", "Method III"],
                                                                                            datasets: [
                                                                                                {
                                                                                                    label: "My First dataset",
                                                                                                    fillColor: "rgba(38, 185, 154, 0.31)", //rgba(220,220,220,0.2)
                                                                                                    strokeColor: "rgba(38, 185, 154, 0.7)", //rgba(220,220,220,1)
                                                                                                    pointColor: "rgba(38, 185, 154, 0.7)", //rgba(220,220,220,1)
                                                                                                    pointStrokeColor: "#fff",
                                                                                                    pointHighlightFill: "#fff",
                                                                                                    pointHighlightStroke: "rgba(220,220,220,1)",
                                                                                                    data: [memp[0], memp[1], memp[2]]
                                                                                                }
                                                                                            ]

                                                                                        };
                                                                                        $('#fileupload2').on('shown.bs.modal', function () {
                                                                                            new Chart(document.getElementById("canvas000").getContext("2d")).Line(lineChartData, {
                                                                                                responsive: true,
                                                                                                tooltipFillColor: "rgba(51, 51, 51, 0.55)"
                                                                                            });
                                                                                        });


                                                                                    }
                                                                                }
                                                                                xmlhttp.open("POST", "File_enc_on_data", true);
                                                                                xmlhttp.send(formData);
                                                                            }

        </script>
        <script>
            function getDetails(fileid, action) {
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
                        var output = xmlhttp.responseText;
                        if (action == 'delete') {
                            document.getElementById("file_name_delete").innerHTML = output;
                            document.getElementById("encFileId_delete").value = fileid;
                            $('#fileDelete').modal('show');
                        }
                        if (action == 'rename') {
                            document.getElementById("file_name_rename").innerHTML = output;
                            document.getElementById("encFileId_rename").value = fileid;
                            $('#filerename').modal('show');
                        }
                        if (action == 'properties') {
                            document.getElementById("file_name_properties").innerHTML = output;
                            document.getElementById("encFileId_properties").value = fileid;
                            $('#file_properties').modal('show');
                        }
                    }
                }
                xmlhttp.open("POST", "PopupInfo?fileid=" + fileid + "&action=" + action);
                xmlhttp.send();
            }
        </script>
        <script>
            function openFile(fileType, fileId) {
                var type = fileType.split('/');
                if (type[0] == 'image') {

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
                            document.getElementById("imgsh").innerHTML = xmlhttp.responseText;
                            $('#imgView').modal('show');
                        }
                    }
                    xmlhttp.open("POST", "gtImg.jsp?fileid=" + fileId);
                    xmlhttp.send();
                }
            }
        </script>
    </body>

</html>