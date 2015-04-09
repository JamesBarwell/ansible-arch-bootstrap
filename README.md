# ansible-arch-bootstrap

Boilerplate to bootstrap and build an Arch Linux host with Ansible, driven with GNU make.

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

Pass a limit parameter to restrict any make command, e.g. `make bootstrap limit=webservers`.

## Keys

The bootstrap process will create a key-pair and upload a key to your host(s), to allow frictionless use of the commands. If you do not want to use this then run `make remove-key` after the bootstap has run. A .gitignore is included to prevent keys being accidentally committed to the repository.

## Utility commands

See the Makefile for a full listing of commands.

## Vagrant

If you running Arch inside a Vagrant VM, you may need to use the paramiko connection type to allow Ansible to communicate with the VM. You can pass this (or any parameter) in the form `make bootstrap param="-c paramiko"`

## License

MIT - see `LICENSE` file.
