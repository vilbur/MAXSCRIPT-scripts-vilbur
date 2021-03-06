
macroscript	epoly_setSmoothGroup_test
category:	"_Epoly_Test"  
buttonText:	"SetSmoothGroup"
tooltip:	"SetSmoothGroup"
(
	(Epoly_v()).setSmoothGroup 1
)


macroscript	epoly_remove_test
category:	"_Epoly_Test"  
buttonText:	"Remove"
tooltip:	"Remove"
(
	undo "Remove subobject" on
	(
		(Epoly_v()).remove()
	)
)

macroscript	epoly_connect_test
category:	"_Epoly_Test"  
buttonText:	"Connect"
tooltip:	"Connect"
(
	undo "Connect subobject" on
	(
		(Epoly_v()).connect()
	)
)

macroscript	epoly_rebuild_faces_test
category:	"_Epoly_Test"  
buttonText:	"Rebuild faces"
tooltip:	"Rebuild faces"
(
	--undo "Rebuild faces" on
	(
		Epoly 	= Epoly_v()
		
		Epoly.rebuildFaces (Epoly.getSel #face as Array )
	)
)








