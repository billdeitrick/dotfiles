function up {
    $result = ping -n 1 -w 200 8.8.8.8

    if ($result -like '*Reply from*') {
        Write-Host "$(U 0x2713) YES!" -ForegroundColor Green
    } else {
        Write-Host "$(U 0x2717) NO!" -ForegroundColor Red
    }
}