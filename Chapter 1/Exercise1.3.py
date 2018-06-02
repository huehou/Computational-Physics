import matplotlib.pyplot as plt

def df(a,b,v):
    return a - b*v

def euler(f0, df, dt, tend):
    f = [f0]
    t = [0]
    n = int(tend/dt)
    a = 10
    b = 1
    for i in range(n):
        f += [f[-1] + df(a,b,f[-1])*dt]
        t += [t[-1] + dt]
    return [t,f]

t,v = euler(0, df, 0.1, 10)
plt.plot(t,v)
plt.xlabel('$t$')
plt.ylabel('$v(t)$')
plt.axis([0, 10, 0, 10.5])
plt.tick_params(top=True, right=True, direction ='in')
plt.title('Chapter 1 Exercise 1.3')