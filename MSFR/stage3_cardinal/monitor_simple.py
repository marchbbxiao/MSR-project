
import re, time, sys
import matplotlib
matplotlib.use("TkAgg")
import matplotlib.pyplot as plt

logfile = sys.argv[1] if len(sys.argv) > 1 else "th_phase1_from_th2.log"
plt.ion()
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8))
fig.suptitle("SIMPLE Convergence: " + logfile)

while True:
    iters, mom1, mom2, mom3, pres = [], [], [], [], []
    i = 0
    try:
        with open(logfile) as f:
            for line in f:
                if "Iteration" in line and "Initial" in line:
                    m = re.search(r"Iteration (\d+)", line)
                    if m:
                        i = int(m.group(1))
                elif "Component 1" in line:
                    mom1.append(float(line.split()[-1]))
                    iters.append(i)
                elif "Component 2" in line:
                    mom2.append(float(line.split()[-1]))
                elif "Component 3" in line:
                    mom3.append(float(line.split()[-1]))
                elif "Pressure equation" in line:
                    pres.append(float(line.split()[-1]))
    except:
        pass

    n = min(len(iters), len(mom1), len(mom2), len(mom3), len(pres))
    if n > 0:
        ax1.cla(); ax2.cla()
        x = list(range(1, n+1))
        ax1.semilogy(x, mom1[:n], "b-", label="Mom X", alpha=0.7)
        ax1.semilogy(x, mom2[:n], "g-", label="Mom Y", alpha=0.7)
        ax1.semilogy(x, mom3[:n], "r-", label="Mom Z", alpha=0.7)
        ax1.set_ylabel("Momentum Residual"); ax1.legend(); ax1.grid(True)
        ax1.set_title("Iter: " + str(iters[n-1]))
        ax2.semilogy(x, pres[:n], "k-", label="Pressure", alpha=0.8)
        ax2.set_ylabel("Pressure Residual"); ax2.set_xlabel("Iteration")
        ax2.legend(); ax2.grid(True)
        plt.tight_layout(); plt.pause(0.1)
    time.sleep(5)
