FROM ubuntu:14.04.1

# Copy cron job to container
ADD example-job.cronjob /opt/mycrons/example-job.cronjob

# Change permission cron job file and load it with crontab
RUN \
    chmod 0644 /opt/mycrons/example-job.cronjob && \
    crontab /opt/mycrons/example-job.cronjob

# Create a file needed by hello.cronjob
RUN \
    touch /var/log/cron.log

# Run the command on container startup:
# - Run non-daemonized cron in background
# - Output the log result from hello.cronjob
CMD (cron -f &) tail -f /var/log/cron.log
