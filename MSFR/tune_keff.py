import subprocess
import xml.etree.ElementTree as ET

OPENMC_BIN = '/home/ubuntu/cardinal/install/bin/openmc'
XS_PATH = '/home/ubuntu/data/cross_sections/endfb-vii.1-hdf5/cross_sections.xml'
H5M = '/home/ubuntu/MSFR/msr_reflecting.h5m'
WORKDIR = '/home/ubuntu/MSFR'

def write_inputs(u233_frac):
    # materials.xml
    root = ET.Element('materials')
    mat = ET.SubElement(root, 'material', id='1', name='fuel_salt')
    ET.SubElement(mat, 'density', value='4.1249', units='g/cm3')
    ET.SubElement(mat, 'nuclide', name='Li7',  ao=str(0.779961))
    ET.SubElement(mat, 'nuclide', name='Li6',  ao=str(3.9e-5))
    ET.SubElement(mat, 'nuclide', name='U233', ao=str(u233_frac))
    ET.SubElement(mat, 'nuclide', name='F19',  ao=str(1.66))
    ET.SubElement(mat, 'nuclide', name='Th232',ao=str(0.19985))
    ET.SubElement(root, 'cross_sections').text = XS_PATH
    ET.indent(root)
    ET.ElementTree(root).write(f'{WORKDIR}/materials.xml', xml_declaration=True, encoding='unicode')

    # geometry.xml
    root = ET.Element('geometry')
    ET.SubElement(root, 'dagmc_universe', id='1', filename=H5M, auto_geom_ids='true')
    ET.indent(root)
    ET.ElementTree(root).write(f'{WORKDIR}/geometry.xml', xml_declaration=True, encoding='unicode')

    # settings.xml
    root = ET.Element('settings')
    ET.SubElement(root, 'run_mode').text = 'eigenvalue'
    ET.SubElement(root, 'batches').text = '100'
    ET.SubElement(root, 'inactive').text = '50'
    ET.SubElement(root, 'particles').text = '1000'
    src = ET.SubElement(root, 'source')
    space = ET.SubElement(src, 'space', type='spherical')
    ET.SubElement(space, 'parameters').text = '0 0 0 0 70'
    ET.indent(root)
    ET.ElementTree(root).write(f'{WORKDIR}/settings.xml', xml_declaration=True, encoding='unicode')

def run_and_get_keff(u233_frac, label):
    write_inputs(u233_frac)
    result = subprocess.run(
        ['mpirun', '-n', '4', '--mca', 'btl_vader_single_copy_mechanism', 'none', OPENMC_BIN],
        capture_output=True, text=True, cwd=WORKDIR
    )
    for line in result.stdout.split('\n'):
        if 'Combined k-effective' in line:
            print(f"{label}: U233={u233_frac:.5f} → {line.strip()}")
            return
    print(f"{label}: 找不到keff")
    print(result.stderr[-300:])

run_and_get_keff(0.02515,        "baseline  ")
run_and_get_keff(0.02515 * 0.90, "U233 -10% ")
run_and_get_keff(0.02515 * 0.80, "U233 -20% ")
run_and_get_keff(0.02515 * 0.75, "U233 -25% ")
run_and_get_keff(0.02515 * 0.70, "U233 -30% ")

print("--- 精化試驗 ---")
run_and_get_keff(0.02135, "精化 -15.1%")
run_and_get_keff(0.02100, "精化 -16.5%")
