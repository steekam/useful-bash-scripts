import os
import subprocess
import sys


#  Check if running as root
if os.getuid() == 0:
  print("We are root, we can proceed :)")
else:
  print("Let's run as root first")
  os.execvp('sudo', ['sudo', 'python3'] + sys.argv)

# Get domain name from args
domain_name =sys.argv[1]

# delete config file
print("Deleting configuration file...")
config_file = "/etc/httpd/virtual_hosts/"+domain_name+".conf"
if os.path.exists(config_file):
  os.remove(config_file)
else:
  print("Config file does not exist")
  print("Exiting...")
  quit()

# Updating hosts file
print("Updating hosts file...")
hosts_file_contents = open("/etc/hosts", "r").readlines()
new_contents = list(map(lambda line: (line.replace(domain_name,"")).strip(), hosts_file_contents))
open("/etc/hosts","w").write("\n".join(new_contents))

# Restarting httpd
print("Restarting httpd server...")
os.system("systemctl restart httpd")