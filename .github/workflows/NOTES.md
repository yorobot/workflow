# Notes


env

```
/home/runner                 # home directory - ~/
/home/runner/work/workflow   # work directory is ~/work/<repo_name>  -- e.g. workflow

$ uname -a
Linux fv-az68 5.4.0-1025-azure #25~18.04.1-Ubuntu SMP Sat Sep 5 15:28:57 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```


git
```
$ git --version
git version 2.28.0

$ git config --global user.name  "Yo Robot"
$ git config --global user.email "gerald.bauer+yorobot@gmail.com"
$ git config -l --global --show-origin
file:/etc/gitconfig	filter.lfs.smudge=git-lfs smudge -- %f
file:/etc/gitconfig	filter.lfs.process=git-lfs filter-process
file:/etc/gitconfig	filter.lfs.required=true
file:/etc/gitconfig	filter.lfs.clean=git-lfs clean -- %f
file:/home/runner/.gitconfig	user.name=Yo Robot
file:/home/runner/.gitconfig	user.email=gerald.bauer+yorobot@gmail.com
```



test ssh setup

```
Run ssh -vT git@github.com
-> ssh -vT git@github.com
-> shell: /bin/bash -e {0}

debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug1: Server host key: ssh-rsa SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8
debug1: Host 'github.com' is known and matches the RSA host key.
debug1: Found key in /etc/ssh/ssh_known_hosts:1
Warning: Permanently added the RSA host key for IP address '140.82.114.4' to the list of known hosts.
debug1: rekey after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: rekey after 134217728 blocks
debug1: SSH2_MSG_EXT_INFO received
debug1: kex_input_ext_info: server-sig-algs=<ssh-ed25519-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-dss-cert-v01@openssh.com,ssh-ed25519,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256,rsa-sha2-512,rsa-sha2-256,ssh-rsa,ssh-dss>
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: publickey
debug1: Next authentication method: publickey
debug1: Trying private key: /home/runner/.ssh/id_rsa
debug1: Trying private key: /home/runner/.ssh/id_dsa
debug1: Trying private key: /home/runner/.ssh/id_ecdsa
debug1: Trying private key: /home/runner/.ssh/id_ed25519
debug1: No more authentication methods to try.
git@github.com: Permission denied (publickey).

[error]Process completed with exit code 255.
```