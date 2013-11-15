# memoi.se

memoi.se is a complete web application written in Haskell, designed to be used as a reference by beginners.  By looking at the git commit history of this repository, you can see a series of changes, building up from a simple "Hello, world!" app to a fully-functional hyperlink shortener with PostgreSQL database integration, in under 100 lines of Haskell.

## Getting Started

Begin by entering the following commands into your terminal window.  You'll need to [have Haskell installed](http://www.haskell.org/platform/).

```sh
$ git clone git://github.com/ryantrinkle/memoise
$ cd memoise
$ git checkout lesson-1
$ cabal install
$ ./dist/build/memoise/memoise
```

Now, open a browser and go to [http://localhost:8000/](http://localhost:8000/).

You should see "Hello, world!" displayed.  If you look at [src/Main.hs in lesson-1](https://github.com/ryantrinkle/memoise/blob/lesson-1/src/Main.hs), you can see that this is achieved with just a few simple lines of Haskell.

To shut down the memoi.se server, press Ctrl-C in your terminal window.  Once you've taken a look around in Lesson 1, you can move on to Lesson 2 by running

```sh
$ git checkout lesson-2
$ cabal install
$ ./dist/build/memoise/memoise
```

## Lessons

Although looking at the checked out code may be helpful, a more informative way to look at this project is by viewing the commit history.  Each lesson is a single git commit, designed to add a single piece of functionality, as you might do if you were creating a website from scratch.

You can take a look at the changes made in each lession here:

* [Lesson 1](http://github.com/ryantrinkle/memoise/commit/lesson-1)
* [Lesson 2](http://github.com/ryantrinkle/memoise/commit/lesson-2)
* [Lesson 3](http://github.com/ryantrinkle/memoise/commit/lesson-3)
* [Lesson 4](http://github.com/ryantrinkle/memoise/commit/lesson-4)
* [Lesson 5](http://github.com/ryantrinkle/memoise/commit/lesson-5)
* [Lesson 6](http://github.com/ryantrinkle/memoise/commit/lesson-6)
* [Lesson 7](http://github.com/ryantrinkle/memoise/commit/lesson-7)

Note: You need PostgreSQL installed for Lessons 8-11.

* [Lesson 8](http://github.com/ryantrinkle/memoise/commit/lesson-8)
* [Lesson 9](http://github.com/ryantrinkle/memoise/commit/lesson-9)
* [Lesson 10](http://github.com/ryantrinkle/memoise/commit/lesson-10)
* [Lesson 11](http://github.com/ryantrinkle/memoise/commit/lesson-11)
