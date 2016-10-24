# openshift-devtools

Personal scripts used while developing OpenShift 3.

This is by no means meant to work for everyone, but I'm sharing in the hope it
might be useful for some.

## Assumptions

These scripts here might help you specially if you:

- are developing [OpenShift](https://github.com/openshift/origin)
- use Vagrant + VirtualBox
- always login as user "demo"

## Setup

My setup is to mount this repository at `/scripts` in my development virtual
machine. I do it by patching my Vagrantfile (from origin):

```diff
diff --git a/Vagrantfile b/Vagrantfile
index bdc059c..82c5c82 100644
--- a/Vagrantfile
+++ b/Vagrantfile
@@ -200,6 +200,7 @@ Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
           type: vagrant_openshift_config['sync_folders_type'],
           nfs_udp: false # has issues when using NFS from within a docker container
       end
+      config.vm.synced_folder "~/openshift-devtools", "/scripts"

       if vagrant_openshift_config['private_network_ip']
         config.vm.network "private_network", ip: vagrant_openshift_config['private_network_ip']
```

## Usage

### Setting up a demo project

Use `vagrant ssh` to open a shell in your development virtual machine, use `tmux` to split your screen into two, one for the OpenShift server, and another one for general use:

```bash
tmux              # or `tmux a -t0` to continue from an existing session
```

Now type `ctrl+b` followed by `"` to split the screen horizontally.
Use `ctrl+b` and the arrow keys to move to the upper or lower screen.

In the lower screen, start the OpenShift server:

```bash
cd                # start the server at the working directory /home/vagrant
/scripts/0-start-openshift
```

Alternatively, you may want to start it with:

```bash
/scripts/0-start-openshift --latest-images
```

Now move to the upper screen, and, from the same directory that you started the
server, create a registry, a new project and image streams:

```bash
. /scripts/oc-up
```

That should leave your shell ready to work on the "demo" project.
You're ready to deploy new apps with `oc new-app`.

Note that you need a "." (or `source`) before the script path.


### Cleaning up

To remove all traces from the previous run of the server, run the cleanup script
from the same directory where you started the server.

I do this by going to the lower screen, killing the running server with `ctrl+c`
and then:

```bash
/scripts/cleanup
```

Alternatively, you might be fine with simply cleaning up your project:

```bash
oc -n demo delete all,pv,pvc --all
```

Or delete the project and create it again:

```bash
oc delete project demo
. /scripts/oc-up   # or /scripts/3-create-project
```
