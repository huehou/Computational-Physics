import matplotlib.pyplot as plt

def df1(param,f,t):
    return param[0]/(param[1]*f)

def df2(param, f, t):
    return param[0]/(param[1]*f) - param[2] * param[3] * param[4] * f**2 / (2 * param[1]) 

def euler(f0, df, dt, tend, *param):
    f = [f0]
    t = [0]
    n = int(tend/dt)
    for i in range(n):
        f += [f[-1] + df(param,f[-1],t[-1])*dt]
        t += [t[-1] + dt]
    return [t,f]

t1,v1 = euler(4, df1, 0.1, 200, 400, 70) #(param = [power, mass])
t2,v2 = euler(4, df2, 0.1, 200, 400, 70, 1, 1.225, 0.33) # param = [power, mass, C, rho, A]

plt.plot(t1,v1)
plt.plot(t2,v2,':')
plt.tick_params(direction = 'in', top = True, right = True)
plt.axis([0, 200, 0, 50])
plt.title('Bicycle simulation: velocity vs. time')
plt.xlabel('time (s)')
plt.ylabel('velocity (m/s)')
plt.annotate('No air resistance', xy=(10,35), fontsize=12)
plt.annotate('With air resistance', xy=(75,8), fontsize=12)
