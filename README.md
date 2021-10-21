# bidrag-docker
Github Actions for docker spesialisert for team bidrag

### Continuous integration
![](https://github.com/navikt/bidrag-docker/workflows/build%20actions/badge.svg)

### Hovedregel for design:
Alt blir utført av bash-scripter slik at det enkelt kan testes på reell kodebase uten å måtte bygge med
github.

### Changelog

Versjon   | Endringstype | Beskrivelse
----------|--------------|------------
v2.0.5    | Endret       | `build` & `exists`: upgrade @actions/core from 1.5.0 to 1.6.0
v2.0.3..4 | Endret       | `build` & `exists`: snyk updates
v2.0.2    | Endret       | `build`: bruker `podman` eller `docker`
v2.0.2    | Endret       | `exists`: bruker HTTP/1.1 eller HTTP/2
v2.0.1    | Endret       | `build`: fra `docker` til `sudo podman`
v2.0.0    | Endret       | `local-exists`: fra `docker` til `sudo podman`
v1.2.1    | Endret       | `exists`: sjekker at protokoll er HTTP/2 ikke HTTP/1.1
v1.2.0    | Opprettet    | `local-exists`: sjekker om docker image finnes lokalt
v1.1.2    | Endret       | `exists`: hvis ikke 404, så anta at image ikke finnes hvis det 401
v1.1.1    | Endret       | `exists`: image navn som argument til script
v1.1.0    | Opprettet    | `exists`: sjekker om docker image allerede er lastet opp til github
v1.0.0    | Opprettet    | `build`: bygger et docker image 

v.1.2.2 is erronous and v1 tag is moved to v1.2.1
