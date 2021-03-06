require "../lib/matriz.rb"

class DSLMatrices
    attr_accessor :operandos, :op, :tipos, :resultado
    
    def initialize (operador, &bloque)
	@operandos = []
	@op = operador
	@tipos = []
	@resultado
	
	instance_eval &bloque
    end
    
    def to_s
	"#{@resultado}"
    end
    
    def operando (matriz)
	t = tipos.pop
	if (t == "densa")
	    m = Densa.new(matriz.size**0.5, matriz.size**0.5, matriz)
	else
	  if (t == "dispersa")
	    m=Dispersa.new(matriz[0],matriz[0],matriz[1],matriz[2],matriz[3])
	  end
	end
	@operandos << m
	
	if (@operandos.size ==2)
	  operador
	end
	
	if (op == "max" || @op == "min")
	  operador
	end
    end
    
    def tipo (txt)
      @tipos << txt
    end
    
    def operador
      if (@operandos.size == 2)	
	if (@operandos[0].instance_of?Dispersa and @operandos[1].instance_of?Dispersa)
	  @resultado = Dispersa.new(@operandos[0].filas, @operandos[0].columnas, [],[],[])	
	else
				@resultado=Densa.new(@operandos[0].filas, @operandos[0].columnas, nil)	
	end		      
      end
      
   
      if (@op == "suma")	
	@resultado = (@operandos[0] + @operandos[1])	
      end	      
	
      if (@op == "resta")	
	@resultado = (@operandos[0] - @operandos[1])	
      end      
	
      if (@op == "max")	
	@resultado = (@operandos[0]).maximo	
      end      
	
      if (@op == "min")	
	@resultado = (@operandos[0]).minimo
      end	
    end
end


prSuma = DSLMatrices.new("suma") do
	tipo "densa"
	operando [1,2,3,4]
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end

prSumaDns = DSLMatrices.new("suma") do
	tipo "densa"
	operando [1,2,3,4]
	tipo "densa"
	operando [1,2,3,4]
end
prResta = DSLMatrices.new("resta") do
	tipo "densa"
	operando [1,2,3,4]
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end

prRestaDns = DSLMatrices.new("resta") do
	tipo "densa"
	operando [1,2,3,4]
	tipo "densa"
	operando [1,2,3,4]
end

prRestaDisp2 = DSLMatrices.new("resta") do
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
	tipo "dispersa"
	operando [2,[1,0],[1,0],[3,5]]
end

prMinDensa = DSLMatrices.new("min") do
	tipo "densa"
	operando [1,2,3,4]
end

prMinDispersa = DSLMatrices.new("min") do
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end

prMaxDensa = DSLMatrices.new("max") do
	tipo "densa"
	operando [1,2,3,4]
end

prMaxDispersa = DSLMatrices.new("max") do
	tipo "dispersa"
	operando [2,[1,0],[1,0],[4,5]]
end





puts "Suma: "
puts prSuma
puts "Resta: "
puts prResta
puts "Suma densas"
puts prSumaDns
puts "Resta densas: "
puts prRestaDns
puts "Resta Disp "
puts prRestaDisp2
puts "Min Densa"
puts prMinDensa
puts "Min Dispersa "
puts prMinDispersa
puts "Max Densa"
puts prMaxDensa
puts "Max Dispersa "
puts prMaxDispersa

