<%-- 
    Document   : profile_user
    Created on : Sep 3, 2015, 10:31:33 AM
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
        <title>Profile</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">

        <link href="../css/font-awesome.min.css" rel="stylesheet">
        <link href="../css/animate.min.css" rel="stylesheet">

        <!-- Custom styling plus plugins -->
        <link href="../css/custom.css" rel="stylesheet">
        <script src="../js/jquery.min.js"></script>
        <link href="../css/green.css" rel="stylesheet" type="text/css"/>
        <script>
            $(function () {
                $(".alter_two").hide();
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
            String mname = "";
            String lname = "";
            String gender = "";
            String country = "";
            String state = "";
            Date fDate = null;
            String dob = "";
            String dob1 = "";
            String phoneno = "";
            String uname = "";
            String created = "";
            String gtfid = "";
            String mCheck = "";
            String fCheck = "";
            int[] filecount = dbc.file_Count(id);
            try {
                rs = dbc.get_Profile_Info(id);
                ResultSetMetaData rm = rs.getMetaData();
                int columnCount = rm.getColumnCount();
                if (columnCount == 3) {
                    while (rs.next()) {
                        name = rs.getString(1);
                        uname = rs.getString(2);
                        created = rs.getString(3);
                    }
                } else {
                    while (rs.next()) {
                        name = rs.getString(2);
                        mname = rs.getString(3);
                        lname = rs.getString(4);
                        gender = rs.getString(5);
                        country = dbc.get_Country_Name(Integer.parseInt(country = rs.getString(6)));
                        state = dbc.get_State_Name(Integer.parseInt(state = rs.getString(7))).toLowerCase();
                        dob = im.formatDate(fDate = rs.getDate(8));
                        dob1 = rs.getString(8);
                        phoneno = rs.getString(9);
                    }
                    ResultSet rsu = dbc.get_User_Info(id);
                    while (rsu.next()) {
                        //name = rsu.getString(2);
                        uname = rsu.getString(3);
                        created = rsu.getString(6);
                    }
                    if (gender.equals("f")) {
                        gender = "Female";
                        fCheck = "<i class=\"fa fa-check fa-fw\"></i>";
                    }
                    if (gender.equals("m")) {
                        gender = "Male";
                        mCheck = "<i class=\"fa fa-check fa-fw\"></i>";
                    }
                    StringTokenizer tokenizer = new StringTokenizer(state);
                    StringBuffer sb = new StringBuffer();
                    while (tokenizer.hasMoreTokens()) {
                        String word = tokenizer.nextToken();
                        sb.append(word.substring(0, 1).toUpperCase());
                        sb.append(word.substring(1).toLowerCase());
                        sb.append(' ');
                    }
                    state = sb.toString();
                }

            } catch (Exception ex) {
                ex.printStackTrace();
            }

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

                                    </div>

                                    <div class="row">
                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                            <div class="x_panel">
                                                <div class="x_title">
                                                    <h2><i class="fa fa-users"></i> Profile<small><%=uname%></small></h2>
                                                    <ul class="nav navbar-right panel_toolbox">

                                                        <li><label class="btn btn-primary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default" onclick="bringFront()">
                                                                <i class="fa fa-wrench"></i> Edit Profile
                                                            </label></li>
                                                    </ul>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="x_content alter">
                                                    <br />
                                                    <div id="demo-form2" data-parsley-validate class="form-horizontal form-label-left">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">First Name : 
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12 algn">                                 
                                                                <span class="text_pos"><%=name%></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Last Name : 
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12 algn">    
                                                                <span class="text_pos"><%=lname%></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Middle Name / Initial : </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12 algn">    
                                                                <span class="text_pos"><p><%=mname%></p></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Gender</label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12 algn">    

                                                                <span class="text_pos"><%=gender%></span>

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Date Of Birth : 
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12 algn">    
                                                                <span class="text_pos"><%=dob%></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Country : 
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12 algn">    
                                                                <span class="text_pos"><%=country%></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">State : 
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12 algn">    
                                                                <span class="text_pos"><%=state%></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Phone : 
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12 algn">    
                                                                <span class="text_pos"><%=phoneno%></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="x_content alter_two">
                                                    <br />
                                                    <form id="demo-form2" name="profileform" data-parsley-validate class="form-horizontal form-label-left" method="POST" action="Profile_Update">

                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">First Name <span class="required">*</span>
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">

                                                                <!--<label style="font-size: 17px;font-weight: normal;margin-top: 3px;"></label>-->
                                                                <input type="text" id="first-name" name="fname" required="required" class="form-control col-md-7 col-xs-12" value="<%=name%>">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Last Name
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                <input type="text" id="last-name" name="lname" class="form-control col-md-7 col-xs-12" value="<%=lname%>">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Middle Name / Initial</label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                <input id="middle-name" class="form-control col-md-7 col-xs-12" type="text" name="mname" value="<%=mname%>">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Gender</label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                <div id="gender" class="btn-group" data-toggle="buttons">
                                                                    <%
                                                                        String male = "false";
                                                                        String female = "false";
                                                                        try {
                                                                            if (gender.equals("m")) {
                                                                                male = "true";
                                                                            }
                                                                            if (gender.equals("f")) {
                                                                                female = "true";
                                                                            }
                                                                        } catch (Exception ex) {
                                                                            ex.printStackTrace();
                                                                        }
                                                                    %>
                                                                    <label class="btn btn-default" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                                                        <input type="radio" name="gender" value="m" >&nbsp; <%=mCheck%> Male &nbsp;
                                                                    </label>
                                                                    <label class="btn btn-primary" data-toggle-class="btn-primary" data-toggle-passive-class="btn-default">
                                                                        <input type="radio" name="gender" value="f"><%=fCheck%> Female
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Date Of Birth <span class="required">*</span>
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                <input id="birthday" name="dob" class="date-picker form-control col-md-7 col-xs-12" required="required" type="date" value="<%=dob1%>">
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Country <span class="required">*</span>
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                <select class="select2_group form-control" name="country" onchange="getState(this.value)">
                                                                    <option value="">Select Country</option>
                                                                    <%
                                                                        ResultSet country_set = dbc.get_Country();
                                                                        String selected = "";
                                                                        while (country_set.next()) {
                                                                            if (country_set.getString(3).equals(country)) {
                                                                                selected = "selected";
                                                                            } else {
                                                                                selected = "";
                                                                            }
                                                                    %>
                                                                    <option value="<%=country_set.getString(1)%>" <%=selected%>><%=country_set.getString(3)%></option>

                                                                    <% }%>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">State <span class="required">*</span>
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                <select class="select2_group form-control" name="state" id="state_list">
                                                                    <option value="">Select State</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Phone
                                                            </label>
                                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                                <input id="birthday" name="phone" class="date-picker form-control col-md-7 col-xs-12" type="text" value="<%=phoneno%>">
                                                            </div>
                                                        </div>
                                                        <div class="ln_solid"></div>
                                                        <div class="form-group">
                                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                                                <button type="reset" class="btn btn-primary" onclick="window.location=window.location.href">Cancel</button>
                                                                <button type="submit" class="btn btn-success" >Update</button>
                                                            </div>
                                                        </div>

                                                    </form>
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
        <script>
                                                                    function getState(val) {
                                                                        var xmlhttp;
                                                                        var txt, x, xx, i, id;
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
                                                                                document.getElementById("state_list").innerHTML = xmlhttp.responseText;
                                                                            }
                                                                        }
                                                                        xmlhttp.open("POST", "GetState?country_id=" + val, true);
                                                                        xmlhttp.send();
                                                                    }
                                                                    function bringFront() {
                                                                        $(".alter").toggle();
                                                                        $(".alter_two").toggle();
                                                                    }
        </script>
    </body>
</html>
