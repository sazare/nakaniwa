# simple ones
using Test

f(g) = g(f)
h(f) = g(f)
k(f) = (p)->f(k)(p)

function g(f)
  if g==f
    @show :same
  end
  k(f)(g)

end

# stack overflow
#g(k)(k)


k2(f) = (p)->f(k)(p)
function g2(f)
  if g2==f
    @show :same
  else
    k2(g2)(g2)
  end
end

# function decriments
k31(f) = f(k32)
k32(f) = f(k33)
k33(f) = f(f3)
f3(g) = (x)->g(x)

# f3(g)(k32) #for example

# f3(k31)(k32)(k33)(f3)

function g3(f)
  if g3==f
    return 0
  else
    return k31(f)(f)
  end
end

#@test g3(g3) == :same
# g3(k31)(k31)

@test f3(k31)(k32)(k33)(f3)(sqrt)(4)==2.0
@test 2.0==f3(sqrt)(4)


