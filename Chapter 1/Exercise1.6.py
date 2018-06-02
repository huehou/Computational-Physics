import matplotlib.pyplot as plt

def df(a,b,n):
    return a*n - b*n**2

def euler(f0, df, dt, tend):
    f = [f0]
    t = [0]
    n = int(tend/dt)
    a = 10
    b = 0.03
    for i in range(n):
        f += [f[-1] + df(a,b,f[-1])*dt]
        t += [t[-1] + dt]
    return [t,f]

t,n = euler(10, df, 0.05, 2)

plt.plot(t,n)
plt.xlabel('$t$')
plt.ylabel('$N(t)$')
plt.title('Chapter 1 Exercise 1.6')
plt.tick_params(top=True, right=True, direction = 'in')
plt.axis([0,2,0,350])
