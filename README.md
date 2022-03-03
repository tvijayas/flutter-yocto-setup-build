# flutter-yocto-setup-build

Setup packages for build

    sudo apt-get install gawk wget git-core diffstat unzip texinfo build-essential chrpath socat cpio python python3 pip3 pexpect libsdl1.2-dev xterm make xsltproc docbook-utils fop dblatex xmlto python-git libssl-dev pv

Install Google repo

    mkdir -p ~/.bin
    PATH="${HOME}/.bin:${PATH}"
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
    chmod a+rx ~/.bin/repo
    export PATH=${PATH}:~/bin
    
### build
```
pi4:
    ./raspberryPi4-64-flutter-setup-build.sh 
pi3:
    ./raspberryPi3-64-flutter-setup-build.sh
```

### References

     https://github.com/meta-flutter/meta-flutter/tree/honister
     https://github.com/jwinarske/manifests

