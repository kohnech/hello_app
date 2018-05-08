A HelloWorld App with unit/component tests
============================
We use gtest/gmock for unittests and pytest for component tests.

## How to use it
type
```
make help
```
to get a list of commands. If you want to run all the tests:
```
make test
```
Only running unit tests:
```
make unit_tests
```
or component tests:
```
make component_tests
```


Folder Structure Conventions
============================

> Folder structure options and naming conventions for software projects

### A typical top-level directory layout

    .
    ├── output*/                # *NOTE: Not checked-in! Compiled files (alternatively `dist` or 'build')
    ├── docs                    # Documentation files (alternatively `doc`)
    ├── src                     # Source files (alternatively `lib` or `app`)
    ├── inc                     # Include files (alternatively `include` used to share your app/lib)
    ├── test                    # Automated tests (alternatively `spec` or `tests`)
        ├── unit                # Automated unit tests
        ├── component           # Automated component tests
        ├── mock                # Mocks used for unit tests
    ├── tools                   # Tools and utilities (alternatively 'script' or 'scripts')
    ├── LICENSE
    └── README.md
    └── Makefile                # Currently preffered build system (alternatively CMakeDefs.txt for Cmake)


> Use short lowercase names at least for the top-level files and folders except
> `LICENSE`, `README.md`

### Source files

The actual source files of a software project are usually stored inside the
`src` folder. Alternatively, you can put them into the `lib` (if you're
developing a library), or into the `app` folder (if your application's source
files are not supposed to be compiled).

File types:
* **.cpp** & **.h**[4] go together, .h being the “header” — designed this way to allow programmers to release libs
and .h files without source code, to create proprietary or closed source libraries that can be distributed without source.
* **.hpp** is a combination of the two files. [5] I’ve seen a lot of differing opinions as to why an .hpp and the .h / .cpp combination are picked over each other. It comes back to the age-old question of “where is the line drawn between C++ and C?”

### Automated tests

Automated tests are usually placed into the `test` or, less commonly, into the `spec` or `tests` folder.

> **Q: Why tests are placed into a separate folder, as opposed to having them closer to the code under test?**
>
> **A:** Because you don't want to test the code, you want to test the *program*.

    .
    ├── ...
    ├── test                    # Test files (alternatively `spec` or `tests`)
    │   ├── benchmarks          # Load and stress tests
    │   ├── integration         # End-to-end, integration tests (alternatively `e2e`)
    │   ├── component           # Test the program (app/lib...)
    │   └── unit                # Unit tests
    │   └── mock                # Mock Unit tests
    └── ...

### Build-system files

Top level Makefile that build this project. Default targets are:
```
make            % Will run help target on next line.
make help       % Shows which targets, and a list of compatible SDKs & toolchains.
make all        % Builds entire project
make clean      % Cleans compiled files and artifacts in our case output/
```


### Compiled files
This is an automated generated folder typically named ('output', 'build', 'dist'...)
with compiled units and artifacts. A typical generated structure could look like:

    .
    ├── ...
    ├── output
    │   ├── test/               # Generated test executables. Note these only need to run on 1 architecture.
    │   ├── doc/                # Generated doc with ex doxygen. No architecture dependency here.
    │   ├── obj/                # Compiled units.
    │   ├── artifacts/          # The program itself whether library or executable. (alternatively lib, bin, app...)
    │   ├── 3rd-party/          # 3rd-party dependencies are installed here. It will contain sub-dirs for each 3rd-party component.
    │   └── ...                 # etc.
    └── ...
Cross compiling is easy using the correct toolchain settings. We sort architecture specific
compiled files under some output (obj and artifacts) categories:

    .
    ├── ...
    ├── artifacts/
    │   ├── armv7l/             # Armv v7 version
    │   ├── x86_amd64/          # x86, 64 bit version
    │   └── ...                 # etc...
    └── ...
Debug release is sorted in each architecture:

    .
    ├── ...
    ├── x86_amd64/
    │   ├── debug/              # Debug version
    │   ├── release/            # Release version
    └── ...


### Documentation files

Often it is beneficial to include some reference data into the project, such as
Rich Text Format (RTF) documentation, which is usually stored into the `docs`
or, less commonly, into the `doc` folder.

    .
    ├── ...
    ├── docs                    # Documentation files (alternatively `doc`)
    │   ├── TOC.md              # Table of contents
    │   ├── faq.md              # Frequently asked questions
    │   ├── misc.md             # Miscellaneous information
    │   ├── usage.md            # Getting started guide
    │   └── ...                 # etc.
    └── ...