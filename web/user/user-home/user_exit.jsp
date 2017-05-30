<%-- 
    Document   : user_exit
    Created on : Jul 31, 2015, 12:40:31 PM
    Author     : ZionZ
--%>
<%@page import="iCloud_Pack.DBConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <%   
        response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server 
        response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance 
        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale" 
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
        DBConnect dbcon=new DBConnect();
        dbcon.setActive((Integer)session.getAttribute("iCloud_user_id"),1);
        session.invalidate();
        response.sendRedirect("../");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logging out..</title>
    </head>
    <body>
     

    </body>
</html>
