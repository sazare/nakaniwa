e=Meta.parse("f(x,y)")
dump(e)

e2=Meta.parse("f(g(x),a)")
e2

FTerm=Expr
Term=Union{Symbol, Expr}

VList = Array{Symbol, 1}
TList = Array{Term, 1}


using Test

isvar(ν::VList, e::Symbol) = e in ν 

isvar(ν::VList, e::Expr) = false

@testset "isvar(symbol)" begin
    @test isvar([:x,:y], :a) == false
    @test isvar([:x,:y], :x) == true
end

@testset "isvar(expr)" begin
    @test isvar([:x,:y], :(f(x,y))) == false
    @test isvar([:x,:y], :(f(g(x),y))) == false
end


#function subst(ν::VList, t::Symbol, σ::TList)
function subst(ν::VList, t::Symbol, σ::Array)
    map(function(ν, σ) t = subst0(ν, t, σ) end, ν, σ)
    t
end

function subst0(ν::Symbol, t::Symbol, σ::Term)
    if ν == t; return σ
        else return t
    end
end

#function subst(ν::VList, t::Expr, σ::TList)
function subst(ν::VList, t::Expr, σ::Array)
    map(function(ν, σ) t = subst0(ν, t, σ) end, ν, σ)
    t
end

function subst0(ν::Symbol, t::Expr, σ::Term)
    nargs = []
    for e in t.args
        push!(nargs, subst0(ν, e, σ))
    end
    t.args=nargs
    return t
end



@testset "subst0 on symbol" begin
    @test subst0(:a, :a, :a) == :a
    @test subst0(:b, :a, :a) == :a
    @test subst0(:a, :a, :b) == :b
    @test subst0(:a, :a, :(f(x))) == :(f(x))
end

@testset "subst on symbol" begin
    @test subst([:a], :a, [:a]) == :a
    @test subst([:b], :a, [:a]) == :a
    @test subst([:a], :a, [:b]) == :b
    @test subst([:a], :a, [:(f(x))]) == :(f(x))
end

@testset "subst0 on Expr" begin
    @test subst0(:a, :(f(x)), :a) == :(f(x))
    @test subst0(:a, :(f(x)), :b) == :(f(x))
    @test subst0(:x, :(f(x)), :a) == :(f(a))
    @test subst0(:y, :(f(x)), :(f(b))) == :(f(x))
    # the next is ng when this line was deleted???
    @test subst0(:x, :(f(x)), :(g(b))) == :(f(g(b)))

end

@testset "subst on Expr" begin
    @test subst([:a,:b], :(f(x)), [:a,:b]) == :(f(x))
    @test subst([:a,:b], :(f(x)), [:b,:c]) == :(f(x))
    @test subst([:x,:b], :(f(x)), [:a,:b]) == :(f(a))
    @test subst([:a,:x], :(f(x)), [:a,:b]) == :(f(b))
    @test subst([:x,:y], :(f(x,y)), [:d,:e]) == :(f(d,e))
    @test subst([:x,:y], :(f(x,y,z)), [:(g(b)),:y]) == :(f(g(b),y,z))
    @test subst([:x,:y], :(f(x,y,z)), [:(g(b)),:(h(d))]) == :(f(g(b),h(d),z))
    @test subst([:x,:y], :(f(x,z,y)), [:(g(b)),:(h(d))]) == :(f(g(b),z,h(d)))
end


