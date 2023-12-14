#!/bin/bash

rm -rf user*
rm ch*
rm hs*
freechains-host stop --port=8331
freechains-host stop --port=8332
freechains-host stop --port=8333
freechains-host stop --port=8334
freechains-host stop --port=8335

