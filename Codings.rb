class Coding 
  def initialize(gene_length:nil, xmin:nil, xmax:nil, gtype_length:nil)
    @@gene_length = gene_length
    @@xmin = xmin
    @@xmax = xmax
    @@gtype_length = gtype_length
    @binary_codings = {}
    @gray_codings = {}
  end

  def return_binary_codings
    for i in 0...@@gtype_length do
      binary =  i.to_s(2).rjust(@@gene_length,'0').reverse
      phenotype_value = @@xmin + i * ((@@xmax-@@xmin).to_f/2**@@gene_length)
      phenotype_value = sprintf("%.3f",phenotype_value).to_f
      @binary_codings[binary] =  phenotype_value
    end
    @binary_codings
  end

  def return_gray_codings
    for i in 0...@@gtype_length do
      binary = @binary_codings.keys[i]
      gray = ""
      for k in 0...@@gene_length do
        binary_k1 = binary[k].to_i #0 or 1 のinteger
        binary_k2 = binary[k+1].to_i
        unless k == @@gene_length - 1 then
          gray << (binary_k1 ^ binary_k2).to_s
        else
          gray << binary[k]
        end
      end
      @gray_codings[gray] = @binary_codings[@binary_codings.keys[i]]
    end
    @gray_codings
  end
end