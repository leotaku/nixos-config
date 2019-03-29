import sys
import yaml as pyyaml
from git import Repo
from git.remote import RemoteProgress
from os.path import join
import os

def lineprint(string):
    sys.stdout.flush()
    sys.stdout.write(u"\u001b[1000D" + " "*100)
    sys.stdout.write(u"\u001b[1000D" + string)
    sys.stdout.flush()
    sys.stdout.write(u"\u001b[1000D")

class Progress(RemoteProgress):
    def update(self, op_code, cur_count, max_count=None, message=''):
        lineprint(self._cur_line)

class Module():
    def __init__(self, path, sources):
        try: 
            self.repo = Repo(path)
            assert not repo.bare
        except:
            self.repo = Repo.init(path)
        self.sources = sources
        self._addRemotes()

    def _addRemotes(self):
        repo = self.repo
        for name, url in self.sources.items():
            if not hasattr(repo.remotes, name):
                repo.create_remote(name, url)
            elif not repo.remotes[name].url == url:
                repo.remotes[name].set_url(old_url=url, new_url=repo.remotes[name].url)

    def update(self):
        for robj in self.repo.remotes:
            robj.fetch()

    def checkout(self, ref):
        self.repo.git.checkout(ref)

class Deployment():
    def __init__(self, modules, modulerefs):
        self.checkouts = {}
        for name, value in modulerefs.items():
            self.checkouts[name] = { "ref": value, "module": modules[name] }

            
class ConfigObject():
    def __init__(self, file, path, main_name):
        yaml = pyyaml.load(file)
        self.path = path
        self.modules = {}
        for name, module in yaml["modules"].items():
            repopath = join(path, name)
            self.modules[name] = Module(repopath, module["sources"])

        self.deployments = {}
        for name, value in yaml["deployments"].items():
            depl = Deployment(self.modules, value["modules"])
            self.deployments[name] = depl
            if "main" in value and value["main"]:
                self.deployments["main"] = depl

    def update_modules(self):
        for name, module in self.modules.items():
            lineprint("Updating: " + name )
            module.update()
        
        self.checkout("main")
        self.show_refs()

        print("\nThis system is terrible and you should feel bad for writing it.")

    def get_refs(self):
        result = []
        for name, module in self.modules.items():
            ref = module.repo.git.rev_parse("HEAD")
            result.append((name, ref))

        return result;

    def show_refs(self):
        for (name, ref) in self.get_refs():
            print(name + ":" + (" "*(20-len(name)))  +  ref)
    
    def checkout(self, depl_name, silent=True):
        depl = self.deployments[depl_name]
        for name, checkout in depl.checkouts.items():
            module, ref = checkout["module"], checkout["ref"]
            if not silent: print("Checking out '{0}' on '{1}'".format(ref, name))
            module.checkout(ref)

    def run_as(self, depl_name, cmd):
        try:
            self.checkout(depl_name)
            os.system(cmd)
        finally:
            self.checkout("main")

#with open("./nixos.toml") as fin:
#    config = ConfigObject(fin, ".")
