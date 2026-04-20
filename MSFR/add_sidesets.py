import cubit

# 讀取節點列表
with open('/home/ubuntu/MSR-project/MSFR/upper_nodes.txt', 'r') as f:
    upper_nodes = list(map(int, f.read().split()))

with open('/home/ubuntu/MSR-project/MSFR/lower_nodes.txt', 'r') as f:
    lower_nodes = list(map(int, f.read().split()))

print(f"上方節點數：{len(upper_nodes)}")
print(f"下方節點數：{len(lower_nodes)}")

# 建立 nodeset
# gap_exit_boundary = 上方（Z > 0）= sideset 1
# gap_enter_boundary = 下方（Z < 0）= sideset 2
cubit.cmd(f"nodeset 1 node {' '.join(map(str, upper_nodes))}")
cubit.cmd("nodeset 1 name 'gap_exit_boundary'")

cubit.cmd(f"nodeset 2 node {' '.join(map(str, lower_nodes))}")
cubit.cmd("nodeset 2 name 'gap_enter_boundary'")

print("Nodeset 建立完成")

# 匯出新的 mesh 檔
cubit.cmd("export mesh '/home/ubuntu/MSR-project/MSFR/msr_with_sidesets.e' overwrite")
print("msr_with_sidesets.e 已匯出")