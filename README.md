# ansible-arch-bootstrap

Boilerplate to bootstrap and build an Arch Linux host with Ansible, driven with GNU make.

## Prerequisites

* ansible
* make

## Quick start

```bash
# Create inventory file
echo "example_host" > hosts

# Run bootstrap and build process
make bootstrap

# SSH to host
make ssh

# Run build --check and --diff
make check

# Run build again
make build
```

## Limit

Pass a limit parameter to restrict any make command to a limited set of Ansible hosts, e.g. `make bootstrap limit=webservers`. This just passes the parameter through to Ansible.

## Keys

The bootstrap process will create a key-pair then upload a key to your host(s), so as to allow frictionless use of the commands thereafter. If you do not want to use this then run `make remove-key` after bootstaping. A `.gitignore` is included to prevent generated keys from being accidentally committed to the repository.

## Utility commands

See the Makefile for a full listing of commands.

## Vagrant

If you running Arch inside a Vagrant VM, you may need to use the paramiko connection type to allow Ansible to communicate with the VM. You can pass this (or any parameter) in the form `make bootstrap param="-c paramiko"`

## License

MIT - see `LICENSE` file for full terms.
