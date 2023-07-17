# CVE-2021-21311

## Description
SSRF(Server-side Request Forgery) in Adminer  
(Open Source Database Management tool)  
from v4.0.0 ~ v4.7.8 (patched at v4.7.9)

[Patch commit](https://github.com/vrana/adminer/commit/ccd2374b0b12bd547417bf0dacdf153826c83351)

## Usage
```
exploit.py [-h] -target TARGET -redirect REDIRECT -host HOST [-port PORT]

options:
  -h, --help          show this help message and exit
  -target TARGET      url of target
  -redirect REDIRECT  url for redirect path
  -host HOST          host ip to listen
  -port PORT          listening server port
```
![exploit_demo](./mdImg/exploit_demo.png)  

## Disclaimer
All content provied by this repository is meant for research, educational, and threat detection purpose only.  
Please use wisely.