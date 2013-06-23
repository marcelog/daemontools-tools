#!/bin/sh

# Check arguments.
if [ "$#" -lt 1 ]; then
  echo "Use: ${0} <service_name> [\"dependency1 dependency2\"]"
  exit 254
fi
  
# Get our base directory (the one where this script is located)
root=$(dirname ${0})
root=`cd ${root}; pwd`
tools=${root}/daemontools-tools

if [ ! -f "${tools}" ]; then
    echo "Could not open ${tools}"
    exit 254
fi

.  ${tools}

service=${1}
dependencies=${2}

# Wait for dependencies.
for i in ${dependencies}; do
  waiton ${service} ${i}
done
  
# Run the service, in background, get the new pid.
exec_cmd=$(get_service_cmd ${service})
${exec_cmd} >/dev/null&
pid=$!

# Trap signals, and forward them to the child proc.
trap "kill ${pid}" SIGINT SIGTERM
hipchat_notify "green" "Starting ${1} with pid: ${pid}: ${exec_cmd}"
save_pidfile ${service} ${pid}

# Main loop, while service is running, check once/sec.
is_pid_up ${pid}
while [ "${?}" -eq "1" ]; do
  sleep 1
  is_pid_up ${pid}
done

# Service exited. Cleanup.
del_pidfile ${service}
hipchat_notify "red" "Stopping ${1} with pid: ${pid}."
exit ${status}

