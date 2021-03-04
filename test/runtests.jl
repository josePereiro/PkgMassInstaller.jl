using PkgMassInstaller
using Test

@testset "PkgMassInstaller.jl" begin

    JULIA_CMD = Base.julia_cmd()
    PROJ_DIR = pathof(PkgMassInstaller) |> dirname |> dirname
    SCRIPT_FILE = joinpath(PROJ_DIR, "scripts", "install.jl")
    @assert isfile(SCRIPT_FILE)

    # @info("Dry Run, -deep = 0")
    # run(`$JULIA_CMD $SCRIPT_FILE --dry-run -r $PROJ_DIR -d 0`)
    # @test true
    
    # println("\n" ^ 3)
    # @info("Dry Run, -deep = 10")
    # run(`$JULIA_CMD $SCRIPT_FILE --dry-run -r $PROJ_DIR -d 10`)
    # @test true
    
    # println("\n" ^ 3)
    # @info("Real Run, -deep = 0")
    # run(`$JULIA_CMD $SCRIPT_FILE -r $PROJ_DIR -d 0`)
    # @test true
    
    println("\n" ^ 3)
    @info("Real Run, -deep = 3")
    run(`$JULIA_CMD $SCRIPT_FILE -r $PROJ_DIR -d 3`)
    @test true

end
