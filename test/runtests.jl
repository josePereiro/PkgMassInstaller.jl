using PkgMassInstaller
using Test

function try_remove_install_pkg(pkgname)
    for depot in DEPOT_PATH
        pkg_dir = joinpath(depot, "packages", pkgname)
        rm(pkg_dir; recursive = true, force = true)
    end
end

function count_installed_versions(pkgname)
    count = 0
    for depot in DEPOT_PATH
        pkg_dir = joinpath(depot, "packages", pkgname)
        !isdir(pkg_dir) && continue
        for dir in readdir(pkg_dir)
            ver_dir = joinpath(pkg_dir, dir)
            isdir(ver_dir) && (count += 1)
        end
    end
    count
end

@testset "PkgMassInstaller.jl" begin

    proj_dir = @__DIR__

    pkgname = "Example"
    try_remove_install_pkg(pkgname)
    
    println("\n" ^ 3)
    @info("Real Run, -deep = 3")
    deep = 3
    dry_run = false
    PkgMassInstaller.install_projs(proj_dir, deep, dry_run)
    count = count_installed_versions(pkgname)
    @test count >= deep

end
