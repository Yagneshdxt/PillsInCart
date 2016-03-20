$(document).ready(function () {
    $.ajax({
        type: "POST",
        url: "Ajax.aspx/generateRandomCode",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        failure: function (response) {
            alert(response.d);
        }
    });

    $(".formsubmit").click(function () {
        if (validate1()) {
            $('.formsubmit').attr("disabled", true);
            $(".loading").show();
            $.ajax({
                type: "POST",
                url: "Ajax.aspx/SendMsg",
                data: "{'EmailID': '" + document.enquiry.email.value + "','name':'" + document.enquiry.name.value + "','phone':'" + document.enquiry.phone.value + "','comments':'" + document.enquiry.enquiry2.value + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: OnSuccessMail,
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
        return false;
    });

});

function OnSuccess(response) {
    $(".verificationcode").html(response.d[0].num1.toString() + "+" + response.d[0].num2.toString() + "");
    $("#hdnresult").val(response.d[0].total);
}

function OnSuccessMail(response) {
    window.location.href = "thanks.html";
}

