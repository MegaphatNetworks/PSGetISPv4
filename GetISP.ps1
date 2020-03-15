<#
by Gabriel Polmar (gpolmar@megaphat.net), Megaphat Networks (https://www.megaphat.net)

Purpose:
	To find the IPv4 Address block owner of a specific IP address.

Remarks:
	I just threw this together hoping I could incorporate it into my company site but after realizing the hell of getting PS
	to work on W2k3 Server, I figured I would just make this a desktop app to use with a commmand line.
#>
function CheckIP {
    [cmdletbinding()]
    [outputtype([System.Boolean])]
    param(
        [parameter(Mandatory,Position=0)]
        [validatescript({([System.Net.IPAddress]$_).AddressFamily -eq 'InterNetwork'})]
        [string]$IPAddress,[parameter(Mandatory,Position=1)]
        [validatescript({
			$IP   = ($_ -split '/')[0]
            $Bits = ($_ -split '/')[1]
			(([System.Net.IPAddress]($IP)).AddressFamily -eq 'InterNetwork')
        })]
        [alias('CIDR')][string]$Range
    )

    [String]$CIDRAddress = $Range.Split('/')[0]
    [int]$CIDRBits       = $Range.Split('/')[1]
    [int]$BaseAddress    = [System.BitConverter]::ToInt32((([System.Net.IPAddress]::Parse($CIDRAddress)).GetAddressBytes()), 0)
    [int]$Address        = [System.BitConverter]::ToInt32(([System.Net.IPAddress]::Parse($IPAddress).GetAddressBytes()), 0)
    [int]$Mask           = [System.Net.IPAddress]::HostToNetworkOrder(-1 -shl ( 32 - $CIDRBits))
    if (($BaseAddress -band $Mask) -eq ($Address -band $Mask)) {$true}
}

$FindIP = $args[0]
$Path = (Split-Path $script:MyInvocation.MyCommand.Path) + "\" + "All-GeoIP-v4-Blocks.csv"
if ($FindIP.length -ne 0) {
	$fip = $FindIP.Split(".")
	foreach ($ipLine in [System.IO.File]::ReadLines($Path)) {
		$IPBlock = $ipLine.Split(",")
		$ipb = $IPBlock[0].Split(".")
		If ($fip[0] -eq $ipb[0]) {
			if (CheckIP $FindIP $IPBlock[0]) {
				Write-Host "Country Block: " $IPBlock[0] -NoNewLine;write ""
				Write-Host "Continent: " $IPBlock[3] -NoNewLine;write ""
				Write-Host "Country: " $IPBlock[5] -NoNewLine;write ""
				Write-Host "Provider Block: " $IPBlock[11] -NoNewLine;write ""
				Write-Host "ASN: " $IPBlock[12] -NoNewLine;write ""
				Write-Host "ISP: " $IPBlock[13] -NoNewLine;write ""
				Break
			}
		}
	}
}
