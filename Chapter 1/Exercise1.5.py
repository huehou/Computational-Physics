import matplotlib.pyplot as plt

NA = [100]
NB = [0]
t = [0]
tau = 1
dt = 0.05
tend = 10
n = int(tend/dt)

for i in range(n):
    NA += [NA[-1] + (NB[-1]/tau - NA[-1]/tau)*dt]
    NB += [NB[-1] + (NA[-2]/tau-NB[-1]/tau)*dt]
    t += [t[-1]+dt]

plt.plot(t, NA, label = '$N_A$')
plt.plot(t, NB, label = '$N_B$')
plt.xlabel('$t$')
plt.ylabel('$N(t)$')
plt.title('Chapter 1 Exercise 1.5')
plt.tick_params(top=True, right=True, direction = 'in')
plt.axis([0,10,0,100])
plt.legend()