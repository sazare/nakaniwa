# 高階関数の航海
# ((f,x)->f(x))((x)->+(x,1),3)

#==
#g(m,n) = m(n(m,n),m(m,n))
#h(m,n) = n(m(n,n),n(m,m))
#k(m,n) = m(n(n(m,m)),n)

g(m,n) = (x,y)->m(n(x,y),y)
g(+,-)(3,2)

h(m,n) = n
k(m,n) = n

f(g,h,k) = g(h) + h(k) + k(g)

#f(g,h,k)(10)
==#

# 練習

ppp(f)=(x,y)->f(x,y)
#==
>ppp(+)([2,3],[4,5])
2-element Array{Int64,1}:
 6
 8
==#

m(f,g) = f(g,g)

p(k,h) = (w)->map((x)->[k(x),h(x)],w)
q(x) = x+1
@show m(p,q)([1,2,3,4])

#==
julia> m(p,q)([1,2,3,4])
4-element Array{Array{Int64,1},1}:
 [2, 2]
 [3, 3]
 [4, 4]
 [5, 5]
==#

p2(k,h) = (w,v)->map((x,y)->[k(x),h(y)],w,v)
@show m(p2,q)([1,2,3],[4,5,6])
#==
### not so high
julia> include("higher1.jl")
3-element Array{Array{Int64,1},1}:
 [2, 5]
 [3, 6]
 [4, 7]
==#

# f do control, g make a compo

function p3(x,n)
 if x==0; return 0 
 else x+n(x-1,n) end
end

q3(x) = x+1
#==
julia> p3(4,p3)
10
==#

function p4(b,n)
 (x) -> (if b(x)==0; return 1 end; return b(x)+n(b,n)(x) )
end

q4(x) = x+1

#==
m4(f,g) = f(g,f)
@show m4(p4,q4)(5)
==#
#うまくできない
nn(f,x) = (y)->f(y+x)

#f(h,g,x)=(y)->[h(x,y),g(y)]

fa(ha,ga,x)=ha(fa,ga,x-1)

fb(f)=(x)->f(x(fb))
hb(g)=fb(hb)(g)

fc(h)=(x)->h(x(fc))
hb(f)=(x)->f(x)

fb(hb)(hb)

#==

julia> fb(hb)(fb)
#143 (generic function with 1 method)

julia> fb(hb)(fb)(hb)
#139 (generic function with 1 method)

==#

# recursionで関数を小さくしていくというのはあるか?
# one() < f1() < f2() <...
# 高いレベルで終わりが判定できなければ無限ループになるのだろうか

# たとえば、dec(f) という関数が、f()の高さを低くしていくとか・・・
# 関数列が定義できて、それをたどっていくという考え方。

## dec()という関数がなくて、マクロで関数を作っていくというのはあるはず。
#==
macro hig(f,x)
       :($f($x))
       end

==#

