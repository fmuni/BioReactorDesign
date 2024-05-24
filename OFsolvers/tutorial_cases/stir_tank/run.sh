# Clean case
./Allclean

# Generate blockmeshDict
python ../../../applications/write_stir_tank_mesh.py -i ../../../bird/meshing/stir_tank_mesh_templates/base_tank/tank_par.yaml -o system/blockMeshDict


# Mesh gen
blockMesh -dict system/blockMeshDict
cp -r orig0 0
stitchMesh -perfect -overwrite inside_to_hub inside_to_hub_copy
stitchMesh -perfect -overwrite hub_to_rotor hub_to_rotor_copy
transformPoints "rotate=((0 0 1)(0 1 0))"

# set IC
setFields
rm -rf 0/meshPhi

# Run
multiphaseEulerFoam

