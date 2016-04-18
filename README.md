# s3grep
A dirty and slow way to grep multiple files on s3

# Usage
./s3grep "s3://your-bucket/an/optional/prefix" "a-grep-pattern"

This will create a directory $HOME/s3grepworkdir

The result of all the greps are in $HOME/s3grepworkdir/s3grep.results

The list of matchin files are in $HOME/s3grepworkdir/s3grep.matching

# How does it works?
It will list the files of the s3 folder, then download each file individually.

Once a file is downloaded, it will run the grep on the file, save the result, then delete the file.

So yes, it's dirty and slow, but it does the job.
