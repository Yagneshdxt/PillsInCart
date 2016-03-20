using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ContactUs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        tbldetails.Visible = true;
        thankyoumsg.Visible = false;
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {

        Contact objContactus = new Contact();
        objContactus.Name = txtName.Text;
        objContactus.Address = txtAddress.Text;
        objContactus.ContactNo = txtContactNo.Text;
        objContactus.EmailID = txtEmailID.Text;
        objContactus.FeedBack = txtFeedBack.Text;
        objContactus.Sendmail_FeedBack("Customer Enquiry");
        txtName.Text = txtAddress.Text = txtContactNo.Text = txtEmailID.Text = string.Empty;
        txtFeedBack.Text = string.Empty;
        tbldetails.Visible = false;
        thankyoumsg.Visible = true;
    }
}