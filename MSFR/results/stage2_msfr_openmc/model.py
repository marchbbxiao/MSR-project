import openmc

salt = openmc.Material(name='1')
salt.set_density('g/cm3', 4.1249)
salt.add_nuclide('Li7', 0.779961, 'ao')
salt.add_nuclide('Li6', 3.89999999999957e-05, 'ao')
salt.add_nuclide('U233', 0.02515, 'ao')
salt.add_element('F', 1.66, 'ao')
salt.add_element('Th', 0.19985, 'ao')
materials = openmc.Materials([salt])
materials.export_to_xml()

dagmc_univ = openmc.DAGMCUniverse(filename='msr.h5m')
geometry = openmc.Geometry(root=dagmc_univ)
geometry.export_to_xml()

settings = openmc.Settings()
settings.source = openmc.IndependentSource(
    space=openmc.stats.SphericalIndependent(
        r=openmc.stats.Uniform(0, 200),
        cos_theta=openmc.stats.Uniform(-1, 1),
        phi=openmc.stats.Uniform(0, 2*openmc.pi)
    )
)
settings.batches = 100
settings.inactive = 50
settings.particles = 1000
settings.temperature = {
    'default': 898.0,
    'method': 'interpolation',
    'multipole': True,
    'range': (294.0, 3000.0)
}
settings.export_to_xml()
print("XML 產生完成")
