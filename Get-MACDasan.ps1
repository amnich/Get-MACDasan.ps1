function Get-MACDasan {
    [CmdletBinding()]
    param(	
        [Parameter(Mandatory = $True)] 
        [ValidateScript({$_ -match [IPAddress]$_ })] 
        [string]$Ip,
        [ValidateNotNull()]
        [string]$Community = "public",
        [string]$Snmpwalk = "C:\usr\bin\snmpwalk.exe" #path to snmpwalk.exe	
    )	
    $cmd = "$snmpwalk -v1 -c$community -Ox $Ip 1.3.6.1.4.1.6296.101.3.13.1.1.3"
    Write-Verbose $cmd
    $snmpResults = Invoke-Expression $cmd  #execute snmpwalk command
    Write-Debug "$($snmpResults | Out-String)"
    # regex for VLAN, PORT and MAC
    $regex = '3\.13\.1\.1\.3\.(?<VLAN>\d{1,3})\.(?<Port>\d{1,3}).*= Hex-STRING: (?<MAC>.*)'
    foreach ($single in $snmpResults) {
        if ($single -match $regex) {
            New-Object PSCustomObject -Property @{
                Source = $ip
                VLAN   = $Matches.VLAN
                MAC    = $Matches.MAC.replace(' ', '')
                Port   = $Matches.Port				
            }			
        }
    }
}
