function mx {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]
        $Domain
    )

    Resolve-DnsName -Name $Domain -Type mx
}