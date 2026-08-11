Verify core: Renvatek Quartz-1 (QE111RV32I1)
============================================

Verify Renvatek Quartz-1 (QE111RV32I1) using its simulated binary version.

Warning
-------
!! Run this verification repository inside an isolated sandbox. System binaries can be altered, for
example, Python.

Information
-----------
`compliance/bin/Vtop` is the Verilator-generated "simulation" of the core. It is NOT the the core
itself.

Environment
-----------
Install the Linux dependencies (replace `dnf` with your distribution's package manager):
```
sudo dnf install -y gawk xxd
```

Run
---
After cloning this repository, start the verification script using these commands:
```
cd compliance
chmod +x main.sh
./main.sh
```

Author
------
Sushant Mondal <sushant@renvatek.com>
You can alternatively reach me using <contact@sushantmondal.com> too.

License
-------
Copyright © 2026 Sushant Mondal <sushant@renvatek.com>
-
This repository is licensed under the 'GPL-3.0-only' license.
-
This program is free software: you can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version. This program is distributed in the hope that it will
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have
received a copy of the GNU General Public License along with this program. If not, see
<https://www.gnu.org/licenses/>.

Website
-------
Visit https://www.renvatek.com/ for more information.
