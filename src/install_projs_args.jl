function install_projs_args()

    argset = ArgParse.ArgParseSettings()
    ArgParse.@add_arg_table! argset begin
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

    parsed_args = ArgParse.parse_args(ARGS, argset)
    deep = parsed_args["deep"]
    dry_run = parsed_args["dry-run"]
    root = abspath(parsed_args["root"])

    install_projs(root, deep, dry_run)
end