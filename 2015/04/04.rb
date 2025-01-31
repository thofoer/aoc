require "digest"

md5base = Digest::MD5.new 
md5 = md5base
md5base << "iwrupvqb"    

i = 0
until md5.hexdigest.start_with?("00000")
    i+=1    
    md5 = md5base.dup    
    md5 << i.to_s
end
p i

i = 0
until md5.hexdigest.start_with?("000000")
    i+=1    
    md5 = md5base.dup    
    md5 << i.to_s
end
p i