#g(m,n) = m(n(m,n),m(m,n))
#h(m,n) = n(m(n,n),n(m,m))
#k(m,n) = m(n(n(m,m)),n)

g(m,n) = (x,y)->m(n(x,y),y)
g(+,-)(3,2)

h(m,n) = n
k(m,n) = n

f(g,h,k) = g(h) + h(k) + k(g)

#f(g,h,k)(10)

