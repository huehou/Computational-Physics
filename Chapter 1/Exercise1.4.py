import matplotlib.pyplot as plt

NA = [100]
NB = [100]
t = [0]
tauA = 1
tauB = 3
dt = 0.05
tend = 10
n = int(tend/dt)

for i in range(n):
    NA += [NA[-1] - NA[-1]/tauA*dt]
    NB += [NB[-1] + (NA[-2]/tauA-NB[-1]/tauB)*dt]
    t += [t[-1]+dt]

plt.plot(t, NA, label = '$N_A$')
plt.plot(t, NB, label = '$N_B$')
plt.xlabel('$t$')
plt.ylabel('$N(t)$')
plt.title('Chapter 1 Exercise 1.4')
plt.tick_params(top=True, right=True, direction = 'in')
plt.legend()