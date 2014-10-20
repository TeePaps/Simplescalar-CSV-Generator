#!/bin/bash

if [ -z "$BENCHMARKS_ROOT" ]; then
  echo "FATAL: No root directory for the benchmark tests was found"
  exit 1
fi

MACH_HOME=$BENCHMARKS_ROOT/machines
echo Looking for machines in $MACH_HOME
if [ ! -d "$MACH_HOME" ]; then
  echo "FATAL: No machines for the benchmark tests was found"
  exit 1
fi

# Make the directories for the output, save the old one if exists
OUT_DIR=out
if [ -d "./$OUT_DIR" ]; then
  echo Output file already exists, moving old one to $PWD/"$OUT_DIR".bak
  mv ./"$OUT_DIR" ./"$OUT_DIR".bak
fi
mkdir $OUT_DIR

for dir in "$MACH_HOME"/*
do
    dirname=$(basename "$dir")
    mkdir -p "./$OUT_DIR/$dirname"
done

# Iterator for the experiment number display
i=1

# Run the commands
for conffile in conf/*.cfg
do
  outfile=$(basename "$conffile.out")

  for dir in "$OUT_DIR"/*
  do
    touch "./$dir/$outfile"
  done

  echo -e "Running experiment #$i...\n"

  sim-outorder -config ./"$conffile" -redir:sim $OUT_DIR/bzip2/$outfile $MACH_HOME/bzip2/bzip2_base.i386-m32-gcc42-nn $MACH_HOME/bzip2/dryer.jpg
  sim-outorder -config ./"$conffile" -redir:sim $OUT_DIR/equake/$outfile $MACH_HOME/equake/equake_base.pisa_little < $MACH_HOME/equake/inp.in > /dev/null
  sim-outorder -config ./"$conffile" -redir:sim $OUT_DIR/hmmer/$outfile $MACH_HOME/hmmer/hmmer_base.i386-m32-gcc42-nn  $MACH_HOME/hmmer/bombesin.hmm
  sim-outorder -config ./"$conffile" -redir:sim $OUT_DIR/mcf/$outfile $MACH_HOME/mcf/mcf_base.i386-m32-gcc42-nn $MACH_HOME/mcf/inp.in
  sim-outorder -config ./"$conffile" -redir:sim $OUT_DIR/milc/$outfile $MACH_HOME/milc/milc_base.i386-m32-gcc42-nn < $MACH_HOME/milc/su3imp.in
  sim-outorder -config ./"$conffile" -redir:sim $OUT_DIR/sjeng/$outfile $MACH_HOME/sjeng/sjeng_base.i386-m32-gcc42-nn $MACH_HOME/sjeng/test.txt

  echo -e "\nFinished!"
  echo -e "-----------------------------------------------------------------------\n\n"

  i=$(($i + 1))
done
