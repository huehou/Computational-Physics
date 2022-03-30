import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

G_Ms = 4*np.pi**2
x0 = 1.0
y0 = 0.0
vx0 = 0.0
vy0 = 2*np.pi

def planet_1step(x0, y0, vx0, vy0, t0, dt):
    vx1 = vx0 - G_Ms*x0/(x0**2 + y0**2)**(3./2.)*dt
    x1 = x0 + vx1*dt
    vy1 = vy0 - G_Ms*y0/(x0**2 + y0**2)**(3./2.)*dt
    y1 = y0 + vy1*dt
    t1 = t0 + dt

    return (x1, y1, vx1, vy1, t1)

def planet(x0, y0, vx0, vy0, t, dt):
    steps = int(t/dt)

    x = np.zeros(steps+1)
    y = np.zeros(steps+1)
    vx = np.zeros(steps+1)
    vy = np.zeros(steps+1)
    t = np.zeros(steps+1)

    x[0] = x0
    y[0] = y0
    vx[0] = vx0
    vy[0] = vy0

    for i in range(steps):
        x[i+1], y[i+1], vx[i+1], vy[i+1], t[i+1] = planet_1step(x[i], y[i], vx[i], vy[i], t[i], dt) 

    return x, y, vx, vy, t

def main():
    x, y, vx, vy, t = planet(x0, y0, vx0, vy0, 1., 0.002)

    ax = plt.plot(x,y)
    plt.tick_params(direction = "in", top = True, right = True)
    plt.gca().set_aspect("equal")
    plt.xlim([-1,1])
    plt.ylim([-1,1])
    plt.xlabel("x (AU)")
    plt.ylabel("y (AU)")
    plt.title("Earth orbiting the Sun")
    plt.xticks(np.arange(-1,1.1,0.5))
    plt.yticks(np.arange(-1,1.1,0.5))
    # plt.savefig("Figure4.2.pdf", bbox_inches = "tight")


    # Bonus Animation pane
    fig, ax = plt.subplots()
    ln, = plt.plot([], [])
    ln2, = plt.plot([], [], "go", markersize = 5)

    def init():
        plt.xlim([-1,1])
        plt.ylim([-1,1])
        plt.tick_params(direction = "in", top = True, right = True)
        plt.xlabel("x (AU)")
        plt.ylabel("y (AU)")
        plt.title("Earth orbiting the Sun")
        plt.xticks(np.arange(-1,1.1,0.5))
        plt.yticks(np.arange(-1,1.1,0.5))
        plt.gca().set_aspect("equal")
        return ln,

    def update(frame):
        ln.set_data(x[:frame], y[:frame])
        ln2.set_data(x[frame], y[frame])
        return ln, ln2

    ani = FuncAnimation(fig, update, frames = len(t), init_func = init, blit = True, interval = 10, repeat = False)

    plt.show()

if __name__ == "__main__":
    main()


    
