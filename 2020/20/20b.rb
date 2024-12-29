def toNumber(s) = s.gsub(?., ?0).gsub(?#, ?1).to_i(2)

class Tile
    attr_reader :id, :img, :codes
    
    def initialize(id, img)
        @id = id
        @img = img
        @codes = []
            
        top = img.first
        bottom = img.last
        left  = img.map{ _1[0]  }.join
        right = img.map{ _1[-1] }.join        
        [top, left, bottom, right].each{ |s| codes << toNumber(s) << toNumber(s.reverse) }
    end
    
    def code(dir)
        case dir
        when :top then toNumber(@img.first)
        when :right then toNumber(@img.map{ _1[-1] }.join)
        when :bottom then toNumber(@img.last)
        when :left then toNumber(@img.map{ _1[0] }.join)
        end
    end

    def stripBorders!
        @img = @img[1..-2].map{ _1[1..-2]}
    end

    def inspect
        "Tile<#{@id}>"
    end

    def flip = Tile.new(@id, @img.map(&:reverse))

    def rotate90 = Tile.new(@id, @img.size.times.map {|i| @img.map{_1[i]}.join.reverse})
        
    def rotate180 = Tile.new(@id, @img.reverse.map(&:reverse))
        
    def rotate270 = Tile.new(@id, @img.size.times.map {|i| @img.map{_1[@img.size-i-1]}.join})

    def orientations
        [
            self,
            flip,
            rotate90,
            rotate90.flip,
            rotate180,
            rotate180.flip,
            rotate270,
            rotate270.flip
        ]
    end

    def adjacent?(other)
        other.id != self.id && @codes.intersect?(other.codes)
    end

end

def dumpRow(row)
    row[0].img.size.times do |i|
        row.each{|l| print l.img[i], " "}       
        puts
    end
end

def dumpImage(im)
    im.each do |rr|
        dumpRow(rr)
        puts
    end
end


ids = []
tileMap = File.read("input.txt").split("\n\n").map do |p|
    name, *rows = p.split("\n")
    number = name.scan(/\d+/).flatten.first.to_i    
    tile = Tile.new(number, rows)
    ids << number

    [number, tile]
end.to_h

$tiles = tileMap.values

def adjacentTiles(tile)
    $tiles.select{_1.adjacent?(tile)}
end

upperLeft = $tiles.map{|t| [t.id, adjacentTiles(t).size]}.select{|id,c| c==2}.first.first

c1 = tileMap[upperLeft]
c2, c3 = adjacentTiles(c1)

ul, r, b= c1.orientations.product(c2.orientations).product(c3.orientations).map(&:flatten).select{|ul, r, b| ul.code(:right) == r.code(:left) && ul.code(:bottom) == b.code(:top)}.flatten

image = []
image[0] = [ul, r]
image[1] =[b]

index = 0

prevTile = ul
nextTile = r
rowReady = false
idsPlaced = Set.new([prevTile])

loop do

    until rowReady do
        n = adjacentTiles(nextTile).reject{idsPlaced.include?(_1.id)}.flat_map(&:orientations).select{|rr| rr.code(:left) == nextTile.code(:right)}    
        if n.empty?
        index += 1
            rowReady=true
        else
            prevTile = nextTile
            nextTile = n.first
            image[index] << nextTile
            idsPlaced << nextTile.id
        end         
    end
    
    n = adjacentTiles(image[index-1][0]).reject{idsPlaced.include?(_1.id)}.flat_map(&:orientations).select{|rr| rr.code(:top) == image[index-1][0].code(:bottom)}
    break if n.empty?
    nextTile = n.first
    image[index] = [nextTile]
    idsPlaced << nextTile.id
    
    rowReady = false
end

dumpImage(image)


pixels = Set.new

image.size.times do |y|
    image[0].size.times do |x|
        image[y][x].stripBorders!
        print image[y][x].id, " "

        image[y][x].img.each.with_index do |row, ri|
            row.each_byte.with_index do |by, ci|
                pixels << Complex(8*x+ci, 8*y+ri) if by == 35
            end
        end
    end
    puts
end
$width = image[0][0].img[0].size * image[0].size
$height = image[0][0].img.size * image.size

dumpImage(image)
puts
#p pixels

monster =
"                  # ",
"#    ##    ##    ###",
" #  #  #  #  #  #   "

puts monster
#p $width, $height

monsterPattern = Set.new    

monster.each.with_index do |l,y|
    l.each_byte.with_index do |c,x|
        monsterPattern << Complex(x,y) if c == 35
    end
end

def findMonster(monsterPattern, pixels)
    
    monsterSize = monsterPattern.size

    counter = 0
    (0..$width).each do |x|
        (0..$height).each do |y|
            offset = Complex(x,y)        
            counter += 1 if monsterPattern.map{_1 + offset}.to_set.intersection(pixels).size == monsterSize
        end
    end
    counter
end


count = [
    pixels,
    pixels.map{ Complex(_1.real, $height-_1.imag)},
    pixels.map{ Complex($width - _1.real, _1.imag)},
    pixels.map{ Complex(_1.imag, _1.real)},
    pixels.map{ Complex($width-_1.imag, _1.real)},
    pixels.map{ Complex(_1.imag, $height-_1.real)},
    pixels.map{ Complex($width-_1.imag, $height-_1.real)}
]
.map{findMonster(monsterPattern, _1)}.max

p pixels.size - count * monsterPattern.size