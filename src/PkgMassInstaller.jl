module PkgMassInstaller

import Pkg
import Pkg.TOML

export install_projs

include("utils.jl")
include("install_projs.jl")

end
