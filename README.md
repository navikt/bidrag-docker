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
v1.1.0  | Opprettet    | `exists`: sjekker om docker image allerede er lastet opp til github
v1.0.0  | Opprettet    | `build`: bygger et docker image 
