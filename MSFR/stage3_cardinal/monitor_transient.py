#!/usr/bin/env python3
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import re, sys

LOG_FILE = sys.argv[1] if len(sys.argv) > 1 else 'th_transient_coldstart.log'

def parse_log():
    steps, nl_iters, nl_res = [], [], []
    current_step = 0
    nl_count = 0
    try:
        with open(LOG_FILE, 'r') as f:
            for line in f:
                line = re.sub(r'\x1b\[[0-9;]*m', '', line)
                m = re.search(r'Time Step (\d+),', line)
                if m:
                    current_step = int(m.group(1))
                    nl_count = 0
                m = re.search(r'^\s*(\d+) Nonlinear \|R\| = ([\d.e+\-]+)', line)
                if m:
                    nl_count = int(m.group(1))
                    val = float(m.group(2))
                    steps.append(current_step)
                    nl_iters.append(nl_count)
                    nl_res.append(val)
    except FileNotFoundError:
        pass
    return steps, nl_iters, nl_res

fig, ax = plt.subplots(figsize=(11, 5))

def update(frame):
    steps, nl_iters, nl_res = parse_log()
    if len(nl_res) < 2:
        return
    ax.cla()
    ax.semilogy(nl_res, color='blue', linewidth=1.2, label='Nonlinear |R|')
    ax.axhline(1e-6, color='gray', linestyle='--', label='target 1e-6')
    ax.set_ylabel('Nonlinear Residual')
    ax.set_xlabel('Newton iteration (累計)')
    ax.set_title(f'{LOG_FILE} | Step {steps[-1]} | NL iter {nl_iters[-1]} | R={nl_res[-1]:.3e}')
    ax.legend(); ax.grid(True, alpha=0.4)
    fig.tight_layout()

ani = animation.FuncAnimation(fig, update, interval=3000, cache_frame_data=False)
plt.show()
