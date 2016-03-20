

function validate1() {

    if (document.enquiry.name.value == "") {

        alert("Please enter your Name");

        document.enquiry.name.focus();

        return false;

    }

    if (document.enquiry.phone.value == "") {

        alert("Please enter your Phone No.");

        document.enquiry.phone.focus();

        return false;

    }

    if (isNaN(document.enquiry.phone.value)) {

        alert("Please enter Numeric Value in Phone Field");

        document.enquiry.phone.value = "";

        document.enquiry.phone.focus();

        return false;

    }

    if (document.enquiry.email.value == "") {

        alert("Please enter your Email Id");

        document.enquiry.email.focus();

        return false;

    }

    if (document.enquiry.email.value.indexOf('@') == -1 || document.enquiry.email.value.indexOf('.') == -1) {

        alert("Please enter the Email Correctly");

        document.enquiry.email.value = "";

        document.enquiry.email.focus();

        return false;

    }

    if (document.enquiry.resultVal.value == "") {

        alert("Please enter verification code");

        document.enquiry.resultVal.focus();

        return false;
    }
    if (document.enquiry.resultVal.value != document.enquiry.hdnresult.value) {

        alert("Please enter correct verification code");

        document.enquiry.resultVal.focus();

        return false;
    }
    if (document.enquiry.enquiry2.value == "") {
        alert("Please enter your Message ");
        document.enquiry.enquiry2.focus();
        return false;
    }
    //    if (document.enquiry.enquiry.value == "") {

    //        alert("Please enter your Comments");

    //        document.enquiry.enquiry.focus();

    //        return false;

    //    }
    //    if (document.enquiry.selCountry.value == "") {

    //        alert("Please enter your Country");

    //        document.enquiry.selCountry.focus();

    //        return false;

    //    }


    return true;

}
