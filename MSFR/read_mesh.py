import netCDF4 as nc
import numpy as np
from collections import Counter

ds = nc.Dataset('/home/ubuntu/MSR-project/MSFR/msr.e')
x = ds.variables['coordx'][:]
y = ds.variables['coordy'][:]
z = ds.variables['coordz'][:]
connect = ds.variables['connect1'][:] - 1

# 找邊界面
tet_faces = []
for tet in connect:
    a, b, c, d = tet
    tet_faces.append(tuple(sorted([a, b, c])))
    tet_faces.append(tuple(sorted([a, b, d])))
    tet_faces.append(tuple(sorted([a, c, d])))
    tet_faces.append(tuple(sorted([b, c, d])))

face_count = Counter(tet_faces)
boundary_faces = [f for f, count in face_count.items() if count == 1]
print(f"邊界面總數：{len(boundary_faces)}")

# 計算法向量和中心
normals = []
centers = []
for f in boundary_faces:
    p0 = np.array([x[f[0]], y[f[0]], z[f[0]]])
    p1 = np.array([x[f[1]], y[f[1]], z[f[1]]])
    p2 = np.array([x[f[2]], y[f[2]], z[f[2]]])
    v1 = p1 - p0
    v2 = p2 - p0
    normal = np.cross(v1, v2)
    norm = np.linalg.norm(normal)
    if norm > 0:
        normal = normal / norm
    cx, cy, cz = (p0 + p1 + p2) / 3
    r = np.sqrt(cx**2 + cy**2)
    normals.append(normal)
    centers.append([cx, cy, cz, r])

normals = np.array(normals)
centers = np.array(centers)

# 找截斷面節點
upper_nodes = set()
lower_nodes = set()

for i, f in enumerate(boundary_faces):
    cx, cy, cz, r = centers[i]
    nz = abs(normals[i][2])
    if r > 1.8 and nz > 0.9:
        if cz > 0:
            upper_nodes.update(f)
        else:
            lower_nodes.update(f)

print(f"上方截斷面節點數：{len(upper_nodes)}")
print(f"下方截斷面節點數：{len(lower_nodes)}")

# 儲存節點列表（1-indexed，給 Cubit 用）
upper_list = sorted([n+1 for n in upper_nodes])
lower_list = sorted([n+1 for n in lower_nodes])

with open('/home/ubuntu/MSR-project/MSFR/upper_nodes.txt', 'w') as f:
    f.write(' '.join(map(str, upper_list)))

with open('/home/ubuntu/MSR-project/MSFR/lower_nodes.txt', 'w') as f:
    f.write(' '.join(map(str, lower_list)))

print("節點列表已儲存")