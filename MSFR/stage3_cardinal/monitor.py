#!/usr/bin/env python3
"""
SIMPLE 殘差即時監控工具
用法：python3 monitor.py [log檔名]
預設監控 th_stokes.log
"""
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import re
import sys

LOG_FILE = sys.argv[1] if len(sys.argv) > 1 else 'th_stokes.log'

def strip_ansi(s):
    return re.sub(r'\x1b\[[0-9;]*m', '', s)

def parse_log():
    iters, x, y, z, p = [], [], [], [], []
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
                    iters.append(current['iter'])
                    x.append(current.get('x', 0))
                    y.append(current.get('y', 0))
                    z.append(current.get('z', 0))
                    p.append(current['p'])
                    current = {}
    except FileNotFoundError:
        pass
    return iters, x, y, z, p

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(11, 8))

def update(frame):
    iters, x, y, z, p = parse_log()
    if len(iters) < 2:
        return
    ax1.cla(); ax2.cla()

    # 動量殘差
    ax1.semilogy(iters, x, label='vel_x', color='blue', linewidth=1.2)
    ax1.semilogy(iters, y, label='vel_y', color='red', linewidth=1.2)
    ax1.semilogy(iters, z, label='vel_z', color='green', linewidth=1.2)
    ax1.axhline(1e-8, color='gray', linestyle='--', label='target 1e-8')
    ax1.set_ylabel('Momentum Residual')
    ax1.set_title(f'{LOG_FILE}  |  iter: {iters[-1]}  |  '
                  f'x={x[-1]:.2e}  y={y[-1]:.2e}  z={z[-1]:.2e}')
    ax1.legend(loc='upper right'); ax1.grid(True, alpha=0.4)

    # 壓力殘差
    ax2.semilogy(iters, p, label='pressure', color='purple', linewidth=1.2)
    ax2.axhline(1e-8, color='gray', linestyle='--', label='target 1e-8')
    ax2.set_ylabel('Pressure Residual')
    ax2.set_title(f'pressure={p[-1]:.2e}')
    ax2.set_xlabel('Iteration')
    ax2.legend(loc='upper right'); ax2.grid(True, alpha=0.4)

    fig.tight_layout()

ani = animation.FuncAnimation(fig, update, interval=3000, cache_frame_data=False)
plt.show()