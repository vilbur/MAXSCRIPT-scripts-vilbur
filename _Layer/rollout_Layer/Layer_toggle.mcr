--
--/*------------------------------------------------------------------------------
--	HERLPERS FUNCTIONS
----------------------------------------------------------------------------------*/
--/** Layer button left click
-- */
--function layerButtonLeftClick layer_names =
--(
--	--key_press
--	Layer 	= (Layer_v())
--	
--	Layer.toggle layer_names
--	
--)
--
--function macrosTest layers_on =
--(
--
--	with redraw off
--	(
--		Layer 	= (Layer_v())
--		Layer.turnOnAllLayers()
--		Layer.hideAllLayers excludes:#("Edit")
--		Layer.activate layers_on
--	)
--)
--
--/*------------------------------------------------------------------------------
--	MACROS
----------------------------------------------------------------------------------*/
--macroscript	layer_turn_on_layer_edit
--category:	"_Layer"
--buttontext:	"Edit"
--toolTip:	"Turn on 'Edit' layer"
----icon:	"#(path, index)"
--(
--	--with redraw off
--	--(
--	--	Layer 	= (Layer_v())
--	--	Layer.turnOnAllLayers()
--	--	Layer.hideAllLayers excludes:#("Edit")
--	--	Layer.activate "Edit"
--	--)
--	--macrosTest "Edit"
--	LayerButtonLeftClick "Edit"
--)
--
--macroscript	layer_turn_on_layer_export
--category:	"_Layer"
--buttontext:	"Export"
--toolTip:	"Turn on 'Export' layer"
----icon:	"#(path, index)"
--(
--	--macrosTest "Export"
--	LayerButtonLeftClick "Export"
--	
--)