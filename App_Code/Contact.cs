using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Net.Configuration;
using System.Web.Configuration;
using System.Configuration;

/// <summary>
/// Summary description for Contact
/// </summary>
public class Contact
{
    public string Name { get; set; }
    public string Address { get; set; }
    public string ContactNo { get; set; }
    public string EmailID { get; set; }
    public string FeedBack { get; set; }

    public void Sendmail_FeedBack(string subject)
    {

        SmtpClient obj = new SmtpClient();
        string host = "";
        try
        {
            obj.EnableSsl = true;
            MailMessage mailSendMails = new MailMessage();
            mailSendMails.To.Add(ConfigurationManager.AppSettings["MailFromCredentials"].Split('|')[0]);
            mailSendMails.From = new MailAddress(EmailID);
            mailSendMails.Subject = subject;
            string message = "Name : " + Name + System.Environment.NewLine;
            message += "Address : " + Address + System.Environment.NewLine;
            message += "Contact No. : " + ContactNo + System.Environment.NewLine;
            message += "Email ID : " + EmailID + System.Environment.NewLine;
            message += "Feedback : " + FeedBack;

            mailSendMails.IsBodyHtml = true;
            mailSendMails.Body = message;
            System.Configuration.Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.config") as System.Configuration.Configuration;
            //Configuration configurationFile = WebConfigurationManager.OpenWebConfiguration("~/Web.config");

            MailSettingsSectionGroup mailSettings = config.GetSectionGroup("system.net/mailSettings") as MailSettingsSectionGroup;
            if (mailSettings != null)
            {
                host = mailSettings.Smtp.Network.Host;

            }
            obj.Send(mailSendMails);
        }
        catch (Exception ex)
        {
            //Exception_Log.ExceptionMethod("Registration", "Registration", "Sendmail_UserRegistration", ex);
        }

    }
}