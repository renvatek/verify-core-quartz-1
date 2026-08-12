Verify core: Renvatek Quartz-1 (QE001001RV32IN0)
================================================

Verify Renvatek Quartz-1 (QE001001RV32IN0) using its simulated binary version.

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

Uninstall
---------

To remove every trace, execute this:
```

# Replace `<repository-parent>` with the directory inside which you have cloned this repository.
cd <repository-parent>

# Replace `<repository>` with the name you have cloned this repository as.
rm -rf <repository>

```

Internal clean up is already done by the scripts. Testing to a great extent has been done to ensure
that the automatic clean up works, but sometimes leakages happen. To be absolutely sure, check the
versions of your system's binaries which were used as dependencies and make sure the `bash` profile
of your shell is not changed.

Author
------

Sushant Mondal <sushant@renvatek.com>
You can alternatively reach me using <contact@sushantmondal.com> too.

License
-------

Copyright © 2026 Sushant Mondal <sushant@renvatek.com>

This repository is licensed under the 'GPL-3.0-only' license.

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
