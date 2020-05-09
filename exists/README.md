# bidrag-docker/exists

This action will see if an docker image allready exists, so that
restarting a workflow action will prevent buiding the source code
and the docker image once more.

Requires a runner that is able to execute bash scripts.
