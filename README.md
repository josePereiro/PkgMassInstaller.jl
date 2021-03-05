[![Build status](https://github.com/josePereiro/PkgMassInstaller.jl/workflows/CI/badge.svg)](https://github.com/josePereiro/PkgMassInstaller.jl/actions)

# PkgMassInstaller
Export a function (`install_projs.jl`) that install julia packages from a set of `Project.toml`. 
It search projects within a given root folder and collect then (It will ignore .git folders). 
After that, it will installs/activates/updates/build them. 
Finally, it will install different versions of all explicit deps specified in all `Project.toml`s.
All the work is done in temporal environments, so the script have no effects on any environments.

It is usefull when you a have not full time internet access and wants to make sure all (and more) is installed and built.

# Installation
```console
$ julia -e 'import Pkg; Pkg.add(Pkg.PackageSpec(;url=\"https://github.com/josePereiro/PkgMassInstaller.jl\"))'
```

# Usage

NOTE: You must first add all required [Registries](https://julialang.github.io/Pkg.jl/v1.1/registries/#Adding-registries-1).

The function `install_projs` provide all functionalities.

```console
$ julia -e 'using PkgMassInstaller; install_projs(#=root=# "root/path", #=deep=# 0, #=dry-run=# false)'
```

where
```console
  root:       The root folder for searching projects. (default: ".")
  deep:       defines how many extra version of each pkg to install, from newer to older. 
  dry-run:    Run without consequences.
```

On the other hand, one can pass CLI arguments using the function `install_projs_args` (the extra `--` is necessary ).

```console
$ julia -e 'using PkgMassInstaller; install_projs_args()' -- --root="."
```

It is useful to define an alias

```console
$ alias jl_pkginstaller='julia -e "try; @eval(using PkgMassInstaller);catch err; @eval(import Pkg); Pkg.add(Pkg.PackageSpec(;url=\"https://github.com/josePereiro/PkgMassInstaller.jl\")); @eval(using PkgMassInstaller) end; install_projs_args()" --'
```

```console
$ jl_pkginstaller --help
usage: <PROGRAM> [-d DEEP] [-r ROOT] [-y] [-h]

optional arguments:
  -d, --deep DEEP  define how many extra version of each pkg to
                   install, from newer to older. (type: Int64,
                   default: 0)
  -r, --root ROOT  The root folder for searching projects. (default: ".")
  -y, --dry-run    Run without consequences.
  -h, --help       show this help message and exit
```


