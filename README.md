# bidrag-docker
Github Actions for docker spesialisert for team bidrag

### Continuous integration
![](https://github.com/navikt/bidrag-docker/workflows/build%20actions/badge.svg)

### Hovedregel for design:
Alt blir utført av bash-scripter slik at det enkelt kan testes på reell kodebase uten å måtte bygge med
github. Javascript brukes dog til å hente informasjon om den som forårsaker en workflow til å bli utført.

### Changelog

Versjon | Endringstype | Beskrivelse
--------|--------------|------------
v1.0.0  | Opprettet    | `build`: bygger et docker image 
