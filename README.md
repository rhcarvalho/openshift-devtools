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
machine. I do it by placing a file `.vagrant-openshift.json` in my Origin
checkout:

```json
{
  "sync_folders": {
    "~/openshift/src": {
      "to": "/data/src"
    },
    "~/openshift/src/github.com/rhcarvalho/openshift-devtools": {
      "to": "/scripts"
    }
  }
}
```

This file is loaded by the Vagrantfile in Origin, and is marked as ignored in
the `.gitignore` file, so you can drop it into your checkout and don't worry
about it messing up with your Git commits.

Note that I configure two sync points:

- The first puts the whole GOPATH workspace where I have my Origin checkout
  into `/data/src` (the default GOPATH in the virtual machine). I do that so
  that I can easily access the source for other projects, e.g.,
  source-to-image.
- The second sync point is the one with my scripts.

I'm currently keeping a branch with my modifications related to Vagrant in:
https://github.com/rhcarvalho/origin/commits/local/custom-vm


## Usage


### Setting up a demo project

Use `vagrant ssh` to open a shell in your development virtual machine, use
`tmux` to split your screen into two, one for the OpenShift server, and another
one for general use:

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
