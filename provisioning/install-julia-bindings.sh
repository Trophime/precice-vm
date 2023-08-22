#!/usr/bin/env bash

# install latest julia
sudo pip3 install jill
sudo jill install --confirm

# install preCICE bindings
sudo julia -e 'using Pkg; Pkg.add("PreCICE")'

# to test the installation, run the following command:
# julia -e 'using Pkg; Pkg.test("PreCICE")'
