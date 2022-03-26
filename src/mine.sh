#!/bin/bash


SCRIPT_PATH=`pwd`;


cd $SCRIPT_PATH


echo Press [CTRL+C] to stop mining.


while :


do


./shibacoin-cli generatetoaddress 1 $(./shibacoin-cli getnewaddress)



