# Repro for hcsshim::ImportLayer Error 

The [Dockerfile](./Dockerfile) here should reproduce the `hcsshim::ImportLayer`
error described in https://github.com/moby/moby/issues/37821.

This image can be built with:
```
docker pull dhirschfeld/repro-base
docker build --no-cache --force-rm -t repro .
```
