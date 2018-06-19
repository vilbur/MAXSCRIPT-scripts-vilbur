/** Edit poly
 */
struct EditPoly_v
(
	obj,
	final_sel = #(),

	/** Explode
	  * @param	[bitArray]	poly_selections	Array of bitarrays to detach
	  * @return	selection	
	  *
	 */
	function explode poly_selections =
	(
		print ( "poly_selections=" + poly_selections as string )
		
		for poly_selection in poly_selections do
			this.detach poly_selection
			
		final_sel --return
		--append final_sel detObj
	),
	/** Detach
	  *
	  * 
	 */
	function detach poly_selection =
	(
		--select obj
		--print ( "poly_selection=" + poly_selection as string )
		--print ( "polyop.getNumFaces obj=" + polyop.getNumFaces obj as string )
		--print ( "poly_selection.count =" + poly_selection.count  as string )

		--if( polyop.getNumFaces obj > poly_selection.count ) then
		--(
			polyop.detachFaces obj poly_selection delete:false asNode:true name: "TempDet"
			detObj = getnodebyname "TempDet" 
			detObj.name = (uniquename (obj.name + "_detach"))
			detOBj.wirecolor =  color (random 0 255) (random 0 255) (random 0 255)
			append final_sel detObj

		--)
	),

	/** Attach
	 */
	function attachSelection weld =
	(
		if selection.count > 1 do
		(
			undo "Attach_Selected_v" on
			(
				for o=1 to (selection.count - 1 ) where superclassof selection[o] == geometryclass do 
				(
					AddModifier selection[o] (Edit_Poly())
					maxOps.CollapseNode selection[o] off
				)
	
				maxOps.CollapseNodeTo  selection[selection.count] 1 off
	
				while selection.count > 1 do
				(
					selcount = selection.count
					for i = selcount to 2 by -2 do
						polyop.attach selection[i] selection[i-1]
				)
				update selection[1]
	
				if weld == true do
					(polyop.weldVertsByThreshold selection[1] #{1..( polyop.getNumVerts selection[1])}) --weld vetices
	
			)
		)
	),
	/** Explode
	 */
	function explodeByElement =
	(
		instances = #()		
		obj_instance = #()
		if classof obj != editable_poly do 
		(
			addmodifier obj (Edit_Poly ())
			maxOps.CollapseNodeTo obj 1 off
		)
		
		InstanceMgr.GetInstances obj &obj_instance
		join instances obj_instance		
			
		Elements = this.getElements()
		--ElementsCount = Elements.Count
		
	--		for i=1 to ElementsCount do 
	--		(
	--			Clones = #()
	--			maxOps.cloneNodes instances cloneType:#copy newNodes:&Clones
	--			copyObj = Clones[1]
	--			polyop.deleteFaces copyObj -Elements[i] delIsoVerts:true
	--			
	---- 				wirecolor = color (random 100 255) (random 100 255) (random 100 255)
	--			wirecolor	= obj.wirecolor
	--			for o in Clones do o.wirecolor = wirecolor
	--				
	--			for c=1 to Clones.count do Clones[c].name = (obj.name + "_Expl_"+ c as string)
	--			
	--			for c in Clones do append finalSel c
	--		)
	--		
	--		delete instances
	),
	/** Get elements
	 */
	function getElements =
	(

		faces = #{}
		objFaces = this._allFaces()
		objFaces_count = objFaces.count
		CurObj = polyop

		getElement = CurObj.getElementsUsingFace

		elements = for i in objFaces where objFaces[i] == true collect
		(
			element = getElement obj i
			objFaces -= element
			element
		)

		elements --return		
	),
	/** Explode by material id
	 */
	function explodeByMaterialId =
	(
		--all_ids = #()
		--detID = #()
		--selo = #()
		--finalSel = #()
		
		--selo = for o in selection collect o
		
		--for obj in selo do
		----(
			print ( "Detaching: " + obj.name as string)
			
			if (classOf obj != Editable_Poly) do
			(
				convertTo obj Editable_Poly
				polyop.deleteIsoVerts obj
			)
			
			try ( maxops.CollapseNodeTo obj 1 off) catch ()
			

			final_sel	= this.explode ( this._getMaterialElements() )
			
			--delete obj
			final_sel --return
		--)
	),
	/** Get material elements
	  * @return	[bitArray]	Array of faces by material
	 */
	function _getMaterialElements =
	(
		all_ids	= #()
		material_faces	= #();

		print "_getMaterialElements"
		for f=1 to polyop.getNumFaces obj do
		(
			print ( "face=" + f as string )
			matID = polyop.getFaceMatID obj f
			appendIfunique all_ids matID
		)
		--		id = 1
		for id in all_ids do
			append material_faces ((for f=1 to polyop.getNumFaces obj where polyop.getFaceMatID obj f == id collect f) as bitarray)

		material_faces --return
	),
	/**  
	 *	
	 */
	function explodeBySG =
	(
		print ( "----explodeBySG" )
		print ( "polyop.getNumFaces obj=" + polyop.getNumFaces obj as string )
		face_num	= polyop.getNumFaces obj

		poly_selections = #()
		maxops.CollapseNode obj off
		--smGroupsArray = polyop.getFaceSmoothGroup obj firstFace;
		FaceCount = polyop.getNumFaces obj;
		
		for sg = 1 to 32 do
		(
			--print ( "sg=" + sg as string )
			poly_selection = #()

			for f=1 to FaceCount do 
							
				if (( polyop.getFaceSmoothGroup obj i) == sg) then 
					append poly_selection i; 
					
			if  (  poly_selection.count > 0 and ( (poly_selection as array)[1] == 1 and poly_selection.count == face_num)==false ) then
				append poly_selections poly_selection
		)
		
		for poly_selection in poly_selections do
			this.detach poly_selection
				
		final_sel --return
	),




	/** Set smooth group
	 */
	function setSmoothGroup facelist smooth_group =
	(
		polyop.setFaceSmoothGroup obj #all 0

		--print ( "facelist=" + facelist as string )
		polyop.setFaceSmoothGroup obj (this._allFaces()) smooth_group
	),
	/** Set mat id
	 */
	function setMatId id =
	(
		print ( "setMatId=" + id as string )
		--if (classOf obj != Editable_Poly) do
		--(
		--	convertTo obj Editable_Poly
		--	polyop.deleteIsoVerts obj
		--)
		
		polyop.setFaceMatID obj #{1..( polyop.getNumFaces obj)} id
   
	),
	/** _all faces
	 */
	function _allFaces =
	(
		#{1..( polyop.getNumFaces obj)} --return
	),

	function test =
	(
		messagebox "EditPoly.test()"
	)
)