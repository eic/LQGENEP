# LQGENEP

This repository builds a LQGENEP container image from a Dockefile, which can then be run with singularity.

## Quickstart

To build and publish the container:
```
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


-----------------------------------------------------------------------------------------------------------------------------

LQguser.f:

Main program that calls LQGENEP and sets many important parameters including:

Output file name with event list
Leptoquark type
Output lepton flavor
Initial and final state coupling
x and Q2 ranges


-----------------------------------------------------------------------------------------------------------------------------

To run program change inputfile paramaters. Then compile which creates executable LQguser object file. Run LQguser to create outputfile with leptoquark events.
To produce output do the following in the terminal:

compile
LQguser

This output is default set to LQGENEP_output.txt

-----------------------------------------------------------------------------------------------------------------------------

At this point the Distill_pi.C file may be run in order to select only LQ event where the tau decays into three pions. This will output a new root file that is exclusively three pion decay taus.

-----------------------------------------------------------------------------------------------------------------------------

To read Pythia text output into a root tree format use Build_Tree.C with the proper input file and number of events.
