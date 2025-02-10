#!/bin/bash
docker run --rm -ti --name google-photos-sync -v $PWD/config:/config -v $PWD/storage:/storage gilesknap/gphotos-sync /storage $@
