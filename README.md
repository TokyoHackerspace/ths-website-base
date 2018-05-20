# Tokyo Hackerspace Website.

## Development Usage

Note:  These instructions are for UNIX and MacOS development. If you are on windows, please run a linux virtual machine.

Clone this repository locally.

`git clone git@github.com:TokyoHackerspace/ths-website-base.git`

Once cloned you need to set $THS_GIT_BASE to point the parent directory of where you cloned "ths-website-base".  For example is you have your git repository here `/home/username/tokyohackerspace/ths-website-base` then $THS_GIT_BASE should point to `/home/username/tokyohackerspace`.  

The example I am going to provide is for the bash shell.  If you are using a shell other than bash you should set the environment variable the way your shell requires.  Since bash is the most commonly used I will provide it here.

In your user directory you should have one of these 3 files. `.profile`, `.bash_profile`, '.bashrc`.  Edit the file you have and then add the following line to it.

```
export $THS_GIT_BASE="/home/username/tokyohackerspace"
```

Once this is set you need to re-source the file so that it exists in memory, you can either close your terminal window and re-open it or you can execute the command `source <filename>` where `<filename>` the file you added the line to.


Now that the base environment is set you can use the make file to finish the build process.  Enter into the base repository in the terminal window and type `make build`.  The system will now clone the rest of the repositories needed to run the development environment.

`ths-website-rproxy` contains the nginx reverse proxy configuration
`ths-website-apache-php` contains the apache server used to host the main site and dokuwiki.











