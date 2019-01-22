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

def df1(param, f, t):
    '''
    param = [power, mass, C, rho, A]
    '''
    return param[0]/(param[1]*f) - param[2] * param[3] * param[4] * f**2 / (2 * param[1])

def df2(param, f, t):
    '''
    param = [power, mass, C, rho, A, eta, h]
    '''
    return param[0]/(param[1]*f) - param[2] * param[3] * param[4] * f**2 / (2 * param[1]) - param[5]*param[4]*f/param[6]

# =============================================================================
# Air with Drag Force
# =============================================================================
t1, v1 = euler(4, df1, 0.1, 200, 400, 70, 1, 1.225, 0.33)
t2, v2 = euler(4, df2, 0.1, 200, 400, 70, 1, 1.225, 0.33, 2*10**(-5), 0.81)

plt.plot(t1, v1, label = 'without drag force')
plt.plot(t2, v2, 'k:', label = 'with drag force')
plt.tick_params(direction = 'in', right = True, top = True)
plt.legend()
plt.title('Graph of v vs t with and without drag force in air')

# =============================================================================
# Water with Drag Force
# =============================================================================
tend = 5
t1, v1 = euler(0.5, df1, 0.01, tend, 400, 70, 1, 997, 0.33)
t2, v2 = euler(0.5, df2, 0.01, tend, 400, 70, 1, 997, 0.33, 10**(-3), 0.81)

plt.figure()
plt.plot(t1, v1, label = 'without drag force')
plt.plot(t2, v2, ':', label = 'with drag force')
plt.tick_params(direction = 'in', right = True, top = True)
plt.legend()
plt.title('Graph of v vs t with and without drag force in water')
plt.show()