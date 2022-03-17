WINDOWS BUILD NOTES
====================

Some notes on how to build mbrocoin for Windows.

Most developers use cross-compilation from Ubuntu to build executables for
Windows. This is also used to build the release binaries.

Building on Windows itself is possible (for example using msys / mingw-w64),
but no one documented the steps to do this. If you are doing this, please contribute them.

Cross-compilation
-------------------

These steps can be performed on, for example, an Ubuntu VM. The depends system
will also work on other Linux distributions, however the commands for
installing the toolchain will be different.

Make sure you install the build requirements mentioned in
[build-unix.md](/doc/build-unix.md).
Then, install the toolchains and curl:

    sudo apt update
    sudo apt upgrade
    sudo apt-get install g++-mingw-w64-i686 mingw-w64-i686-dev g++-mingw-w64-x86-64 mingw-w64-x86-64-dev curl -y
    sudo apt install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git libtool-bin nsis -y

If you're building on Ubuntu 17.04 or later, run these two commands, selecting the 'posix' variant for both,
to work around issues with mingw-w64. See issue [8732](https://github.com/redecoinProject/redecoin/issues/8732) for more information.
```
sudo update-alternatives --config x86_64-w64-mingw32-g++
sudo update-alternatives --config x86_64-w64-mingw32-gcc
```
To build executables for Windows 64-bit:

    cd depends
    make HOST=x86_64-w64-mingw32 -j4
    cd ..
    ./autogen.sh
    ./configure --prefix=`pwd`/depends/x86_64-w64-mingw32
    make

To build executables for Windows 32-bit:

    cd depends
    make HOST=i686-w64-mingw32 -j4
    cd ..
    ./autogen.sh
    ./configure --prefix=`pwd`/depends/i686-w64-mingw32
    make
## Depends system

For further documentation on the depends system see [README.md](../depends/README.md) in the depends directory.

Installation
-------------

After building using the Windows subsystem it can be useful to copy the compiled
executables to a directory on the windows drive in the same directory structure
as they appear in the release `.zip` archive. This can be done in the following
way. This will install to `c:\workspace\mbrocoin`, for example:

    make install DESTDIR=/mnt/c/local/mbrocoin

You can also create an installer using:

    make deploy
