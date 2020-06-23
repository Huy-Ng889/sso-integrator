<link href="../css/app.css" rel="stylesheet" type="text/css">
<script src="../js/jquery.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
    function registerAppOnclick() {
        var spName = document.getElementById("spName").value;
        var spCallbackUrl = document.getElementById("spCallbackUrl").value;
        var spTokenExpiryTime = document.getElementById("spTokenExpiryTime").value;
        var spRefreshTokenExpiryTime = document.getElementById("spRefreshTokenExpiryTime").value;
        if (spName === '' || spCallbackUrl === '' || spTokenExpiryTime === '' || spRefreshTokenExpiryTime === '') {
            alert("Field is required!");
        } else {
            $("#add-sp-form").submit();
            return true;
        }
    }
</script>

<div id="middle" style="width: 70%">
    <h2 style="margin-left: 10px; font-family: initial">Service Providers</h2>
    <div id="workArea" style="margin-left: 30px;">
        <form id="add-sp-form" method="post" method="post"
              action="add-service-provider-finish-ajaxprocessor.jsp">
            <div>
                <table style="width: 70%">
                    <tr>
                        <td style="width:35%;font-family: initial;padding: 10px">Service Provider Name:<span
                                class="required">*</span></td>
                        <td>
                            <input style="width:100%;height: 30px" id="spName" name="spName" type="text"
                                   class="form-control"
                                   white-list-patterns="^[a-zA-Z0-9\s.+_-]*$" autofocus/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:35%;font-family: initial;padding: 10px">Description:</td>
                        <td>
                            <input style="width:100%;height: 30px" class="form-control" id="spDescription"
                                   name="spDescription" maxlength="1023" type="text"/>
                        </td>
                    </tr>

                    <tr>
                        <td style="width:35%;font-family: initial;padding: 10px">Callback Url:<span
                                class="required">*</span></td>
                        <td>
                            <input style="width:100%;height: 30px" id="spCallbackUrl" class="form-control"
                                   name="spCallbackUrl" type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:35%;font-family: initial;padding: 10px">Token Expiry Time:<span
                                class="required">*</span></td>
                        <td>
                            <input style="width:100%;height: 30px" id="spTokenExpiryTime" class="form-control"
                                   name="spTokenExpiryTime" type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:35%;font-family: initial;padding: 10px">Refresh Token Expiry Time:<span
                                class="required">*</span></td>
                        <td>
                            <input style="width:100%;height: 30px" id="spRefreshTokenExpiryTime" class="form-control"
                                   name="spRefreshTokenExpiryTime" type="text"/>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="clear:both"/>
            <!-- sectionSub Div -->
            <div class="button" style="margin-left: 10px;margin-top: 10px">
                <input type="button" value="Register" class="btn btn-default btn-sm" onclick="registerAppOnclick();"/>
                <input type="button" value="Cancel" class="btn btn-default btn-sm"
                       onclick="javascript:location.href='list-service-providers.jsp'"/>
            </div>
        </form>
    </div>
</div>