import numpy as np
import matplotlib.pyplot as plt

angle = np.linspace(0, 360, 1000)
theta = np.deg2rad(angle)
f = 0.5 * (np.sin(4*theta) - 0.25 * np.sin(8*theta) + 0.08*np.sin(12*theta) - 0.025*np.sin(16*theta))

plt.plot(angle, f)
plt.xlabel("$\\theta$ (degrees)")
plt.ylabel("Lateral force / weight")
plt.xlim(0, 360)
plt.ylim(-1, 1)
plt.tick_params(direction = 'in', top = True, right = True)

plt.show()