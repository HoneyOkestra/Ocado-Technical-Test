$response = Invoke-RestMethod -Uri "https://api.example.com/users" -Method Get
foreach ($user in $response.users) {
    Write-Output "Name: $($user.name), Role: $($user.role)"
}
