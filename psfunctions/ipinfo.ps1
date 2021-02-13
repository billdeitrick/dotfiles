function ipinfo {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $IP
    )

    $ProgressPreference = "SilentlyContinue"

    $response = Invoke-WebRequest -UseBasicParsing -Uri "https://ipinfo.io/$IP/geo"

    $responseData = $response.Content | ConvertFrom-Json
    $responseData = $responseData | Select-Object -Property * -ExcludeProperty readme

    $reverseDns = (Resolve-DnsName -Name $IP -Type PTR -ErrorAction SilentlyContinue).NameHost

    $responseData | Add-Member -MemberType NoteProperty -Name ptr -Value $reverseDns

    $responseData

}