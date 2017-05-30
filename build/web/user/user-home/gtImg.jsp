<%-- 
    Document   : gtImg
    Created on : Sep 14, 2015, 9:46:01 AM
    Author     : ZionZ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%String fileid=request.getParameter("fileid"); %>
        <div>
            <img src="ImageView?fileid="<%=fileid%> width=720; height=480 alt="file_image">
        </div>
    </body>
</html>
