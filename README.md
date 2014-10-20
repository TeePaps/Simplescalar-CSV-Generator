## To run the collection script:

#### Specify:
  * -f -- the collected results file name (csv output)
  * -d -- string of space-separated data values to collect (i.e. "sim_IPC il1.hits")
  * name of directory to run tests in


Example of running the script:

```
$ run -f results.csv -d "sim_IPC il1.hits" homework4
```

## The collector script looks for directories with the structure of:

root
   +-- conf

## After running, the direcotry will look like:

root
  +-- conf
  +-- out
  +-- results.csv
