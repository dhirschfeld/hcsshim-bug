# Repro for hcsshim::ImportLayer Error 

The `build.ps1` script here should reproduce the `hcsshim::ImportLayer`
error described in https://github.com/moby/moby/issues/37821.

This image can be built with:
```
docker pull mcr.microsoft.com/windowsservercore-insider:10.0.17744.1001
.\build.ps1
```
