class GeneticAlgorithm
  def initialize(sample_num:nil,gtype_length:nil,generation:nil,coding_table:nil)
    @@sample_num = sample_num
    @@generation = generation
    @@gtype_length = gtype_length

    @coding_table = coding_table

    @inital_group = []
    @cost_array_history = []
    @group_history = []

    initial_production()
    puts "\n"+"Initial group".center(100,"-")
    p @inital_group
  end

  def ga_flow()
    cost_array = []
    step_group = []
    for i in 0..@@generation-1 do 
      if i == 0
        cost_array= calculate_cost(@inital_group)
        step_group = reproduction(group:@inital_group, cost_array:cost_array)
        puts "\n"+"InitialCost".center(100,"-")
        p cost_array
      else
        cost_array= calculate_cost(step_group)
        step_group = reproduction(group:step_group, cost_array:cost_array)
      end
      step_group = single_crossover(step_group)
      step_group = mutation(step_group)

      @group_history.push step_group
      @cost_array_history.push cost_array
    end

    puts "\n"+"GroupHistory".center(100,"-")
    @group_history.each{|h| p [h]}
    puts "\n"+"CostHistory".center(100,"-")
    @cost_array_history.each{|h| p [h]}
  end

  
  private 
    def initial_production
      for i in 0..@@sample_num-1 do
        random = Random.new().rand(0..@@gtype_length-1)
        @inital_group.push @coding_table.keys[random]    
      end    
    end

    def calculate_cost(group)
      cost = []
      for i in 0..group.length-1 do
        cost.push cost_function(@coding_table[group[i]])
      end
      return cost
    end

    def cost_function(x)
        y = Math.sin(x)**3 + 0.5 * x
    end

    def reproduction(group:nil,cost_array:nil)
      reproduced_group = []
      max_cost = cost_array.max
      weight_array = cost_array.map{ |cost| cost/ cost_array.sum}
      elite_sample = group[cost_array.find_index{|c| c== max_cost}]
      reproduced_group.push elite_sample
      r = rand; s = 0
      (@@sample_num - 1).times do
        reproduced_group.push group[roulette(weight_array)]
      end
      return reproduced_group
      
    end

    def roulette(weightlist)
      r = rand
      s = 0
      weightlist.map.with_index{|a,i|[s+=a,i]}.select{|s,i|s>r}.first[1]
    end
  
    def single_crossover(group)
      group_list = []
      group_return_list = []
      list = (0..group.length-1).to_a

      mother_sample_index = list.sample
      mother_sample = group[mother_sample_index]
      list.delete(mother_sample_index)

      father_sample_index = list.sample
      father_sample = group[father_sample_index]
      slicepoint = (0..mother_sample.length-1).to_a.sample


      fronfragment_mother = mother_sample[0..slicepoint]
      fronfragment_father = father_sample[0..slicepoint]

      replace_mother_sample = fronfragment_father+mother_sample.slice(slicepoint+1..mother_sample.length-1)
      replace_father_sample = fronfragment_mother+father_sample.slice(slicepoint+1..father_sample.length-1)


      group.map.with_index do |g,i|
        if i == g.index(mother_sample)
          group_list.push(replace_mother_sample)
        else
          group_list.push(g)
        end
      end
      group_list.map.with_index do |g,i|
        if i == g.index(father_sample)
          group_return_list.push(replace_father_sample)
        else
          group_return_list.push(g)
        end
      end
      return group_return_list
    end
  
    def mutation(group)
      group_return_list = []
      mutation_sample_index = (0..group.length-1).to_a.sample
      mutation_gene = group[mutation_sample_index].dup
      mutation_gene_index = (0..group[0].length-1).to_a.sample

      mutation_gene[mutation_gene_index] == '1' ? mutation_gene[mutation_gene_index] = '0' : mutation_gene[mutation_gene_index] = '1'

      group.map.with_index do |g,i|
        if i == mutation_sample_index
          group_return_list.push(mutation_gene)
        else
          group_return_list.push(g)
        end
      end
      return group_return_list
    end
  



end