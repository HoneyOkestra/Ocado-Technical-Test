
                
$daysInactive = 90
$cutoffDate = (Get-Date).AddDays(-$daysInactive)

$staleUsers = Get-ADUser -Filter * -Properties DisplayName, PasswordLastSet |
    Where-Object { $_.PasswordLastSet -lt $cutoffDate } |
    Select-Object Name, SamAccountName, PasswordLastSet
$reportPath = "C:\Reports\StaleUserPasswords.csv"
$staleUsers | Export-Csv -Path $reportPath -NoTypeInformation


#Describe how you would enhance it to automatically email a weekly report to the IT admin.
SendMailMessge cmdlet
(obsolete)
$sendMailMessageSplat = @{
    From = 'User01 <user01@fabrikam.com>'
    To = 'User02 <user02@fabrikam.com>', 'User03 <user03@fabrikam.com>'
    Subject = 'Sending the Attachment'
    Body = "Forgot to send the attachment. Sending now."
    Attachments = '.\data.csv'
    Priority = 'High'
    DeliveryNotificationOption = 'OnSuccess', 'OnFailure'
    SmtpServer = 'smtp.fabrikam.com'
}
Send-MailMessage @sendMailMessageSplat

References: 
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7.5
https://o365info.com/send-mgusermail/

