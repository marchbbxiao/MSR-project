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

# 找截斷面的 element+side（給 Exodus side set 用）
upper_sides = []  # [(element_id, side_id), ...]
lower_sides = []

# 建立 face→element 的反查表
face_to_elem = {}
for elem_idx, tet in enumerate(connect):
    a, b, c, d = tet
    local_faces = [
        (tuple(sorted([a, b, d])), 1),  # side 1
        (tuple(sorted([b, c, d])), 2),  # side 2
        (tuple(sorted([a, c, d])), 3),  # side 3
        (tuple(sorted([a, b, c])), 4),  # side 4
    ]
    for face_nodes, side_id in local_faces:
        face_to_elem[face_nodes] = (elem_idx + 1, side_id)  # 1-indexed

wall_sides = []

for i, f in enumerate(boundary_faces):
    cx, cy, cz, r = centers[i]
    nz = abs(normals[i][2])
    elem_id, side_id = face_to_elem[f]
    if r > 1.8 and nz > 0.9:
        if cz > 0:
            upper_sides.append((elem_id, side_id))
        else:
            lower_sides.append((elem_id, side_id))
    else:
        wall_sides.append((elem_id, side_id))

print(f"壁面截斷面數：{len(wall_sides)}")

print(f"上方截斷面數：{len(upper_sides)}")
print(f"下方截斷面數：{len(lower_sides)}")

# 寫入 Exodus side set（用 netCDF4 直接修改）
import netCDF4 as nc_write

# 複製 msr.e → msr_with_sidesets.e
import shutil
shutil.copy('/home/ubuntu/MSR-project/MSFR/msr.e',
            '/home/ubuntu/MSR-project/MSFR/msr_with_sidesets.e')

ds_out = nc_write.Dataset('/home/ubuntu/MSR-project/MSFR/msr_with_sidesets.e', 'a')

n_ss = 2
upper_elems = [s[0] for s in upper_sides]
upper_sides_ids = [s[1] for s in upper_sides]
lower_elems = [s[0] for s in lower_sides]
lower_sides_ids = [s[1] for s in lower_sides]

ds_out.createDimension('num_side_sets', 3)
ds_out.createDimension('num_side_ss1', len(upper_sides))
ds_out.createDimension('num_side_ss2', len(lower_sides))
ds_out.createDimension('num_side_ss3', len(wall_sides))

ss_status = ds_out.createVariable('ss_status', 'i4', ('num_side_sets',))
ss_prop1  = ds_out.createVariable('ss_prop1',  'i4', ('num_side_sets',))
ss_names  = ds_out.createVariable('ss_names',  'S1', ('num_side_sets', 'len_name'))
ss_prop1.setncattr('name', 'ID')

ss_status[:] = [1, 1, 1]
ss_prop1[:]  = [1, 2, 3]

len_name = ds_out.dimensions['len_name'].size
arr = np.zeros((3, len_name), dtype='S1')
for i, ch in enumerate('gap_exit_boundary'):
    arr[0, i] = ch.encode()
for i, ch in enumerate('gap_enter_boundary'):
    arr[1, i] = ch.encode()
for i, ch in enumerate('wall'):
    arr[2, i] = ch.encode()
ss_names[:] = arr

elem_ss1 = ds_out.createVariable('elem_ss1', 'i4', ('num_side_ss1',))
side_ss1 = ds_out.createVariable('side_ss1', 'i4', ('num_side_ss1',))
elem_ss2 = ds_out.createVariable('elem_ss2', 'i4', ('num_side_ss2',))
side_ss2 = ds_out.createVariable('side_ss2', 'i4', ('num_side_ss2',))

elem_ss1[:] = upper_elems
side_ss1[:] = upper_sides_ids
elem_ss2[:] = lower_elems
side_ss2[:] = lower_sides_ids

elem_ss3 = ds_out.createVariable('elem_ss3', 'i4', ('num_side_ss3',))
side_ss3 = ds_out.createVariable('side_ss3', 'i4', ('num_side_ss3',))
elem_ss3[:] = [s[0] for s in wall_sides]
side_ss3[:] = [s[1] for s in wall_sides]
ds_out.close()
print("msr_with_sidesets.e 已寫入正確 side sets")