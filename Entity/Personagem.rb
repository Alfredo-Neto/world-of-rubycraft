class Personagem
   attr_accessor :nome, :classe, :ataques, :atributos, :tipo

   def to_hash(options={})
      {
         nome: @nome,
         classe: @classe,
         ataques: @ataques,
         atributos: @atributos,
         tipo: @tipo
      }
  end

  def to_json(*options)
      to_hash(*options).to_json(*options)
  end
end