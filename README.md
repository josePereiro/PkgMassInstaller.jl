[![Build status](https://github.com/josePereiro/PkgMassInstaller.jl/workflows/CI/badge.svg)](https://github.com/josePereiro/PkgMassInstaller.jl/actions)

# PkgMassInstaller
Export a function (`install_projs.jl`) that install julia packages from a set of `Project.toml`. 
It search projects within a given root folder and collect then (It will ignore .git folders). 
After that, it will installs/activates/updates/build them. 
Finally, it will install different versions of all explicit deps specified in all `Project.toml`s.
All the work is done in temporal enviroments, so the script have no effects on any enviroment.

It is usefull when you a have not full time internet access and wants to make sure all (and more) is install and build.

# Installation
```$ julia -e 'import Pkg; Pkg.add("https://github.com/josePereiro/PkgMassInstaller.jl")'```

# Usage

NOTE: You must first add all required [Registries](https://julialang.github.io/Pkg.jl/v1.1/registries/#Adding-registries-1).

```bash
$ julia -e 'using PkgMassInstaller; install_projs(#=root=# "root/path", #=deep=# 0, #=dry-run=# false)'
```

where
```
  root:       The root folder for searching projects. (default: ".")
  deep:       defines how many extra version of each pkg to install, from newer to older. 
  dry-run:    Run without consequences.
```

NCheck the script folder for a script.jl version of  install_projs.


