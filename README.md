# Python scripts 
## Content

``vhosts/`` 
> Automate creation and deletion of virtual hosts on my local apache server

- ``create_vhost.py``  Interactive script. Prompts you for desired domain name and root path of the domain root directory. It also verifies path is an absolute path.
- ``destroy_vhost.py`` Pass domain name as an argument and it deletes config file and updated hosts file.