#!/usr/bin/env bash
set -ex

# Install dependencies
sudo apt-get install -y libarpack2-dev libspooles-dev libyaml-cpp-dev

# Make sure to be in home directory
cd 

# Install CalculiX
wget --quiet http://www.dhondt.de/ccx_2.20.src.tar.bz2
tar xvjf ccx_2.20.src.tar.bz2
# for gfortran10: -fallow-argument-mismatch
perl -pi -e "s| -fopenmp| -fopenmp -fallow-argument-mismatch|" CalculiX/ccx_2.20/src/Makefile
rm -fv ccx_2.20.src.tar.bz2

# Get the CalculiX-preCICE adapter
if [ ! -d "calculix-adapter/" ]; then
    git clone --depth=1 --branch master https://github.com/precice/calculix-adapter.git
fi
(
    cd calculix-adapter
    git pull
    make -j "$(nproc)"
)

# Add the CalculiX adapter to PATH
echo "export PATH=\"\${HOME}/calculix-adapter/bin:\${PATH}\"" >>~/.bashrc
