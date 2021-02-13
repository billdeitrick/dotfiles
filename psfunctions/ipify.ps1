function ipify {

    $ProgressPreference = "SilentlyContinue"
    ((Invoke-WebRequest -UseBasicParsing -Uri "https://api.ipify.org/?format=json").Content | ConvertFrom-Json).ip

}