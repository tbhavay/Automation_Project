# Automation_Project
Task - 2: This subtask dictates to write a script named automation.sh.
It is supposed to perform the following tasks:
1.Performing an update of the package details and the package list at the start of the script.
2.Installing the apache2 package if it is not already installed. 
3.Ensuring that the apache2 service is running. 
4.Ensuring that the apache2 service is enabled. 
5.Creating a tar archive of apache2 access logs and error logs that are present in the /var/log/apache2/ directory and place the tar into the /tmp/ directory. 
6.The script should run the AWS CLI command and copy the archive to the s3 bucket. 

All this becomes a weekly/daily activity. These tasks can take a long time if done manually again and again. 

Task - 3: This subtask dictates the following tasks:
1.Bookkeeping of archived files takes place 
2.Cron Job for auto execution of script at regular intervals.
