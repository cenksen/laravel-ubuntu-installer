
# ubuntu-laravel-installer


Hi!

This project contains a bash script designed to automatically deploy Laravel applications on Ubuntu servers.It installs components such as Php, Nginx, MySQL, Composer, Git, and Certbot on your server.

##  Installation

Copy or download this repository.
Change the permissions of the installer.sh file: 
chmod +x installer.sh
Copy the installer.sh file to your server.

 ### Usage
Open a terminal and navigate to the directory where the installer.sh file is located.
Run the command 

./installer.sh.

The script will prompt you with a few questions, such as which Laravel application you want to deploy or if you want to create an SSL certificate. Answer them accordingly.






```bash
  git clone git@github.com:cenksen/laravel-ubuntu-installer.git
```



```bash
  cd laravel-ubuntu-installer
```


```bash
  chmod +x installer.sh
```



```bash
 ./installer.sh
```

  

#### Important Notes
This script has only been tested on Ubuntu servers and may not work on different operating systems.
Your server must be connected to the internet when running the script.
This script is designed to update an already installed Laravel application, not to install it.


#### License
This project is licensed under the MIT License. See the LICENSE file for more information.

##### Contributing
If you find any issues or bugs, please create a GitHub Issue. Pull requests for code contributions are also welcome.

Happy deploying!
