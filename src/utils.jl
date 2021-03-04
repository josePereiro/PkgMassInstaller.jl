# Tools
function load_deps(proj_file)
    raw_deps = get(TOML.parsefile(proj_file), "deps", Dict())
    deps = Dict()
    for (name, uuid) in raw_deps
        deps[uuid] = name
    end
    deps
end

function find_projects(root = ".")
    projs = String[]
    c = 1
    root = abspath(root)

    # Look in root
    for projname in Base.project_names
        projfile = joinpath(root, projname)
        !isfile(projfile) && continue
        push!(projs, projfile)
        println(c, ": ", relpath(projfile, root))
        c += 1
    end

    # walk root
    for (dir, subdirs, _) in walkdir(root)
        for subdir in subdirs, projname in Base.project_names
            try
                projfile = joinpath(dir, subdir, projname)
                !isfile(projfile) && continue

                # ignores
                occursin("/.git/", projfile) && continue

                push!(projs, projfile)
                println(c, ": ", relpath(projfile, root))
                c += 1
            catch err; end
        end
    end
    projs
end

# Find package in registers
function findin_regs(name, uuidpkg)
    firstletter = string(first(name))
    founds = []
    for depot in DEPOT_PATH
        regs_root = joinpath(depot, "registries")
        !isdir(regs_root) && continue
        for reg in readdir(regs_root)
            reg_pkgdir = joinpath(regs_root, reg, firstletter, name)
            !isdir(reg_pkgdir) && continue

            # Check uuid
            pkg_toml = joinpath(reg_pkgdir, "Package.toml")
            !isfile(pkg_toml) && continue
            uuidfile = get(TOML.parsefile(pkg_toml), "uuid", "NOT_A_UUID")
            uuidfile != uuidpkg && continue

            push!(founds, reg_pkgdir)
        end
    end
    founds
end

function extract_versions(regpath)
    ctx = Pkg.Types.Context()
    di=Pkg.Operations.load_versions(ctx, regpath)
    keys(di) |> collect
end

function extract_uuid(regpath)
    pkg_file = joinpath(regpath, "Package.toml")
    dat = TOML.parsefile(pkg_file)
    return dat["uuid"]
end

function tempenv() 
    temp_proj_dir = joinpath(tempdir(), string(rand(UInt)))
    mkpath(temp_proj_dir)
    return temp_proj_dir
end

function tempenv(proj_dir)
    temp_proj_dir = tempenv()
    for file_names in [Base.project_names, Base.manifest_names]
        for file_name in file_names
            file = joinpath(file_name, proj_dir)
            !isfile(file) && continue
            cp(file, temp_proj_dir; force = true, follow_symlinks = true)
        end
    end
    return temp_proj_dir
end