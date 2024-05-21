#!/bin/bash

sudo modprobe vxcan
sudo modprobe can-gw

docker plugin install wsovalle/vxcan
