########################################################
# Script to email a mtr report on alert from Smokeping #
########################################################

alertname=$1
target=$2
losspattern=$3
rtt=$4
hostname=$5
raise=$6

email="yori.key.logger@gmail.com"
smokename="NetNam-Smokeping-"
report_dir=/tmp
timestamp=`date "+%Y%m%d%H%M%S"`
report_file=${report_dir}/${target}_${timestamp}.txt

if [ "$raise" -eq 1 ];
then
        subject="ALERT:${smokename} - ${target} - ${hostname} - ${alertname}"
else
        subject="CLEAR:${smokename} - ${target} - ${hostname} - ${alertname}"
fi

echo "MTR Report for hostname: ${hostname}" > $report_file
echo "" >> $report_file
echo "sudo mtr -n --report ${hostname} "
sudo /usr/bin/mtr -n --report ${hostname} >> $report_file

echo "" >> $report_file
echo "Name of Alert: " $alertname >> $report_file
echo "Target: " $target >> $report_file
echo "Loss Pattern: " $losspattern >> $report_file
echo "RTT Pattern: " $rtt >> $report_file
echo "Hostname: " $hostname >> $report_file
echo "" >> $report_file
echo "Full mtr command is: sudo /usr/bin/mtr -n --report ${hostname}" >> $report_file

echo "subject: " $subject
if [ -s $report_file ]; then
echo "${subject}" | mail -s "${subject}" $email -A $report_file
echo "${subject} $email"
fi
