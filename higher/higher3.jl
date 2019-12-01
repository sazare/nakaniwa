# higher function trial 3

# if f is a closure, simpler
# i use throw for exit/skip of loopf
# loopf is for abstraction of loop

function loop(loopf, f)
  (x) -> begin
    try 
      f(x)
      loopf(loopf,f)(x-1)
    catch(e)
      println(e.mes)
    end
  end
end

struct Finish
  mes::String
end

function doom(x)
  if x >0
    println(x)
  else
    throw(Finish("finish"))
  end
end


loop(loop, doom)(3)

##### more higher
# can I make function from function in general way?

function decl(f)
  if f==zero; return 0 
  elseif f==one; return zero 
  else return one end
  println(f(x))
  return (x)->decl(f)
end

step(x) = println(x)

#==
function looper(step, looper)
  (x)->begin
        step(x)
        looper(step, looper)
       end
end
==#

# step is a function in a step
# cntf in 3rd arg is just a counter
# looper in 2nd arg is for loop

# the if in looper2 cah be change to throw
function looper2(step, looper, cntf)
  (x)->begin
        if x<0; return end
        step(x)
        looper(step, looper, decl(cntf))(x-1)
       end
end

#looper2(step, looper2, looper2)

# では、関数のdeclimentとは何か?


# groundでの引数の個数が制御するようなの
# 生成された関数が引数を1つずつ食べていくようなの
# 食べ飽きたら、続きをする関数を返す

struct Fail
  mes::String
end

function eater(s,e)
  (x)->begin
       if x!=nothing
         s(x)
       end
       return(e(s,e))
       end
end

stepper(x)=println(x)

#==
julia> eater(stepper, eater)(1)(4)(5)
1
4
5
#63 (generic function with 1 method)

#この63に意味があるのか??
==#

# simplify that
# とりあえず引数の数で制御するのは、こういうこと。
# ループの制御が引数の数であり、値ではない。

function eater2(s)
  (x)->begin
       if x!=nothing
         s(x)
       end
       return(eater2(s))
       end
end
#eater2(stepper, eater)(1)(4)(5)


#==
プログラム言語は構成的なので、抽象化によって関数を作るしかなく
それ故に、自由な高階関数ができないのかも。

抽象化でなければ、関数の張り合わせという手はないのか??


==#

function eva(s,n)
  if n==0; return (x)->s(x) end
  println(n-1)
  return (x)->(eva(s,n-1)(x))
end

s(x)=println(x)

#eva(s, 2)
#==
julia> eva(s,5)(3)
4
3
2
1
0
3
#こんなものを作りたいわけではなかった
==#
function eva2(s,n)
  if n==0; return (x)->s(x) 
  else
    println(n-1)
    return (x)->(eva(s,n-1)(x))
  end
end

#==
# 意図とは違う
# これだとff(x,y)のx,yは消えてしまい、ただ関数だけが残る。
julia> ff(x,y)=(x)->(y)->x+y
ff (generic function with 1 method)

julia> ff(1,2)
#53 (generic function with 1 method)

# 正しい
julia> hh=(x)->(y)->x+y
#69 (generic function with 1 method)

julia> hh(2)(3)
5
==#

