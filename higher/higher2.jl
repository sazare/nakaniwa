# 高階関数の航海2

#準備
using Test

#product of functions
p(f,g) = (xs,ys)->map((x,y)->(f(x),g(y)), xs,ys)

succ(x)=x+1
desc(x)=x-1

#==
2-element Array{Tuple{Int64,Int64},1}:
 (2, 2)
 (3, 3)
==#
@test p(succ,desc)([1,2],[3,4]) == [(2,2),(3,3)]

####

## このxは関数をとってくるので、関数を引数にとる関数を作る関数がfb(f)

fb(f)=(x)->f(x(fb))

## そこでhb自身が自分を呼び出すようにしてみたのがこれ。
hb(g)=fb(hb)(g)


#fb(hb)(hb) # infinite loop maybe

#==

julia> fb(hb)(fb)
#143 (generic function with 1 method)

julia> fb(hb)(fb)(hb)
#139 (generic function with 1 method)

==#

#上のはよくわからないので、すこし単純なものにしてみた。


fc(h)=(x)->h(x(fc))
hc(f)=(x)->f(x)

#fc(hc)(hc)

## とまらないのを作るのはできるわけだけど
## 意味のありそうなものをつくるのが大変か。


