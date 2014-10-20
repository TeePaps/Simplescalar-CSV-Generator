#!/bin/bash

if [ ! -d ./out ]; then
  echo "FATAL: No output directory"
  exit 1
fi

ROOT_DIR=$PWD

pushd ./out > /dev/null

for dir in *
do
  echo $dir
  . $BENCHMARKS_ROOT/bin/gather-from-cfg.sh $dir $@
  echo
done

popd > /dev/null
