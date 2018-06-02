import matplotlib.pyplot as plt
import numpy as np

def decay(n_uranium, t, tau, dt, total_time):
    # number of steps
    n = min(total_time/dt,100)
    for i in range(n):
        n_uranium += [n_uranium[-1] - (n_uranium[-1]/tau)*dt]
        t += [t[-1]+dt]
    return [t,n_uranium]

t5, n5 = decay([100],[0],1,0.5,100)
t2, n2 = decay([100],[0],1,0.2,100)
t05, n05 = decay([100],[0],1,0.05,100)

n_exact = 100*np.exp(-np.array(t05))

plt.plot(t5,n5, 'o')
plt.plot(t2,n2, 'o', markerfacecolor='none')
plt.plot(t05,n05, 's')
plt.plot(t05,n_exact, '-')
plt.axis([0,5,0,100])
plt.tick_params(top=True,right=True, direction='in')
plt.xlabel('time (s)')
plt.ylabel('Number of Nuclei')
plt.annotate('Time Constant = 1 s', xy=(2,80))
plt.title('Figure 1.2 Radioactive Decay')