# Text Generation using Hidden Markov Models

The document is typeset with LaTeX. Chapters are written in markdown wherever
possible.

See [code](code) directory for Comparison chapter source code.

The markdown to LaTeX conversion requires [pandoc].

To trigger a pdf build run `rake`. This will compile changed markdown files
and invoke `latexmk`. See [Rakefile](Rakefile) for details.

Running `bin/watch` will trigger a build for every content change (requires
[fswatch]).

Homebrew users can install dependencies via `brew bundle`.

For previewing the resulting pdf file we suggest using a viewer that can
automatically reload when a file changes, like [TeXShop].

[pandoc]: http://pandoc.org
[fswatch]: https://github.com/emcrisostomo/fswatch
[texshop]: http://pages.uoregon.edu/koch/texshop
