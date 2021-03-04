using PkgMassInstaller
using Test

@testset "PkgMassInstaller.jl" begin

    JULIA_CMD = Base.julia_cmd()
    ROOT_DIR = pathof(PkgMassInstaller) |> dirname |> dirname
    PROJ_DIR = joinpath(ROOT_DIR, "Project.toml")
    SCRIPT_FILE = joinpath(ROOT_DIR, "scripts", "install.jl")
    @assert isfile(SCRIPT_FILE)

    @info("Dry Run, -deep = 0")
    run(`$JULIA_CMD --project=$PROJ_DIR -- $SCRIPT_FILE --dry-run -r$ROOT_DIR -d0`)
    @test true
    
    println("\n" ^ 3)
    @info("Dry Run, -deep = 10")
    run(`$JULIA_CMD --project=$PROJ_DIR -- $SCRIPT_FILE --dry-run -r$ROOT_DIR -d10`)
    @test true
    
    println("\n" ^ 3)
    @info("Real Run, -deep = 0")
    run(`$JULIA_CMD --project=$PROJ_DIR -- $SCRIPT_FILE -r$ROOT_DIR -d0`)
    @test true
    
    println("\n" ^ 3)
    @info("Real Run, -deep = 3")
    run(`$JULIA_CMD --project=$PROJ_DIR -- $SCRIPT_FILE -r$ROOT_DIR -d3`)
    @test true

end
