#!/bin/bash


pushd ${1?Specify directory with \'inputfile\' as first argument}
file=$(basename $(tail -n1 inputfile) .txt)
singularity run docker://ghcr.io/eic/lqgenep
cat << EOF | eic-shell
eic-smear -l -q -e \' BuildTree("${file}.txt", "./") ; TreeToHepMC("${file}.root", "./") \'
abconv --preset ip6_hidiv_275x18 --output ${file}_AB ${file}.hepmc
EOF
popd
