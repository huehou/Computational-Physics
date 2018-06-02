import matplotlib.pyplot as plt
import numpy as np

def decay(n_uranium, t, tau, dt, total_time):
    # number of steps
    n = min(total_time/dt,100)
    for i in range(n):
        n_uranium += [n_uranium[-1] - (n_uranium[-1]/tau)*dt]
        t += [t[-1]+dt]
    return [t,n_uranium]

t, n_uranium = decay([100],[0],1,0.05,100)

n_exact = 100*np.exp(-np.array(t))

plt.plot(t,n_uranium,'.', t, n_exact, '-')
plt.axis([0,5,0,100])
plt.tick_params(top=True,right=True, direction='in')
plt.xlabel('time (s)')
plt.ylabel('Number of Nuclei')
plt.annotate('Time Constant = 1 s', xy=(2,80))
plt.annotate('Time Step = 0.05 s', xy=(2,70))
plt.title('Radioactive Decay')