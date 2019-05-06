import numpy as np
import matplotlib.pyplot as plt

x0 = 0
y0 = 2
z0 = 0
x = [x0]
y = [y0]
z = [z0]
vx = 31.3                           
vy = 0.8
vz = 0
v = np.sqrt(vx**2 + vy**2 + vz**2)

dt = 0.01
vd = 35
Delta = 5
g = 9.81
s0 = 4.1e-4
omega = 30*2*np.pi

def b2(v):
    return 0.0039 + 0.0058/(1 + np.exp((v-vd)/Delta))

while x[-1] <= 17:
    x += [x[-1] + vx*dt]
    y += [y[-1] + vy*dt]
    z += [z[-1] + vz*dt]
    vz = vz 
    vy = vy - g*dt - s0*vx*omega*dt
    vx = vx - b2(v)*v*vx*dt
    v = np.sqrt(vx**2 + vy**2 + vz**2)
    
x = np.array(x)*3.28084
y = np.array(y)*3.28084
z = np.array(z)*3.28084

line1 = np.linspace(3.9, 7.5, 100)
pitch = np.zeros(line1.size)
line2 = np.linspace(0.5, 7.5, 100)
plate = np.ones(line2.size) * 60

plt.plot(x, y)

x0 = 0
y0 = 2
z0 = 0
x = [x0]
y = [y0]
z = [z0]
vx = 42.4688                           
vy = 0
vz = 0
v = np.sqrt(vx**2 + vy**2 + vz**2)

while x[-1] <= 17.7:
    x += [x[-1] + vx*dt]
    y += [y[-1] + vy*dt]
    z += [z[-1] + vz*dt]
    vz = vz 
    vy = vy - g*dt - s0*vx*omega*dt
    vx = vx - b2(v)*v*vx*dt
    v = np.sqrt(vx**2 + vy**2 + vz**2)
    
x = np.array(x)*3.28084
y = np.array(y)*3.28084
z = np.array(z)*3.28084

plt.plot(x, y, '-.')

x0 = 0
y0 = 2
z0 = 0
x = [x0]
y = [y0]
z = [z0]
vx = 31.3                           
vy = 0.8
vz = 0
v = np.sqrt(vx**2 + vy**2 + vz**2)
omega = 0

while x[-1] <= 17:
    x += [x[-1] + vx*dt]
    y += [y[-1] + vy*dt]
    z += [z[-1] + vz*dt]
    vz = vz 
    vy = vy - g*dt - s0*vx*omega*dt
    vx = vx - b2(v)*v*vx*dt
    v = np.sqrt(vx**2 + vy**2 + vz**2)
    
x = np.array(x)*3.28084
y = np.array(y)*3.28084
z = np.array(z)*3.28084

plt.plot(x, y, ':')

plt.plot(pitch, line1, 'k--')
plt.plot(plate, line2, 'k--')
plt.xlim((-10,70))
plt.ylim((0,8))
plt.tick_params(direction = 'in', top = True, right = True)
plt.xlabel("$x$ (feet)")
plt.ylabel("$y$ (feet)")
plt.title("Overhand curve ball")
plt.annotate(s = '', xy = (35, 5.6), xytext = (42, 6.5), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=-.2"))
plt.annotate(s = '', xy = (16, 6.2), xytext = (12, 5.5), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=-.2"))
plt.annotate(s = '', xy = (43, 3.8), xytext = (38, 2.8), arrowprops = dict(arrowstyle = '->', connectionstyle = "arc3,rad=-.2"))
plt.annotate(s = '', xy = (59.8, 1), xytext = (46, 0.8), arrowprops = dict(arrowstyle = '->'))
plt.annotate(s = '', xy = (0.3, 4.5), xytext = (3, 3.5), arrowprops = dict(arrowstyle = '->'))
plt.text(40, 6.5, "no spin")
plt.text(8, 5.2, "fastball")
plt.text(27, 2.4, "overhand curve")
plt.text(40, 0.5, "homeplate")
plt.text(-1, 3.2, "pitcher")

plt.show()