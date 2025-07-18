
$daysInactive = 30
$archiveOU = "OU=Archived,DC=qadashlabs,DC=com"   
$emailFrom = "it-admin@qadashlabs.com"
$emailTo = "security-team@qadashlabs.com"
$emailSubject = "Monthly User Cleanup - Archived Accounts"
$smtpServer = "smtp.qadashlabs.com"

$cutoffDate = (Get-Date).AddDays(-$daysInactive)

$usersToArchive = Get-ADUser -Filter {
    Enabled -eq $false -and whenChanged -lt $cutoffDate
} -Properties whenChanged | Sort-Object whenChanged

$movedUsers = @()


foreach ($user in $usersToArchive) {
    try {
        Move-ADObject -Identity $user.DistinguishedName -TargetPath $archiveOU
        $movedUsers += $user.SamAccountName
    } catch {
        Write-Error "Failed to move $($user.SamAccountName): $_"
    }
}


if ($movedUsers.Count -gt 0) {
    $body = "The following user accounts were archived on $(Get-Date):`n`n"
    $body += ($movedUsers -join "`n")

    Send-MailMessage -From $emailFrom -To $emailTo -Subject $emailSubject `
        -Body $body -SmtpServer $smtpServer
} else {
    Write-Host "No accounts met the criteria this month."
}
