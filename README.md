# A Slice of Elm (beta)

This repository is intended to provide the Elm beginner and intermediate with a playground for exploring different parts of Elm in the context of a working application, and in a format that is suitable when time is limited e.g. at an Elm Coding Meetup.

## Get the source

1. Start by forking this repository [Github](https://github.com/madsflensted/a-slice-of-elm-beta#fork-destination-box)
1. Clone your own fork of the repository

## Setup Elm

### Install from scratch

Download and install the Elm compiler, elm-test, elm-format plus all needed Elm packages, locally in your working folder.
```sh
npm install
```

### If you already have Elm, elm-test and elm-format installed

Just install the needed Elm packages.

```sh
elm-package install --yes

```

### Beginner

If you are completely new to Elm I suggest you spend a little time exploring the basic syntax and libraries.

Some good resources are:

* Interactive examples on [elm-lang.org](http://elm-lang.org/examples)
* Exercises in functional programming with Elm on [excercism.io](http://exercism.io/languages/elm/about)

The [Elm syntax reference](http://elm-lang.org/docs/syntax) is also good to have handy.

## The Application

The application is a simple graph editor and viewer. You specify the graph in a textual format, the parsed graph specification is sent to an external JS library [dagre](https://github.com/dagrejs/dagre/wiki), which calculates the layout given certain contstraints. The layout specifcation is passed back to the Elm part of the application where the graph is drawn using SVG.

### Inspect the working App

To compile and run the application
```sh
npm run-script build
npm start
```
which just executes the following commands:
```sh
elm make --debug --output elm.js src/Main.elm
elm-reactor
```

Open the application http://localhost:8000/index.html, and poke around. Open the Elm Debug window and look at the Message flow.

## Select a Slice

This repository is structured in a way such that you can remove a slice of the application by doing

```sh
git checkout <slice branch>
```

If possible each slice comes in "small" and "medium" sizes. For a "small" slice the feature is partially implemented and needs to be completed. For a "medium" slice the part is completely stubbed out and needs to be added.

For both sizes the idea is for you to work your way back to the functionality that is in the `master` branch. E.g. for `slice-json-decode-small`, the Json decoder is partially in place but more fields needs to be decoded and added to the Model.

You can also go for a "big" slice, here you checkout the "medium" branch, but instead of working back towards the `master`, you complete the feature using a completely different path, e.g. for the `slice-view-svg-medium`, you build the graph visualization using Canvas or WebGL or something else.

The repository is currently prepared with branches for these slices:

* JSON Encode: *tbd*
* JSON Decode: *tbd*
* JS Interop/Ports: *tbd*
* View - SVG: *tbd*
* Parser: *tbd*
* Tests: *tbd*
* Tasks - debounce: *tbd*
* Application structure: *tbd*

## Useful links

* Elm tools installation platform specific instructions and Editor plugin links in [the official guide](https://guide.elm-lang.org/install.html)
* The [Elm syntax reference](http://elm-lang.org/docs/syntax) is also good to have handy.

## Leave your feedback or ask questions

Simply comment on this [Github Issue](https://github.com/madsflensted/a-slice-of-elm-beta/issues/1)

## BETA TODO
* Application
  * Add settings panel to adjust graph properties
  * Improve parser error messages
  * Header and github link
  * Add more test (add html tests)
* Repository
  * More slice branches
  * Code documentation
  * Write Slice intros (wiki?)
  * Setup discuss/feedback github issues
