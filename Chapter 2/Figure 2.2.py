import numpy as np
import matplotlib.pyplot as plt

def euler(df,f0,dt,T):
    n = int(T/dt)
    t = np.linspace(0,T,num=n+1,endpoint=True)
    dim = f0.shape[0]
    f = np.zeros((n+1,dim))
    f[0,:] = f0
    for i in range(n):
        f[i+1,:] = f[i,:] + df(f[i,:])*dt
    return [t,f]

def df(x):
    P = 400
    m = 70
    C = 1
    rho = 1.225
    A = 0.33
    v_nr = x[0]
    v_wr = x[1]
    dv_nr = P/m/v_nr
    dv_wr = P/m/v_wr - C*rho*A*v_wr**2/2/m
    return np.array([dv_nr,dv_wr])

t, v = euler(df, np.array([4,4]), 0.1, 200)

plt.plot(t, v[:,0], label = 'No air resistance')
plt.plot(t, v[:,1], '--', label = 'With air resistance')
plt.axis([0,200,0,50])
plt.tick_params(top=True, right=True, direction = 'in')
plt.legend()
plt.show()
