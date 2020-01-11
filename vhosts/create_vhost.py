import os
import subprocess
import sys

class Vhost_automator:
  def __init__(self):
    self.domain_name = ""
    self.root_path = ""

  def get_inputs(self):
    self.domain_name = input("Enter desired domain name: ")
    
    # check if it's an absolute path 
    abs_path = False
    while not abs_path:
      self.root_path = input("Enter the absolute root path: ").rstrip('/')
      abs_path = os.path.isabs(self.root_path)
      if not abs_path:
        print("Not an absolute path")

  def create_vhostfile(self):
    print("Creating configurations...")
    # file template name domain_name.conf
    virtual_hosts_base_path = "/etc/httpd/virtual_hosts"
    script_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
    template_contents = open(script_dir+"/template.conf", "r").read()
    template_lines = list(map(lambda x: x.format(domain_name=self.domain_name, root_path=self.root_path) , template_contents.splitlines()))
    template_final = "\n".join(template_lines)

    # Create file
    output_file_name = "/".join([virtual_hosts_base_path,self.domain_name+".conf"])
    output_file = open(output_file_name, "w+")
    output_file.write(template_final)
    output_file.close()

  def update_hosts(self):
    print("Updating hosts file...")
    hosts_file_path = "/etc/hosts"
    hosts_file_contents = open(hosts_file_path, "r").readlines()
    for index,line in enumerate(hosts_file_contents):
      line_list = line.split()
      line_list.append(self.domain_name)
      hosts_file_contents[index] = "\t".join([line_list[0], " ".join(line_list[1:])])
    
    open(hosts_file_path, "w").write("\n".join(hosts_file_contents))

  def restart_httpd(self):
    print("Restarting httpd server...")
    os.system("systemctl restart httpd")


#  Check if running as root
if os.getuid() == 0:
  print("We are root, we can proceed :)")
else:
  print("Let's run as root first")
  os.execvp('sudo', ['sudo', 'python3'] + sys.argv)

print("\nCreate virtual host domains on your machine easily")
print("This script is made to be used with Redhat based systems such as Fedora")
print("-----------------------------------------------------------------------")

automator = Vhost_automator()
automator.get_inputs()
automator.create_vhostfile();
automator.update_hosts()
automator.restart_httpd()