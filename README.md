# PSGetISPv4
Purpose: Get the ISP for any IPv4 address

Execution is simple.  You run the script such as:
powershell -ep bypass .\GetISP.ps1 8.8.8.8

and it returns:
Country Block:  8.8.0.0/14
Continent:  North America
Country:  United States
Provider Block:  8.8.0.0/22
ASN:  3356
ISP:  Level 3 Parent LLC

Please keep in mind my ISP data may be outdated.  I will try to update as soon as possible.

Many thanks to @omniomi for his IPInRange.ps1 script (https://github.com/omniomi/PSMailTools/blob/v0.2.0/src/Private/spf/IPInRange.ps1) as it really helped speed up my work. Ultimately my goal was to use this on my Megaphat website however after realizing that I will need to perform some surgery on my hosting server running w2k3, it wasn't worth the headache so I simply upped it to GH without a second thought.

Just a side note, given the 25MB limit on GH, I had to RAR the data file.  Be sure to unrar it into the same folder before execution.
