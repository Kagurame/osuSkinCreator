class Context_Skins < Context_Base

	def setup
		gr_add Bitmap.new(@contents.w, 32)
		gr_last.bitmap.draw_text(gr_last.bitmap.rect, "osu! Skins", 1)
		
		@back = Sprite.new
		@back.bitmap = Bitmap.new System::Skins::OSC.get_file(:menu_back)
		
		@back.x = 5
		@back.y = 480 - @back.bitmap.height - 5
	end
	
	def unload
		@back.bitmap.dispose
		@back.dispose
		super
	end
	
	def refresh
	
	end
	
	def update
		if Input.mouse? && @back.mouse_over?
			$scene = Scenes::Welcome.new
			return
		end
	end
	
end