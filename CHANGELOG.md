# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v0.1.0] - 2026-08-27

### Added

- External verification repository for the Renvatek Quartz-1 (`QE001001RV32IN0`): a self-contained
  package to run the ACT4 compliance suite against a prebuilt, ship-safe `Vtop` binary without
  needing the full RTL source.
- Automated dependency handling in `main.sh` for `dnf`- and `zypper`-based distros, including
  `sudo`-skip logic when dependencies are already present.
- Documented, verified install/uninstall instructions with a confirmed Environment table
  (AlmaLinux 9.8, Fedora Linux 44, openSUSE Leap 16.0).

### Fixed

- Corrected uninstall path in [README](README) that pointed to the wrong directory.
- Bundled missing `.so` runtime dependencies alongside `Vtop`, and added a Renvatek watermark to the
  shipped binary.

### Changed

- Renamed core designator from `QE111RV32I1` to the formal `QE001001RV32IN0` product name.
