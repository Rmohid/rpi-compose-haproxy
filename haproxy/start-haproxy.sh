# Need a shell script so that haproxy isn't pid 1
HDIR=/haproxy-override
PROCS=`ps ef`
UP=`echo $PROCS |  /bin/grep -c haproxy.cfg`
echo $PROCS
exec haproxy -f $HDIR/haproxy.cfg -p /var/run/haproxy.pid -sf 2
exit $?
