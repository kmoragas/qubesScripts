# $1 vm-name
# $2 path
# $2 filename

qvm-run --pass-io $1 "cat $2" > $3
