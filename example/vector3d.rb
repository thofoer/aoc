require "matrix"
class Vector
    def x = self[0]        
    def y = self[1]
    def z = self[2]
end
v = Vector[1,2,3]

$rotx = Matrix[[1,  0, 0], [0, 0, -1], [ 0, 1, 0]]
$roty = Matrix[[0,  0, 1], [0, 1,  0], [-1, 0, 0]]
$rotz = Matrix[[0, -1, 0], [1, 0,  0], [ 0, 0, 1]]

def rotate(v, rot)
    [
        v,
        rot * v,
        rot * rot * v,
        rot.adjugate * v,
    ]
end

def transform(v)
    [
        v ,
        $rotx * v,
        $rotx * $rotx * v,
        $rotx.adjugate * v,
        $roty * v,
        $roty.adjugate * v,
    ].flat_map{rotate(it, $rotz)}
end

TRANS = [
     -> (v) { Vector[ v[0],  v[1],  v[2]] },    # ( 1, 2, 3)
     -> (v) { Vector[-v[1],  v[0],  v[2]] },    # (-2, 1, 3)
     -> (v) { Vector[-v[0], -v[1],  v[2]] },    # (-1,-2, 3)
     -> (v) { Vector[ v[1], -v[0],  v[2]] },    # ( 2,-1, 3)
     -> (v) { Vector[ v[0], -v[2],  v[1]] },    # ( 1,-3, 2)
     -> (v) { Vector[ v[2],  v[0],  v[1]] },    # ( 3, 1, 2)
     -> (v) { Vector[-v[0],  v[2],  v[1]] },    # (-1, 3, 2)
     -> (v) { Vector[-v[2], -v[0],  v[1]] },    # (-3,-1, 2)
     -> (v) { Vector[ v[0], -v[1], -v[2]] },    # ( 1,-2,-3)
     -> (v) { Vector[ v[1],  v[0], -v[2]] },    # ( 2, 1,-3)
     -> (v) { Vector[-v[0],  v[1], -v[2]] },    # (-1, 2,-3)
     -> (v) { Vector[-v[1], -v[0], -v[2]] },    # (-2,-1,-3)
     -> (v) { Vector[ v[0],  v[2], -v[1]] },    # ( 1, 3,-2)
     -> (v) { Vector[-v[2],  v[0], -v[1]] },    # (-3, 1,-2)
     -> (v) { Vector[-v[0], -v[2], -v[1]] },    # (-1,-3,-2)
     -> (v) { Vector[ v[2], -v[0], -v[1]] },    # ( 3,-1,-2)
     -> (v) { Vector[ v[2],  v[1], -v[0]] },    # ( 3, 2,-1)
     -> (v) { Vector[-v[1],  v[2], -v[0]] },    # (-2, 3,-1)
     -> (v) { Vector[-v[2], -v[1], -v[0]] },    # (-3,-2,-1)
     -> (v) { Vector[ v[1], -v[2], -v[0]] },    # ( 2,-3,-1)
     -> (v) { Vector[-v[2],  v[1],  v[0]] },    # (-3, 2, 1)
     -> (v) { Vector[-v[1], -v[2],  v[0]] },    # (-2,-3, 1)
     -> (v) { Vector[ v[2], -v[1],  v[0]] },    # ( 3,-2, 1)
     -> (v) { Vector[ v[1],  v[2],  v[0]] },    # ( 2, 3, 1)
]


e1 = transform(v)
e2 = TRANS.map{ it.call(v)}

p e1 == e2

p e2


Pos = Struct.new(:x, :y) do
  def manhattan = x.abs + y.abs
end

p1 = Pos.new(12, -7)

p p1, p1.manhattan