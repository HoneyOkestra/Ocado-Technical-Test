
                
$daysInactive = 90
$cutoffDate = (Get-Date).AddDays(-$daysInactive)

$staleUsers = Get-ADUser -Filter * -Properties DisplayName, PasswordLastSet |
    Where-Object { $_.PasswordLastSet -lt $cutoffDate } |
    Select-Object Name, SamAccountName, PasswordLastSet
$reportPath = "C:\Reports\StaleUserPasswords.csv"
$staleUsers | Export-Csv -Path $reportPath -NoTypeInformation


#Describe how you would enhance it to automatically email a weekly report to the IT admin.
A weekly Task scheduler can be created to run the PS script. The account that runs the task will be a service account
A Send-MailMessge cmdlet will be added to the script and below is the syntax that may be added
Send-MailMessage
    [[-Body] <String>]
    [[-SmtpServer] <String>]
    [[-Subject] <String>]
    [-To] <String[]>
    -From <String>
    [-Attachments <String[]>]
    [-Bcc <String[]>]
    [-BodyAsHtml]
    [-Encoding <Encoding>]
    [-Cc <String[]>]
    [-DeliveryNotificationOption <DeliveryNotificationOptions>]
    [-Priority <MailPriority>]
    [-ReplyTo <String[]>]
    [-Credential <PSCredential>]
    [-UseSsl]
    [-Port <Int32>]
    [<CommonParameters>]


 



