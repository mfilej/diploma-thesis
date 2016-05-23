# Artisan

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

## Training a HMM and generating text with the resulting model

First make sure the tasks are ready to run:

    mix deps.get
    mix compile

Then chose an input file. In our example we will use the `LICENSE` file
included in this project:

    mkdir demo
    cat LICENSE | mix artisan.sanitize.words | mix artisan.key_seq example/demo
    esthmm -N 6 -M 102 -v example/demo.seq > example/demo.hmm

* The `N` parameter can be tweaked. It is usually set to approximately the
  number of parts of speech, but different values will be more suitable for
  different kinds of input text.
* The `M` parameter is the number of words in our dictionary (reported by
  the first command as `number of symbols in alphabet`).

At this point we are ready to generate some text. Run the following command
multiple times for different results:

  mix artisan.sim example/demo.hmm | mix artisan.decode example/demo.key

## Tasks for training and simulating Hidden Markov Models

To list available tasks:

    mix help --search artisan

To get help on individual task:

    mix help artisan.task_name

