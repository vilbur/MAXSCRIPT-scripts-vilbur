/** Interface for
 *		- EditablePoly_v
 *		- EditPoly_v
 *
 
	------- DESIGN -- DELTE NOTES BELLOW LATER
	Epoly = Epoly_v()
 
	Selection= Selection_v Epoly:Epoly
 
	Epoly.Mod.FindOrAdd()
	
	Epoly.Selection
	Epoly.Selection.get #face
  
 */
struct Epoly_v
(
	_objects, -- This property is accessed from other classes
	
	Mod	= EpolyMod_v(),
	Options	= EpolyOptions_v	Epoly:this,
	Sel	= EpolySelection_v	Epoly:this,
	Edit 	= EpolyEdit_v	Epoly:this,
	SmoothGroups	= EpolySmoothGroups_v	Epoly:this,
	Edges	= EpolyEdges_v	Epoly:this,
	Explode	= EditPolyExplode_v	Epoly:this,
	Material 	= EditPolyMaterial_v	Epoly:this,
	Subobject 	= EpolySubobject_v	Epoly:this,
	
	/** _construct
	 */
	function _construct =
	(
		--messageBox "_construct" beep:false
		this.setObjects()
	),


	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** _objects
	 */
	function obj =
	(
		_objects[1] --return
	),	
	/** _objects
	 */
	function objs =
	(
		_objects --return
	),	
	
	/** Set selection of objects
	 */
	function setObjects =
	(
		_objects	= for obj in selection where superClassOf obj == GeometryClass collect obj
		--_objects = (Selection_v()).get() -- THIS METHOD WILL BE USED, IT WILL FILTER INSTANCES
	),
	
	
	
	
	
	__construct = this._construct(),

	
	
	
	
	
	
	
	
	
	/*------------------------------------------------------------------------------
	  
		!!! OLD !!
		 
		REMOVE METHODS BELOW
		
	--------------------------------------------------------------------------------*/
	
	EpolyMod	= EpolyMod_v(),
	EpolyOptions	= EpolyOptions_v(),
	EpolySelection	= EpolySelection_v(),
	EpolySmoothGroups	= EpolySmoothGroups_v(),
	EpolyEdges	= EpolyEdges_v(),
	EditPolyExplode	= EditPolyExplode_v(),
	EditPolyMaterial 	= EditPolyMaterial_v(),
	EpolyEdit 	= EpolyEdit_v(),
	--Material 	= EditPolyMaterial_v(),
	/*---------------------------------------
		EXTENDS
	-----------------------------------------*/
	
	/*------ EpolyOptions ------*/
	ignoreBackfacing	= EpolyOptions.ignoreBackfacing,
	constrain	= EpolyOptions.constrain,
	preserveUvs	= EpolyOptions.preserveUvs,
	selectByAngle	= EpolyOptions.selectByAngle,
	
	/*------ EpolySmoothGroups ------*/
	setSmoothGroup	= EpolySmoothGroups.setSmoothGroup,
	autoSmooth	= EpolySmoothGroups.autoSmooth,
	clearSmoothGroups	= EpolySmoothGroups.clearSmoothGroups,
	
	/*------ EpolySelection ------*/
	getSel	= EpolySelection.getSel,
	setSel	= EpolySelection.setSel,
	convertSelection	= EpolySelection.convertSelection,
	allFaces	= EpolySelection.allFaces,
	getSelectedOrAllFaces	= EpolySelection.getSelectedOrAllFaces,
	--getAusingB 	= EpolySelection.getAusingB,
	
	/*------ EpolyEdges ------*/
	selectHardEdges	= EpolyEdges.selectHardEdges,
	splitEdges	= EpolyEdges.splitEdges,
	
	/*------ EditPolyExplode ------*/
	explodeByHardEdges	= EditPolyExplode.explodeByHardEdges,
	explodeByMaterialId	= EditPolyExplode.explodeByMaterialId,
	explodeBySG	= EditPolyExplode.explodeBySG,
	explodeByElement	= EditPolyExplode.explodeByElement,

	/*------ EditPolyMaterial ------*/
	setMatId 	= EditPolyMaterial.setMatId,
	setMatIdToObject 	= EditPolyMaterial.setMatIdToObject,
	
	/*------ EpolyEdit ------*/
	quickslice 	= EpolyEdit.quickslice,
	extrude 	= EpolyEdit.extrude,
	targetWeld 	= EpolyEdit.targetWeld,
	makePlanar 	= EpolyEdit.makePlanar,
	connect 	= EpolyEdit.connect,
	
	--/** Is epoly
	-- */
	--function isEpoly =
	--(
	--	true --return
	--),
	/** Get subobj
	 */
	function getAWhereB sub_obj_A sub_obj_B expr count =
	(
		messageBox "Method renamed\nEpoly_v.getAWhereB()\n>>>\nEpoly_v.Sel.getAWhereB()"
		--_Epoly = EpolyMod.getEpoly()
		--
		--sub_ob_count	= _Epoly.count 1
		--
		--result_sub_obj =	for i = 1 to sub_ob_count where
		--(
		--	_count_sub_obj	= (( _Epoly.getAusingB #edge #vertex i ) as Array).count
		--	execute (_count_sub_obj as string + expr + count as string )
		--)
		--collect i 	
		--
		--result_sub_obj as BitArray --return
		----print ( "result_sub_obj = " + result_sub_obj as string )
		----(EpolyMod.mod()).SetSelection #Vertex result_sub_obj
	),
	
	
	/** Get epoly info
	  !!!! MOVE THIS TO OWN FILE
	 */
	function getEpolyInfo =
	(
		backafing	= this.ignoreBackfacing	state:#get
		constrain	= this.constrain	state:#get get:#name
		preserveuv	= this.preserveUvs	state:#get
		by_angle	= this.selectByAngle	state:#get
		
		epoly_infos = #(
			#("Info_ignoreBackfacing", (if(backafing==true)then "BACKFACING" else backafing),                                        ( color 114 255 0) ),
			#("Info_constrain",        (if(constrain!=false)then ( "      "+( toUpper (constrain as string ))+"      ") else false), ( color 255 120 0) ),
			#("Info_by_angle",         (if(by_angle[1]==true)then "   ANGLE   " +by_angle[2] as string else false),                  ( color 255 235 0) ),
			#("Info_preserveuv",       (if(preserveuv==true)then "        UV        " else preserveuv),                              ( color 255 0 0) )
		)
		
		for epoly_info in epoly_infos where classOf  epoly_info[2] == String do
			epoly_info[2] = "■■■   "+epoly_info[2]+"   ■■■"
			
		--print ( "epoly_infos = " + epoly_infos as string )
		epoly_infos --return
	), 

	/** Attach
	 */
	function attachSelection weld =
	(
		
		--for o=1 to (selection.count ) where superclassof selection[o] == geometryclass do 
		for obj in selection where superClassOf obj == GeometryClass do
		(
			addModifier obj (Edit_Poly())
			maxOps.CollapseNode obj off
		)

		maxOps.CollapseNodeTo  selection[ selection.count] 1 off
		
		while selection.count > 1 do
		(
			selcount = selection.count
			for i = selcount to 2 by -2 do
				polyop.attach selection[i] selection[i-1]
		)
		update selection[1]
		
		_mod = EpolyMod.mod()
		_mod.weldThreshold = 0.001
		
		polyop.weldVertsByThreshold selection[1] #{1..( polyop.getNumVerts selection[1])} --weld vetices

	),

	/** Remove subobject
	 */
	function remove =
	(
		(this.EpolyMod.getEpoly()).remove()
	),

	/** Face count
	 */
	function faceCount =
	(		
		(this.EpolyMod.getEpoly()).faceCount()
	),
	/** Face count
	 */
	function count sub_obj =
	(		
		(this.EpolyMod.getEpoly()).count sub_obj
	),
	/** Create polygon
	 */
	function create =
	(
		if( EpolyMod.getEpoly()!=undefined ) then
		(
			if( subObjectLevel == 1 or subObjectLevel == 2 ) then
				macros.run "PolyTools" "CreatePolygon"
		)
	),

	/*---------------------------------------
		PRIVATE
	-----------------------------------------*/

	--/** _all faces
	-- */
	--function _allFaces =
	--(
	--	#{1..( polyop.getNumFaces selection[1] )} --return
	--),
	function hideObj mode subObj layer =
	(
	
	/*	
	mode= "Selected"  		
			mode= "UnSelected"
			mode= "UnHide"   
			
			layer=0
				
			subObj=0
			subObj=1
			
			------ OBJECT LEVEL	
			Hide_v "Selected" 0 0
			Hide_v "UnSelected" 0 0
			Hide_v "UnHide" 0 0
				
			------ SUBOBJECT LEVEL	
			Hide_v "Selected" 1 0
			Hide_v "UnSelected" 1 0
			Hide_v "UnHide" 1 0
			*/	
		undo "Hide Unhide" on 
		(
			selSubObj = #{}
			selInv = #{}
			--	local LayersOn = #()
			sel = #()
			AllObjects = #()
	
	-- 		invertSel = #()
	
			sel = for o in selection collect o
			AllObjects = for o in objects where o.layer.on collect o
						
	-- 		invertSel = for o in objects where (finditem sel o == 0) collect  o
			curObj = modPanel.GetCurrentObject ()
	
			if subobjectLevel != 0 do
			(
				if  subobjectLevel == 1 then
				(
					var1 = #Vertex
					var2 = #HideVertex
					var3 = #UnhideAllVertex
					var4 = #HideUnselectedVertex
				)
				else			
				(
					var1 = #Face
					var2 = #HideFace 
					var3 = #UnhideAllFace
					var4 = #HideUnselectedFace
				)	
							
				
				case of
				(
					(classof curObj == Editable_Poly): (
													selSubObj = if subobjectlevel == 1 then (polyOp.getVertSelection curObj) else  (polyOp.getFaceSelection curObj) 
													selInv = -(selSubObj)										
													)
					(classof curObj == Edit_Poly    ): (
													selSubObj = (curObj.getSelection var1) 
													selInv = -(selSubObj) 
													)
				)	
			)
			--------------------------	OBJECT HIDE UNHIDE	 ---------------------------
			if  subObj == 0 or ((selSubObj as array).count == 0 and  mode!= "UnHide" ) then
			(
				--mode = "UnSelected"
				--		o=$
				--		o=sel[1]
				--		o=invertSel[1]
					case layer == 0 of
					(
						(mode== "Selected"  ):(hide sel; clearSelection())			
						(mode== "UnSelected"): for o in AllObjects where finditem sel o == 0 and not o.isHidden do hide o
						(mode== "UnHide"    ): for o in AllObjects where o.isHidden do unhide o	
					)
			)	
			--------------------------	SUBOBJECT HIDE UNHIDE ---------------------------
			else if  subObj == 1   or  mode == "UnHide" then
			(		
		--				curObj = modPanel.GetCurrentObject () 
				if classof curObj == Editable_Poly then
				(
					case layer == 0 of
					(
						(mode== "Selected"  ):(curObj.Hide var1; curObj.setSelection var1 #{})
						(mode== "UnSelected"):(curObj.setSelection var1 selInv; curObj.Hide var1; curObj.setSelection var1 selSubObj )
						(mode== "UnHide"    ): curObj.unhideAll var1
					)
				)
				else if classof curObj == Edit_Poly then
				(
					case layer == 0 of
					(
						(mode== "Selected"  ):(curObj.ButtonOp var2; curObj.setSelection var1 #{})
						(mode== "UnSelected"):(curObj.ButtonOp var4; curObj.setSelection var1 selSubObj )
						(mode== "UnHide"    ): curObj.ButtonOp var3
					)
				)
			)
		
		)
	
	),
		/*
		----All layers off
			
		for i=0 to LayerManager.count where i< LayerManager.count do
		(
			ilayer = layerManager.getLayer i
			ilayer.on = false
			i+=0
		)		
		----	All layers on
		for o in sel do
		(
			objLayer = o.layer.name	
			Layer = LayerManager.getLayerFromName objLayer
			Layer.on = true		
		) 
	*/	


	
	function test =
	(
		--this._setCurrentModifier()
		messagebox "Epoly_v.test()"

	)
	
)

