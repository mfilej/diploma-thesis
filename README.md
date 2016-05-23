# Artisan

## Tasks for training and simulating Markov Chains and Hidden Markov Models

To list available tasks:

    mix help --search artisan

To get help on individual task:

    mix help artisan.task_name

## Installing the UMDHMM tool for training Hidden Markov Models

    mkdir tools
    cd tools
    wget http://www.kanungo.com/software/umdhmm-v1.02.tar
    tar xvf umdhmm-v1.02.tar
    cd umdhmm-v1.02/
    rm esthmm genseq testfor testvit
    env CPPFLAGS=-I/usr/include/malloc/ make all

The last step may depend on your platform. Only tested on OS X 10.11.4 with
developer tools installed.

You can add `tools/umdhmm-v1.02` to your `PATH` for convenience or just run
the program directly (`./tools/umdhmm-v1.02/esthmm`).
