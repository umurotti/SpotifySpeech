<%-- 
    Document   : redirect
    Created on : Jun 17, 2019, 8:04:04 PM
    Author     : umur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <script>
        var params = window.location.hash.substring(1);
        window.sessionStorage.spotifyReply = JSON.stringify(params);
        
        var url = window.location.protocol + "//" + window.location.host + "/" + window.location.pathname.split('/')[1] + "/newjsp.jsp?" + params;
        window.location = url;
    </script>
</html>
