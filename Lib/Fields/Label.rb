class Label < Bitmap

	attr_reader :hover
	attr_reader :text

	def initialize(length, text=" ")
		super length, 32
    
    @length = length
    @text = text
    @hover = false
		
    refresh
	end

	def refresh
		clear
    
    circle = Bitmap.new(12, 12)
    circle.draw_circle(circle.rect, Color.new(255, 255, 255), 2)
    
    corners = []
    4.times { corners << Bitmap.new(6, 6) }
    
    corners[0].blt(0, 0, circle, Rect.new(0, 0, 6, 6)) # upper left
    corners[1].blt(0, 0, circle, Rect.new(7, 0, 5, 6)) # upper right
    corners[2].blt(0, 0, circle, Rect.new(0, 7, 6, 5)) # lower left
    corners[3].blt(0, 0, circle, Rect.new(7, 7, 5, 5)) # lower right
    
    borders = [Bitmap.new(2 ,20), Bitmap.new(@length - 12, 2)]
    yellow_pigment = @hover ? 0 : 255
    borders.each { |border| border.fill_rect(border.rect, Color.new(255, 255, yellow_pigment)) }
    
    blt(1, 6, borders[0], borders[0].rect) # left
    blt(@length - 3, 6, borders[0], borders[0].rect) # right
    blt(6, 1, borders[1], borders[1].rect) # upper
    blt(6, 29, borders[1], borders[1].rect) # lower
    blt(0, 0, corners[0], corners[0].rect) # upper left
    blt(@length - 6, 0, corners[1], corners[1].rect) # upper right
    blt(0, 26, corners[2], corners[2].rect) # lower left
    blt(@length - 6, 26, corners[3], corners[3].rect) # lower right
    
    text_length = Bitmap.new(16,16).text_size(@text.to_s).width
    text_length = 1 if text_length == 0
		
    text_bitmap = Bitmap.new(text_length, 26)
		text_bitmap.draw_text(text_bitmap.rect, @text)
		
    blt(4, 3, text_bitmap, text_bitmap.rect)
	end
	
	def hover=(value)
		return if @hover == value
		@hover = value
		refresh
	end
	
end