## 参照: https://qiita.com/boxboxbax/items/337a898766f643b1ab91

function montepif(nums)
 xs = rand(nums)
 ys = rand(nums)

 incirc = 0

 for i in 1:nums
   if xs[i]*xs[i] + ys[i]*ys[i] < 1.0
     incirc += 1
   end
 end

 montepi = 4 * incirc / nums

 return montepi
end

function montepim(nums)
 xs = rand(nums)
 ys = rand(nums)

 incirc = 0

 map((x,y) -> begin
     if x*x + y*y <1;
       incirc += 1
     end
     end, xs, ys)

 montepi = 4 * incirc / nums

 return montepi
end

@info :for
@info 100000
GC.gc()
@time println(montepif(100000))
@info 1000000
GC.gc()
@time println(montepif(1000000))
@info 10000000
GC.gc()
@time println(montepif(10000000))
@info 100000000
GC.gc()
@time println(montepif(100000000))

@info map
@info 100000
GC.gc()
@time println(montepim(100000))
@info 1000000
GC.gc()
@time println(montepim(1000000))
@info 10000000
GC.gc()
@time println(montepim(10000000))
@info 100000000
GC.gc()
@time println(montepim(100000000))

