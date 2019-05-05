import numpy as np
import matplotlib.pyplot as plt

x0 = 0
y0 = 1
z0 = 0
x = [x0]
y = [y0]
z = [z0]
vx = 31.3                           
vy = 0
vz = 0
v = np.sqrt(vx**2 + vy**2 + vz**2)

dt = 0.01
vd = 35
Delta = 5
g = 9.81
s0 = 4.1e-4
omega = -30*2*np.pi

def b2(v):
    return 0.0039 + 0.0058/(1 + np.exp((v-vd)/Delta))

while y[-1] >= -0.7:
    x += [x[-1] + vx*dt]
    y += [y[-1] + vy*dt]
    z += [z[-1] + vz*dt]
    vz = vz - s0*vx*omega*dt
    vy = vy - g*dt
    vx = vx - b2(v)*v*vx*dt
    v = np.sqrt(vx**2 + vy**2 + vz**2)
    
x = np.array(x)*3.28084
y = np.array(y)*3.28084
z = np.array(z)*3.28084

line = np.linspace(-3, 3.5, 100)
pitch = np.zeros(line.size)
plate = np.ones(line.size) * 60

plt.plot(x, y, ':')
plt.plot(x, z)
plt.plot(pitch, line, 'k--')
plt.plot(plate, line, 'k--')
plt.xlim((-10,70))
plt.ylim((-4,4))
plt.tick_params(direction = 'in', top = True, right = True)
plt.xlabel("$x$ (feet)")
plt.ylabel("$y$ or $z$ (feet)")
plt.title("Sidearm curve ball")

plt.annotate(s = '', xy = (30, 2), xytext = (35, 2.5), arrowprops = dict(arrowstyle = '->'))
plt.annotate(s = '', xy = (25, 0.2), xytext = (20, -0.5), arrowprops = dict(arrowstyle = '->', connectionstyle = 'arc3,rad=.2'))
plt.annotate(s = '', xy = (0.1, -1.9), xytext = (5, -2.5), arrowprops = dict(arrowstyle = '->', connectionstyle = 'arc3,rad=.2'))
plt.annotate(s = '', xy = (59.9, -2.3), xytext = (50, -2.5), arrowprops = dict(arrowstyle = '->', connectionstyle = 'arc3,rad=-.2'))

plt.text(28, 2.6, "vertical deflection ($y$)")
plt.text(5, -0.8, "horizontal deflection ($z$)")
plt.text(2, -2.8, "pitcher")
plt.text(43, -2.8, "home plate")


plt.show()