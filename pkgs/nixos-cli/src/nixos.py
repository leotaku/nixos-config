import os
import click
import lib as lib

@click.group()
def cli():
    pass

@cli.command()
def update():
    config.update_modules()

@cli.command()
@click.argument('ref')
def checkout(ref):
    config.checkout(ref, silent=False)

@cli.command()
@click.argument('system')
@click.argument('cmd')
def run_as(system, cmd):
    config.run_as(system, cmd)

@cli.command()
@click.argument('mode')
def build(mode):
    cmd = "nixos-rebuild {0}".format(mode)
    config.run_as("main", cmd)

@cli.command()
@click.argument('system')
@click.option('-d', '--deployment', default=None)
def deploy(system, deployment):
    if not deployment: deployment = system
    cmd = "nixops deploy -d {0}".format(system)
    config.run_as(deployment, cmd)

nix_path = os.environ['NIX_PATH']
path = nix_path.split(":")[0]
external = os.path.join(path, "external")

with open(os.path.join(path, "nixos.yaml")) as fin:
    config = lib.ConfigObject(fin, external, "home-thinkpad")

if __name__ == '__main__':
    cli()
