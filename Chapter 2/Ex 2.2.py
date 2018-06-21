import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize

def euler(df,f0,dt,T):
    n = int(T/dt)
    t = np.linspace(0,T,num=n+1,endpoint=True)
    dim = f0.shape[0]
    f = np.zeros((n+1,dim))
    f[0,:] = f0
    for i in range(n):
        f[i+1,:] = f[i,:] + df(f[i,:])*dt
    return [t,f]

def dfP(x,P):
    m = 70
    C = 1
    rho = 1.225
    A = 0.33*0.7
    v_wr = x[0]
    dv_wr = P/m/v_wr - C*rho*A*v_wr**2/2/m
    return np.array([dv_wr])

def dv_terminal(P):
    def df(x):
        return dfP(x,P)
    t, v = euler(df, np.array([4]), 0.1, 200)
    return v[-1,0]-12.5549

P_required = optimize.newton(dv_terminal, 400)
print('P_new/P_old is '+str(P_required/400))
