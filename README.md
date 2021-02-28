# bidrag-docker
Github Actions for docker spesialisert for team bidrag

### Continuous integration
![](https://github.com/navikt/bidrag-docker/workflows/build%20actions/badge.svg)

### Hovedregel for design:
Alt blir utført av bash-scripter slik at det enkelt kan testes på reell kodebase uten å måtte bygge med
github.

### Changelog

Versjon | Endringstype | Beskrivelse
--------|--------------|------------
v1.2.2  | Endret       | `exists`: when checking for error curls, use -gt 0 not -eq 0
v1.2.1  | Endret       | `loval-exists`: sjekker at protokoll er HTTP/2 ikke HTTP/1.1
v1.2.0  | Opprettet    | `local-exists`: sjekker om docker image finnes lokalt
v1.1.2  | Endret       | `exists`: hvis ikke 404, så anta at image ikke finnes hvis det 401
v1.1.1  | Endret       | `exists`: image navn som argument til script
v1.1.0  | Opprettet    | `exists`: sjekker om docker image allerede er lastet opp til github
v1.0.0  | Opprettet    | `build`: bygger et docker image 
