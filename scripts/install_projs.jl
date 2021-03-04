CURR_PROJ = Base.current_project()

# ---------------------------------------------------------------------------------------------
import Pkg
Pkg.activate(CURR_PROJ)

# ---------------------------------------------------------------------------------------------
# Parsing ARGS

try; @eval import ArgParse
catch 
    Pkg.add("ArgParse")
    @eval import ArgParse
end
const AP = ArgParse

argset = AP.ArgParseSettings()
AP.@add_arg_table! argset begin
    "--deep", "-d"
        help = "define how many extra version of each pkg to install, " * 
                "from newer to older."
        arg_type = Int
        default = 0
    "--root", "-r"
        help = "The root folder for searching projects."
        arg_type = String
        default = "."
    "--dry-run", "-y"
        help = "Run without consequences."
        action = :store_true
end

if isinteractive()
    # Dev values
    deep = 0
    dry_run = true
    root = abspath(".")
else
    parsed_args = AP.parse_args(ARGS, argset)
    deep = parsed_args["deep"]
    dry_run = parsed_args["dry-run"]
    root = abspath(parsed_args["root"])
end

## ---------------------------------------------------------------------------------------------
using PkgMassInstaller
install_projs(root, deep, dry_run)

