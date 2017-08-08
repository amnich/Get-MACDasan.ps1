# Get-MACDasan
Get a list of MAC addresses with port number from a DASAN Fibre Channel switch using SNMPWALK.

```powershell
PS > Get-MACDasan -Community public -IP 10.10.10.10

Source       VLAN Port   MAC
------       ---- ------ ---
10.10.10.10  100  1      0000BBA211EB
10.10.10.10  102  1      0000BBA2BA20
10.10.10.10  100  1      0004EFB348FE
```
