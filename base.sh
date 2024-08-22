#!/bin/zsh

wget -q -O - https://git.io/vQhTU | bash -s -- --version 1.22.1
source ~/.bashrc

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
source ~/.bashrc

nvm install 18
nvm use 18

## install foundryup
curl -L https://foundry.paradigm.xyz | bash
source ~/.bashrc
foundryup

## install tucana
git clone https://github.com/TucanaProtocol/Tucana.git
cd Tucana
git checkout hunter/chain-event
cd potv

## start makebuild

## install hardhat
npm install
npm install --save-dev hardhat
