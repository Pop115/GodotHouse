extends Node3D

func load_apartment(path: String) -> PackedScene:
	var importer = GLTFDocument.new()
	var root = Node3D.new()

	# Utilisation du ResourceImporterScene pour importer le .obj
	var mesh_instance = MeshInstance3D.new()
	var mesh = load(path)
	if mesh:
		mesh_instance.mesh = mesh
		root.add_child(mesh_instance)
	else:
		push_error("Impossible de charger le modèle " + path)
		return null

	var packed = PackedScene.new()
	packed.pack(root)
	return packed
