function install_projs(root, deep, dry_run = false)

    ## ---------------------------------------------------------------------------------------------
    # Looking for projects
    cd(root)
    println("\n", "-" ^ 45)
    @info("Looking for projects", root)
    projs = find_projects(root)

    ## ---------------------------------------------------------------------------------------------
    # Install source projects
    pkgs_pool = Dict()
    let
        println("\n", "-" ^ 45)
        @info("Installing source projects", root)

        for proj_file in projs
            try
                # Install and update
                println("\n", "-" ^ 45)
                proj_file = relpath(proj_file, root)
                @info("Found on disk", proj_file)
                proj_file = joinpath(root, proj_file)

                # Collect devs
                pkgs = load_deps(proj_file)
                merge!(pkgs_pool, pkgs)

                # Installing
                if !dry_run 

                    # Temp env
                    proj_dir = tempenv(dirname(proj_file))
                    try
                        proj_file = joinpath(proj_dir, basename(proj_file))
                        Pkg.activate(proj_file)

                        for manf_name in Base.manifest_names
                            manf_file = joinpath(proj_dir, manf_name)
                            isfile(manf_file) && Pkg.instantiate()
                        end
                        Pkg.resolve()
                        Pkg.update()
                        Pkg.build()

                    finally
                        rm(proj_dir; force = true, recursive = true)
                    end
                end

            catch err
                @warn("ERROR", proj_file, err)
            end
        end
    end

    ## ---------------------------------------------------------------------------------------------
    # Install version range
    let
        pkgs_count = length(pkgs_pool)
        println("\n", "-" ^ 45)
        @info("Installing pkg versions", pkgs_count, deep)
        
        deep <= 0 && return
        for (uuidpkg, name) in pkgs_pool
            try
                versions = VersionNumber[]
                for path in findin_regs(name)
                    uuidfile = extract_uuid(path)
                    uuidpkg != uuidfile && continue
                    push!(versions, extract_versions.(path)...)
                end
                sort!(unique!(versions), rev = true)

                println("\n" ^ 3, "-" ^ 45)
                @info("Found in register", name, uuidpkg, length(versions))
                
                # Installing version range
                c = 0
                for version in versions 

                    c >= deep && break
                    c += 1

                    println("\n", "-" ^ 45)
                    @info("Installing", name, uuidpkg, version)
                    
                    if !dry_run
                        proj_dir = tempenv()
                        mkpath(proj_dir)
                        try
                            Pkg.activate(proj_dir)
                            pkg = Pkg.Types.PackageSpec(name, Base.UUID(uuidpkg), version)
                            Pkg.add(pkg)
                            Pkg.build()

                        catch err
                            @warn("ERROR", name, uuidpkg, version, err)
                        finally
                            rm(proj_dir; force = true, recursive = true)
                        end
                    end
                end
            catch err
                @warn("ERROR", name, uuidpkg, err)
            end
        end
    end
end

