#!/usr/bin/env python3
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import re, sys

LOG_FILE = sys.argv[1] if len(sys.argv) > 1 else 'th_stokes.log'

def strip_ansi(s):
    return re.sub(r'\x1b\[[0-9;]*m', '', s)

def parse_log():
    iters, x, y, z, p, tke, tked = [], [], [], [], [], [], []
    current = {}
    try:
        with open(LOG_FILE, 'r') as f:
            for raw_line in f:
                line = strip_ansi(raw_line)
                m = re.search(r'Iteration (\d+) Initial residual', line)
                if m:
                    current = {'iter': int(m.group(1))}
                m = re.search(r'Momentum equation: Component 1 ([\d.e+\-]+)', line)
                if m: current['x'] = float(m.group(1))
                m = re.search(r'Momentum equation: Component 2 ([\d.e+\-]+)', line)
                if m: current['y'] = float(m.group(1))
                m = re.search(r'Momentum equation: Component 3 ([\d.e+\-]+)', line)
                if m: current['z'] = float(m.group(1))
                m = re.search(r'Pressure equation: ([\d.e+\-]+)', line)
                if m and 'iter' in current and 'x' in current:
                    current['p'] = float(m.group(1))
                m = re.search(r'TKE_system ([\d.e+\-]+)', line)
                if m and 'iter' in current:
                    current['tke'] = float(m.group(1))
                m = re.search(r'TKED_system ([\d.e+\-]+)', line)
                if m and 'iter' in current and 'p' in current:
                    current['tked'] = float(m.group(1))
                    iters.append(current['iter'])
                    x.append(current.get('x', 0))
                    y.append(current.get('y', 0))
                    z.append(current.get('z', 0))
                    p.append(current.get('p', 0))
                    tke.append(current.get('tke', 0))
                    tked.append(current['tked'])
                    current = {}
    except FileNotFoundError:
        pass
    return iters, x, y, z, p, tke, tked

fig, (ax1, ax2, ax3) = plt.subplots(3, 1, figsize=(11, 10))

def update(frame):
    iters, x, y, z, p, tke, tked = parse_log()
    if len(iters) < 2:
        return
    ax1.cla(); ax2.cla(); ax3.cla()
    ax1.semilogy(iters, x, label='vel_x', color='blue', linewidth=1.2)
    ax1.semilogy(iters, y, label='vel_y', color='red', linewidth=1.2)
    ax1.semilogy(iters, z, label='vel_z', color='green', linewidth=1.2)
    ax1.axhline(1e-8, color='gray', linestyle='--', label='target 1e-8')
    ax1.set_ylabel('Momentum Residual')
    ax1.set_title(f'{LOG_FILE} | iter:{iters[-1]} | x={x[-1]:.2e} y={y[-1]:.2e} z={z[-1]:.2e}')
    ax1.legend(loc='upper right'); ax1.grid(True, alpha=0.4)
    ax2.semilogy(iters, p, label='pressure', color='purple', linewidth=1.2)
    ax2.axhline(1e-8, color='gray', linestyle='--', label='target 1e-8')
    ax2.set_ylabel('Pressure Residual')
    ax2.set_title(f'pressure={p[-1]:.2e}')
    ax2.legend(loc='upper right'); ax2.grid(True, alpha=0.4)
    ax3.semilogy(iters, tke, label='TKE', color='orange', linewidth=1.2)
    ax3.semilogy(iters, tked, label='TKED', color='brown', linewidth=1.2)
    ax3.axhline(1e-8, color='gray', linestyle='--', label='target 1e-8')
    ax3.set_ylabel('Turbulence Residual')
    ax3.set_title(f'TKE={tke[-1]:.2e}  TKED={tked[-1]:.2e}')
    ax3.set_xlabel('Iteration')
    ax3.legend(loc='upper right'); ax3.grid(True, alpha=0.4)
    fig.tight_layout()

ani = animation.FuncAnimation(fig, update, interval=3000, cache_frame_data=False)
plt.show()