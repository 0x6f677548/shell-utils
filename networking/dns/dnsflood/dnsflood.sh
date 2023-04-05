#./dhsflood.sh 60 192.168.1.225
# generates flood requests using dnsperf util 
# targets  a destination dns server, with random requests from files in ./dnsflood-rndrecs/ folder
#useful to flood a dns server, testing performance, or mining pi-holes with random data
runtime=$1" minute"
endtime=$(date -ud "$runtime" +%s)
MINWAIT=5
MAXWAIT=120
MINEXEC=5
MAXEXEC=60
MINFILE=1
MAXFILE=100
while [$(date -u +%s) -le $endtime]
do
        echo "Time Now: `date +%H:%M:%S`"

        dnsperf -l $((MINEXE+RANDOM % (MAXEXEC-MINEXEC)))  -s $2 -Q 5 -d ./dnsflood-rndrecs/rndrecs$((MINFILE+RANDOM % (MAXFILE-MINFILE))).txt
        randomsleep=$((MINWAIT+RANDOM % (MAXWAIT-MINWAIT)))
        echo "sleeping randomly: " $randomsleep
        sleep $randomsleep
done
