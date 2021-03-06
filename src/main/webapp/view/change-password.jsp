<link href="../css/app.css" rel="stylesheet" type="text/css">
<script src="../js/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">

</script>

<style>
    .form-conatiner {
        padding: 50px 60px;
        margin-top: 20vh;
    }
</style>

<div id="middle" style="width: 70%">
    <div class="container-fluid bg">
        <div class="row">
            <div class="col-md-7 col-sm-4 col-xs-12"></div>
            <div class="col-md-3 col-sm-4 col-xs-12">
                <form class="form-conatiner" action="/ChangePasswordServlet" method="post">
                    <%
                        if(request.getAttribute("err") != null) {
                    %>
                    <div class="form-group">
                        <label style="color: red"><%=request.getAttribute("err")%></label>
                    </div>
                    <%
                    } else if(request.getAttribute("msg") != null) {
                    %>
                    <div class="form-group">
                        <label style="color: green"><%=request.getAttribute("msg")%></label>
                    </div>
                    <%
                        }
                    %>
                    <div class="form-group">
                        <label>New Password:</label>
                        <input class="form-control" type="password" name="newPassword">
                    </div>
                    <div class="form-group">
                        <label>Confirm New Password:</label>
                        <input class="form-control" type="password" name="confirmNewPassword">
                    </div>
                    <button type="submit" class="btn btn-success">Change Password</button>
                </form>
            </div>
        </div>
    </div>
</div>