import matplotlib.pyplot as plt

def df():
    return -9.8

def euler(f0, df, dt, tend):
    f = [f0]
    t = [0]
    n = int(tend/dt)
    for i in range(n):
        f += [f[-1] + df()*dt]
        t += [t[-1] + dt]
    return [t,f]

t,v = euler(0, df, 0.1, 10)
plt.plot(t,v)
plt.xlabel('$t$')
plt.ylabel('$v(t)$')
plt.axis([0, 10, -100, 0])
plt.tick_params(top=True, right=True, direction ='in')
plt.title('Chapter 1 Exercise 1.1')