using PkgMassInstaller
using Test

@testset "PkgMassInstaller.jl" begin

    proj_dir = pathof(PkgMassInstaller) |> dirname |> dirname

    @info("Dry Run, -deep = 0")
    deep = 0
    dry_run = true
    PkgMassInstaller.install_projs(proj_dir, deep, dry_run)
    @test true
    
    println("\n" ^ 3)
    @info("Dry Run, -deep = 10")
    deep = 10
    PkgMassInstaller.install_projs(proj_dir, deep, dry_run)
    @test true
    
    println("\n" ^ 3)
    @info("Real Run, -deep = 0")
    deep = 0
    dry_run = false
    PkgMassInstaller.install_projs(proj_dir, deep, dry_run)
    @test true

    println("\n" ^ 3)
    @info("Real Run, -deep = 3")
    deep = 3
    dry_run = false
    PkgMassInstaller.install_projs(proj_dir, deep, dry_run)
    @test true

end
