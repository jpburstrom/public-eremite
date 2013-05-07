#!/bin/bash

broadcast="169.254.255.255"

ping $broadcast > /dev/null &
sleep 1
arp -a 
kill $!
