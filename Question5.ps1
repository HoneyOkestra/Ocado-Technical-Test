Import-Csv "users.csv" | Where-Object { $_.Department -eq "IT" } | Sort-Object UserName | Select-Object UserName, Email
