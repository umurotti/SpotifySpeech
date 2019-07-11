<%-- 
    Document   : CacheStat
    Created on : Jun 24, 2019, 11:46:15 AM
    Author     : umur
--%>

<%@page import="com.mycompany.spotifyspeech.SpotifyServices"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
    </head>
    <body style="background-color: black;">
        <h1 style="color: whitesmoke;">Cache Summary:</h1>
        <%
            String cache = SpotifyServices.cache.show();
        %>
        <h2 style="color: green; white-space: pre;"><%=cache%></h2>
    </body>
</html>
