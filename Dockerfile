# This docker container must be built for a linux/386 platform, with:
#
#  docker build --platform linux/386 .
#
#
FROM 32bit/ubuntu:16.04

RUN apt-get update -yqq && apt-get install -yqq git cernlib-montecarlo && apt-get clean -yqq
RUN git clone https://github.com/wdconinc/LQGENEP.git /LQGENEP

WORKDIR /LQGENEP
RUN f77 -m32 -Wl,--copy-dt-needed-entries -o LQguser LQguser.f lqgenep.f extrafiles/pythia6156.f -lpdflib804 -lpacklib -lmathlib

ENTRYPOINT ["/LQGENEP/LQguser"]
