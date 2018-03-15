# A Slice of Elm (beta)

This repository is intended to provide the Elm beginner and intermediate with a playground for exploring different parts of Elm in the context of a working application, and in a format that is suitable when time is limited e.g. at an Elm Coding Meetup.

## Get the source

1. Start by forking this repository [Github](https://github.com/madsflensted/a-slice-of-elm-beta#fork-destination-box)
1. Clone your own fork of the repository

Forking the repository instead of just cloning it directly, will allow you to look at, and compare with solutions created by fellow Elm'ers when you push to Github. Simply go the the [Network view](https://github.com/madsflensted/a-slice-of-elm-beta/network) of the main repository and select the forks/branches to compare.

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

For both sizes the idea is for you to work your way back to the functionality that is in the `master` branch. E.g. for `slice-json-decode-small`, the Json decoder is partially in place but more fields needs to be decoded and added to the Model. The intention is *not* for you to match the code line-by-line with the code in master, just the functionality.

You can also go for a "large" slice, here you checkout the "medium" branch, but instead of working back towards the `master`, you complete the feature using a completely different path, e.g. for the `slice-view-svg-medium`, you build the graph visualization using Canvas or WebGL or something else.

The repository is currently prepared with branches for these slices:

* Json Encode
  * relevant docs: [Json.Encode](http://package.elm-lang.org/packages/NoRedInk/elm-decode-pipeline/latest)
  * branch: `slice-json-encode-small`
    * Encode some of the fields needed to pass to the `dagre` javascript library.
  * branch: `slice-json-encode-medium`
    * Convert the GraphData into Json to pass to the external layout engine.
* Json Decode
  * relevant docs:
    * [Json.Decode](http://package.elm-lang.org/packages/elm-lang/core/latest/Json-Decode)
    * [Json.Decode.Pipeline](http://package.elm-lang.org/packages/elm-lang/core/latest/Json-Encode)
  * branch: `slice-json-decode-small`
    * Decode a few missing fields
  * branch: `slice-json-decode-medium`
    * Add Json decoding to the application, taking the raw Json string and turning it in to a GraphData value
* Javascript Interop/Ports
  * relevant docs:
    * [Javascript Interop](http://elm-lang.org/docs/syntax#javascript-interop)
    * [The Elm Guide](https://guide.elm-lang.org/interop/)
  * branch: `slice-ports-small`
    * Send the graph layout data from `dagre` library into the Elm Elm application
  * branch: `slice-ports-medium`
    * *tbd*
* View - SVG
  * relevant docs: [Svg](http://package.elm-lang.org/packages/elm-lang/svg/latest)
  * branch: `slice-view-svg-small`
    * Here the graph rendering only renders the nodes. Add support for drawing the edges.
  * branch: `slice-view-svg-medium`
    * Look at the documentation Svg module to figure out how to render the graph data. Nodes are expected to be rectangular, and the GraphData contains information about size of image and nodes/edges.
* View - General *tbd*
* Parser *tbd*
* Tests
  * branch: `slice-tests-small`
    * Here you will find a single passing test. Try to add more tests for the GraphParser module.
  * branch: `slice-tests-medium`
    * Here the project does not yet have any tests setup. Look at the documentation for [elm-test](http://package.elm-lang.org/packages/elm-community/elm-test/latest) for how to add tests to the project.
* Tasks - debounce *tbd*
* Application structure *tbd*

## Useful links

* Elm tools installation platform specific instructions and Editor plugin links in [the official guide](https://guide.elm-lang.org/install.html)
* The [Elm syntax reference](http://elm-lang.org/docs/syntax) is also good to have handy.
* Javascript and Elm syntax [side-by-side](http://elm-lang.org/docs/from-javascript)

## Do you have question? Or some feedback?

Simply leave a comment on this [Github Issue](https://github.com/madsflensted/a-slice-of-elm-beta/issues/1)

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
