import numpy as np
import matplotlib.pyplot as plt

def euler(f0, df, dt, tend, *param):
    f = [f0]
    t = [0]
    n = int(tend/dt)
    for i in range(n):
        f += [f[-1] + df(param,f[-1],t[-1])*dt]
        t += [t[-1] + dt]
    return [t,f]

def df(param, f, t):
    '''
    param = [power, mass, C, rho, A]
    '''
    return param[0]/(param[1]*f) - param[2] * param[3] * param[4] * f**2 / (2 * param[1])

def dfup(param, f, t):
    '''
    param = [power, mass, C, rho, A, g, grade]
    '''
    angle = np.arctan(param[6])
    return param[0]/(param[1]*f) - param[2] * param[3] * param[4] * f**2 / (2 * param[1]) - param[5] * np.sin(angle)

def dfdown(param, f, t):
    '''
    param = [power, mass, C, rho, A, g, grade]
    '''
    angle = np.arctan(param[6])
    return param[0]/(param[1]*f) - param[2] * param[3] * param[4] * f**2 / (2 * param[1]) + param[5] * np.sin(angle)

t, v = euler(4, df, 0.1, 200, 400, 70, 1, 1.225, 0.33)
tup, vup = euler(4, dfup, 0.1, 200, 400, 70, 1, 1.225, 0.33, 9.81, 0.1)
tdown, vdown = euler(4, dfdown, 0.1, 200, 400, 70, 1, 1.225, 0.33, 9.81, 0.1)

plt.plot(t, v, label = 'Flat')
plt.plot(tup, vup, label = 'Uphill with grade 10')
plt.plot(tdown, vdown, label = 'Downhill with grade 10')
plt.xlabel('Time, $t$ (s)')
plt.ylabel('Velocity, $v$ (m/s)')
plt.title('Bicycle velocity vs. time for uphill and downhill')
plt.tick_params(direction = 'in', right = True, top = True)
plt.legend()
plt.show()