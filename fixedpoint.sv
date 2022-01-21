class fixed #(int isize = 24, int fsize = 8);
    signed bit [isize-1:0] ivalue;
    signed bit [fsize-1:0] fvalue;
    
    function new(signed int ivalue);
        self.ivalue = ivalue;
        fvalue = 0;
    endfunction //new()
    
    function add(fixed other);
        ivalue
        
    endfunction

    function real to_real();
        return $itor(this.isize) + $itor(this.fvalue) / $pow(2, fsize);
    endfunction
endclass //fixed

//23 bits of data

typedef fixed #(.isize(24), .fsize(8))fixed24x8;

typedef fixed #(.isize(16), .fsize(8))fixed24x8;
