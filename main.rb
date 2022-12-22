require './Codings'
require './GeneticAlgorithms'

GENE_LENGTH = 5
SAMPLE_NUM = 10
XMIN = 1
XMAX = XMIN + 10
GTYPE_LENGTH = 2**GENE_LENGTH
GENERATION = 3

coding = Coding.new(gene_length:GENE_LENGTH, xmin:XMIN, xmax:XMAX,gtype_length:GTYPE_LENGTH)


puts "NoramlCodingTable".center(100,"=")
p coding.return_binray_codings
puts "GrayCodingTable".center(100,"=")
p coding.return_gray_codings


##スタートをランダムにしているので、初期値は同期していない
puts "\n"+"NoramlCoding".center(100,"=")
ga_normal = GeneticAlgorithm.new(sample_num:SAMPLE_NUM,gtype_length: GTYPE_LENGTH,generation:GENERATION,coding_table:coding.return_binray_codings)
ga_normal.ga_flow()
puts "*"*100+"\n\n"

puts "\n"+"GrayCoding".center(100,"=")
ga_gray = GeneticAlgorithm.new(sample_num:SAMPLE_NUM,gtype_length: GTYPE_LENGTH,generation:GENERATION,coding_table:coding.return_gray_codings)
ga_gray.ga_flow()
puts "*"*100+"\n\n"














