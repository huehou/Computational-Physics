import matplotlib.pyplot as plt

def df(param,f,t):
    return param[0]/(param[1]*f)

def euler(f0, df, dt, tend, *param):
    f = [f0]
    t = [0]
    n = int(tend/dt)
    for i in range(n):
        f += [f[-1] + df(param,f[-1],t[-1])*dt]
        t += [t[-1] + dt]
    return [t,f]

t,v = euler(4, df, 0.1, 200, 400,70)

plt.plot(t,v)
plt.tick_params(direction = 'in', top = True, right = True)
plt.axis([0, 200, 0, 50])
plt.title('Bicycling without air resistance')
plt.xlabel('time (s)')
plt.ylabel('velocity (m/s)')
plt.annotate('Velocity versus time', xy=(25,40), fontsize=12)
