#  SLIME

#### Description

SLIME is a novel program-sensitive fuzzer that designs multiple property-aware queues and leverages a customized Particle Swarm Optimization (PSO) algorithm. SLIME is developed based on top of [MOpt-AFL](https://github.com/puppet-meteor/MOpt-AFL). Read the [paper]() for more details.

#### Environment

- Tested on Ubuntu 16.04 64bit and LLVM 9.0.0

#### Installation

Before install SLIME, user should prepare llvm.

- Download clang 9.0.0 source code from the [link](http://releases.llvm.org/download.html). You at least need to download LLVM source code and Clang source code. 

  ```
  $ wget https://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz
  $ wget https://releases.llvm.org/9.0.0/cfe-9.0.0.src.tar.xz
  ```

- Decompression the downloaded archives:

  ```
  $ tar -xvf llvm-9.0.0.src.tar.xz && mv llvm-9.0.0.src llvm
  $ tar -xvf cfe-9.0.0.src.tar.xz && mv cfe-9.0.0.src llvm/tools/clang
  ```

- Compile clang. 

  ```
  $ mkdir build
  $ cd build
  $ cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ../llvm
  $ make -j4
  $ make install
  ```

#### Install SLIME

- Clone repository:

  ```
  $ git clone https://github.com/diewufeihong/SLIME
  ```

- Compile:

```
cd SLIME && make && cd llvm_mode && make && cd ../llvm_mode_crash && make     
```

#### RUN SLIME

- Require to set the following environment variables

```
#   INPUT: input seed files
#   OUTPUT: output directory
#   Target_1: target program path compiled by llvm_mode  
#   Target_2: target program path compiled by llvm_mode_crash
#   Target_1_dir: target program directory, which contiains bb_file 
#   bb_file: files generated when compiling to record basic blocks' information 
#   CMDLINE: command line for a testing program and the target path is the same as Target_1
```

- Compile the target program

```
#	Target_1:
CC=/path_to_SLIME/llvm_mode/afl-clang-fast \
 CXX=/path_to_SLIME/llvm_mode/afl-clang-fast++ \
 ./configure \
 --prefix=/path_to_compiled_program
 
 #	Target_2:
 CC=/path_to_SLIME/llvm_mode_crash/afl-clang-fast \
 CXX=/path_to_SLIME/llvm_mode_crash/afl-clang-fast++ \
 ./configure \
 --prefix=/path_to_compiled_program
```

- Start fuzz

```
/path_to_SLIME/afl-fuzz -i $INPUT -o $OUTPUT -H $Target_1_dir -A $Target_2 -L 0 -- $CMDLINE
```



