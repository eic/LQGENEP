# LQGENEP

This repository builds a LQGENEP container image from a Dockerfile, which can then be run with singularity.

**NEW**: LQGENEP now supports both 32-bit and 64-bit systems! See [README_64BIT.md](README_64BIT.md) for details.

## Quickstart

### 64-bit Build (Recommended for Modern Systems)
```bash
# Build directly with Make
make 64bit
./LQguser

# Or build Docker image
docker build -f Dockerfile.64bit --tag ghcr.io/eic/lqgenep:64bit .
docker run --rm -v $PWD:/work -w /work ghcr.io/eic/lqgenep:64bit
```

### 32-bit Build (Legacy)
To build and publish the legacy 32-bit container:
```bash
docker build --platform linux/386 --tag ghcr.io/eic/lqgenep .
docker push ghcr.io/eic/lqgenep
```

To generate events from an inputfile in the local directory:
```
singularity run docker://ghcr.io/eic/lqgenep
```

To convert the generated events into HepMC3 format with `eic-smear` (e.g. inside `eic-shell`):
```
BuildTree("LQGENEP_output.txt", "./")
TreeToHepMC("LQGENEP_output.root", "./")
```
This will write `LQGENEP_output.root` and `LQGENEP_output.hepmc`.

To add the crossing angles and beam effects, run the `afterburner` (e.g. inside `eic-shell`):
```
abconv --preset ip6_hidiv_275x18 --output AB_LQGENEP_output LQGENEP_output.hepmc
```

## Input file

The `inputfile` parameters are whitespace separate:
- line 1: number of events, leptoquark mass, leptoquark type, lepton beam energy, proton beam energy, minimum Q2, minimum x, maximum x, minimum y, maximum y, initial quark generation, final quark generation
- line 2: output file name

## Leptoquark types:

Leptoquark types are defined in the lqgenep.f data block `LQCHA`:
1. 'S_0L'
2. 'S_0R'
3. '~S_0R'
4. 'S_1L'
5. 'V_1/2L'
6. 'V_1/2R'
7. '~V_1/2L'
8. 'V_0L'
9. 'V_0R'
10. '~V_0R'
11. 'V_1L'
12. 'S_1/2L'
13. 'S_1/2R'
14. '~S_1/2L'
