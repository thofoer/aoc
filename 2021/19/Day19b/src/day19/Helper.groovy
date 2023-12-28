package day19

class Helper {

    static List<Integer> best;

    static  search(path, tf) {
        if (path[-1]==0) {
            if (best==null || path.size() < best.size()) {
                best = path;
            }
            return path;
        }
        else if (best==null || best.size()>path.size()) {
            def pos = path[-1];
            def next = [];
            tf[pos].eachWithIndex{  entry,  i -> if (entry!=null && !(i in path) ) {next<<i}};
             next.collect{ search(path+it, tf)};

            return best;
        }
    }

    static List<Integer> findPath(n, tf) {
        best=null;
       return  search([n], tf );
    }

    static def Integer maxDistance(List<Scanner> sc) {
        def res = [];
        (0..sc.size()-1).each { n->
            (0..sc.size()-1).each { m->
                if (m<n) {
                    def d = sc.get(n).origin.diff(sc.get(m).origin);
                    res << Math.abs(d.x)+ Math.abs(d.y)+ Math.abs(d.z);
                }
            }
        }
        return res.max();
    }
}
