module PkgMassInstaller

import Pkg
import Pkg.TOML
import ArgParse

export install_projs, install_projs_args

include("utils.jl")
include("install_projs.jl")
include("install_projs_args.jl")

end
