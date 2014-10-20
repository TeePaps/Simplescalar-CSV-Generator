## To run the collection script:

#### Make sure these lines are in your .bashrc file (and source it after) on the linux machine:

```
export SIMPLESIM=/home/software/simplesim
export PATH=$SIMPLESIM/simplesim-3.0:$PATH
```

Or if you are using tsch (psu ladon server default), set them as so:
```
setenv SIMPLESIM=/home/software/simplesim
setenv PATH $PATH\:$SIMPLESIM/simplesim-3.0:$PATH
```

#### Specify:
  * -f -- the collected results file name (csv output)
  * -d -- string of space-separated data values to collect (i.e. "sim_IPC il1.hits")
  * name of directory to run tests in


Example of running the script:

```
$ run -f results.csv -d "sim_IPC il1.hits" homework4
```

## The collector script looks for directories with the structure of:

```
root
   +-- conf
```

## After running, the direcotry will look like:

```
root
  +-- conf
  +-- out
  +-- results.csv
```
